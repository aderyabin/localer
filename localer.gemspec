
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "localer/version"

Gem::Specification.new do |spec|
  spec.name          = "localer"
  spec.version       = Localer::VERSION
  spec.authors       = ["Andrey Deryabin"]
  spec.email         = ["deriabin@gmail.com"]

  spec.summary       = %q{Automatic detecting missing I18n translations tool.}
  spec.description   = %q{Automatic detecting missing I18n translations tool.}
  spec.homepage      = "https://github.com/aderyabin/localer"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features|gemfiles)/})
  end
  spec.bindir        = "bin"
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "appraisal"
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 0.50"

  spec.add_dependency "thor", "~> 0.20.0"
  spec.add_dependency "dry-initializer", "~> 2.3.0"
end
