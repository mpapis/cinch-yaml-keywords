Gem::Specification.new do |s|
  s.name        = 'cinch-yaml-keywords'
  s.version     = '1.1.0'
  s.summary     =
  s.description = 'A Cinch plugin to define keywords and display description when keyword matches, keywords are saved in yaml file for persistence.'
  s.authors     = ['Michal Papis']
  s.email       = ['mpapis@gmail.com']
  s.homepage    = 'https://github.com/mpapis/cinch-yaml-keywords'
  s.files       = Dir['LICENSE', 'README.md', 'lib/**/*']
  s.required_ruby_version = '>= 1.9.1'
  s.add_dependency("cinch", "~> 2")
end
