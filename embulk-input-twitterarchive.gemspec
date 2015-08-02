
Gem::Specification.new do |spec|
  spec.name          = "embulk-input-twitterarchive"
  spec.version       = "0.1.0"
  spec.authors       = ["takuya sato"]
  spec.summary       = "Twitter Archive input plugin for Embulk"
  spec.description   = "Loads records from Twitterarchive."
  spec.email         = ["takuya0219@gmail.com"]
  spec.licenses      = ["MIT"]
  spec.homepage      = "https://github.com/nazo/embulk-input-twitterarchive"

  spec.files         = `git ls-files`.split("\n") + Dir["classpath/*.jar"]
  spec.test_files    = spec.files.grep(%r{^(test|spec)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', ['~> 1.0']
  spec.add_development_dependency 'rake', ['>= 10.0']
end
