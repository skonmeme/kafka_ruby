
Gem::Specification.new do |s|
  s.name          = 'kafka_ruby'
  s.version       = Kafka::VERSION
  s.platform      = Gem::Platform::RUBY
  s.authors       = ["Sung Gon Yi"]
  s.email         = "skonmeme@gmail.com"
  s.homepage      = "https://skonuniverse.com"
  s.license       = ["BSD-3-Clause"]
  s.summary       = "Kafka client"
  s.description   = "Kafka client"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.excutables    = `git ls-files -- bin/*`.split("\n").map { |file| File.basename(file) }
  s.require_paths = ["lib"]


end