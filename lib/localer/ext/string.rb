# frozen_string_literal: true

module Localer
  module Ext
    # Extend Hash through refinements
    # taken from https://github.com/seamusabshere/to_regexp
    module String
      INLINE_OPTIONS = /[imxnesu]*/
      REGEXP_DELIMITERS = {
        '%r{' => '}',
        '/' => '/'
      }.freeze

      refine ::String do
        def literal?
          REGEXP_DELIMITERS.none? { |s, e| start_with?(s) && self =~ /#{e}#{INLINE_OPTIONS}\z/ }
        end

        def to_regexp(options = {})
          if args = as_regexp(options)
            ::Regexp.new(*args)
          end
        end

        def as_regexp(options = {})
          raise ::ArgumentError, "[to_regexp] Options must be a Hash" unless options.is_a?(::Hash)
          str = self

          return if options[:detect] && (str == '')

          if options[:literal] || (options[:detect] && str.literal?)
            content = ::Regexp.escape str
          elsif delim_set = REGEXP_DELIMITERS.detect { |k, _| str.start_with?(k) }
            delim_start, delim_end = delim_set
            /\A#{delim_start}(.*)#{delim_end}(#{INLINE_OPTIONS})\z/u =~ str
            content = Regexp.last_match(1)
            inline_options = Regexp.last_match(2)
            return unless content.is_a?(::String)
            content.gsub! '\\/', '/'
            if inline_options
              options[:ignore_case] = true if inline_options.include?('i')
              options[:multiline] = true if inline_options.include?('m')
              options[:extended] = true if inline_options.include?('x')
              # 'n', 'N' = none, 'e', 'E' = EUC, 's', 'S' = SJIS, 'u', 'U' = UTF-8
              options[:lang] = inline_options.scan(/[nesu]/i).join.downcase
            end
          else
            return
          end

          ignore_case = options[:ignore_case] ? ::Regexp::IGNORECASE : 0
          multiline = options[:multiline] ? ::Regexp::MULTILINE : 0
          extended = options[:extended] ? ::Regexp::EXTENDED : 0
          lang = options[:lang] || ''
          lang = lang.delete 'u' if (::RUBY_VERSION > '1.9') && lang.include?('u')

          if lang.empty?
            [content, (ignore_case | multiline | extended)]
          else
            [content, (ignore_case | multiline | extended), lang]
          end
        end
      end
    end
  end
end
