require 'rails/plantuml/generator/model_generator'

OUTPUT_FILE = 'diagram_er.puml'

ASSOCIATION_TYPE = :association_type
ASSOCIATION_OTHER_CLASS = :other_class
ASSOCIATION_OTHER_NAME = :other_name
ASSOCIATION_TYPE_HAS_MANY = '*'
ASSOCIATION_TYPE_HAS_ONE = '1'

namespace :plantuml do
  desc "Pick a random user as the winner"
  task :generate, [:whitelist] => :environment do |t, args|
    Rails.application.eager_load!
    models = ActiveRecord::Base.connection.tables.map{|x|x.classify.safe_constantize}.compact

    generator = Rails::Plantuml::Generator::ModelGenerator.new models, args[:whitelist]

    File.open OUTPUT_FILE, 'w' do |file|
      generator.write_to_io file
    end
  end
end
