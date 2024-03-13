# frozen_string_literal: true

require_relative "lib/activerecord/originator/version"

Gem::Specification.new do |spec|
  spec.name = "activerecord-originator"
  spec.version = ActiveRecord::Originator::VERSION
  spec.authors = ["Masataka Pocke Kuwabara"]
  spec.email = ["kuwabara@pocke.me"]

  spec.summary = "Inject SQL comments to indicate the origin of the SQL."
  spec.description = "This gem injects comments to the SQL to indicate where the SQL parts are constructed."
  spec.homepage = "https://github.com/pocke/activerecord-originator"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", ">= 6.0"
  spec.add_dependency "activesupport", ">= 6.0"
end
