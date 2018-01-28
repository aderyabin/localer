# frozen_string_literal: true

module Localer
  module Ext
    # Extend Hash through refinements
    module Hash
      refine ::Hash do
        # From ActiveSupport http://api.rubyonrails.org/classes/Hash.html#metho
        def deep_merge!(other_hash)
          other_hash.each_pair do |current_key, other_value|
            this_value = self[current_key]

            if this_value.is_a?(::Hash) && other_value.is_a?(::Hash)
              this_value.deep_merge!(other_value)
              this_value
            else
              self[current_key] = other_value
            end
          end

          self
        end

        def deep_merge(other_hash, &block)
          dup.deep_merge!(other_hash, &block)
        end

        def deep_symbolize_keys!
          deep_transform_keys! do |key|
            begin
              key.to_sym
            rescue StandardError
              key
            end
          end
        end

        def deep_symbolize_keys
          deep_transform_keys do |key|
            begin
              key.to_sym
            rescue StandardError
              key
            end
          end
        end

        def deep_downcase_keys
          deep_transform_keys do |key|
            begin
              key.downcase
            rescue StandardError
              key
            end
          end
        end

        def deep_transform_keys(&block)
          _deep_transform_keys_in_object(self, &block)
        end

        def deep_transform_keys!(&block)
          _deep_transform_keys_in_object!(self, &block)
        end

        private

        def _deep_transform_keys_in_object!(object, &block)
          case object
          when ::Hash
            object.keys.each do |key|
              value = object.delete(key)
              object[yield(key)] = _deep_transform_keys_in_object!(value, &block)
            end
            object
          when Array
            object.map! { |e| _deep_transform_keys_in_object!(e, &block) }
          else
            object
          end
        end

        # support methods for deep transforming nested hashes and arrays
        def _deep_transform_keys_in_object(object, &block)
          case object
          when ::Hash
            object.each_with_object({}) do |(key, value), result|
              result[yield(key)] = _deep_transform_keys_in_object(value, &block)
            end
          when Array
            object.map { |e| _deep_transform_keys_in_object(e, &block) }
          else
            object
          end
        end
      end
    end
  end
end
