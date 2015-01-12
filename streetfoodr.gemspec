Gem::Specification.new do |s|
  s.name = 'streetfoodr'
  s.version = '0.0.1'
  s.date = '2015-01-11'
  s.summary = 'Wrapper for the streetfoodapp API'
  s.authors = ["Alla Hoffman"]
  s.email = "sm1th303@gmail.com"
  s.require_paths = ["lib"]
  s.files = ["lib/streetfoodr.rb"]
  s.license = "MIT"
  s.add_dependency 'rest-client', '~>1.7.2'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'vcr', '~>2.9.3'
  s.add_development_dependency 'webmock', '~>1.20.4'
end
