
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ruboty/fortune/version"

Gem::Specification.new do |spec|
  spec.name          = "ruboty-fortune"
  spec.version       = Ruboty::Fortune::VERSION
  spec.authors       = ["h2owl"]
  spec.email         = ["huckruowl2@gmail.com"]

  spec.summary       = %q{this gem is a ruboty-plugin to get fortune of a day from yahoo}
  spec.description   = %q{this gem is a ruboty-plugin to get fortune of a day from yahoo. (only Japanese, as of now)}
  spec.homepage      = "https://github.com/h2owl/ruboty-fortune"

  ## Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  ## to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata["allowed_push_host"] = "http://example.com"

  #  spec.metadata["homepage_uri"] = spec.homepage
  #  spec.metadata["source_code_uri"] = "http://example.com"
  #  spec.metadata["changelog_uri"] = "http://example.com"
  #else
  #  raise "RubyGems 2.0 or newer is required to protect against " \
  #    "public gem pushes."
  #end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "ruboty"
  spec.add_development_dependency "nokogiri"

  spec.add_dependency "ruboty"
  spec.add_dependency "nokogiri"
end
