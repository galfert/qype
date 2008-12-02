# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{qype}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Florian Munz"]
  s.date = %q{2008-12-02}
  s.description = %q{The official Ruby Library for interacting with the Qype API.}
  s.email = %q{florian@qype.com}
  s.extra_rdoc_files = ["lib/httparty_patch.rb", "lib/qype/models.rb", "lib/qype.rb", "LICENSE", "README.markdown"]
  s.files = ["lib/httparty_patch.rb", "lib/qype/models.rb", "lib/qype.rb", "LICENSE", "Rakefile", "README.markdown", "test/fixtures/place.xml", "test/fixtures/places.xml", "test/fixtures/review.xml", "test/fixtures/reviews.xml", "test/place_mapping_test.rb", "test/review_mapping_test.rb", "test/test_helper.rb", "Manifest", "qype.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/qype/qype}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Qype", "--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{qype}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{The official Ruby Library for interacting with the Qype API.}
  s.test_files = ["test/place_mapping_test.rb", "test/review_mapping_test.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
