# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "project_overview_page/version"
require "project_overview_page/infos"

Gem::Specification.new do |spec|
  spec.name          = "redmine-project_overview_page"
  spec.version       = ProjectOverviewPage::VERSION
  spec.authors       = ProjectOverviewPage::Infos::AUTHORS.keys
  spec.email         = ProjectOverviewPage::Infos::AUTHORS.values
  spec.summary       = ProjectOverviewPage::Infos::DESCRIPTION
  spec.description   = ProjectOverviewPage::Infos::DESCRIPTION
  spec.homepage      = ProjectOverviewPage::Infos::URL
  spec.license       = ProjectOverviewPage::Infos::LICENSE

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 4.2.0"
  spec.add_dependency "redmine-more_view_hooks"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rubocop"
end
