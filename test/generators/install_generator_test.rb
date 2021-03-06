require "test_helper"
require "rails/generators/test_case"
require "generators/guachiman/install/install_generator"

class InstallGeneratorTest < Rails::Generators::TestCase
  DESTINATION = File.expand_path File.join(File.dirname(__FILE__), "..", "..", "tmp")
  FileUtils.mkdir_p(DESTINATION) unless Dir.exist?(DESTINATION)

  destination DESTINATION

  tests Guachiman::Generators::InstallGenerator
  setup :prepare_destination

  self.test_order = :sorted

  def prepare_destination
    if Dir.exist?("#{ DESTINATION }/app")
      FileUtils.rm_r("#{ DESTINATION }/app")
    end

    FileUtils.mkdir_p("#{ DESTINATION }/app/models")
  end

  def test_create_authorization_model
    run_generator

    assert_file "app/models/authorization.rb" do |f|
      assert_match(/include Guachiman/, f)
    end
  end
end
