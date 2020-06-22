require 'active_record'
require 'watir'
require_relative './models/scrap'
require_relative 'webscrapper'
def db_configuration
 db_configuration_file = File.join(File.expand_path('..', __FILE__), '..', 'db', 'config.yml')
YAML.load(File.read(db_configuration_file))
 end

 ActiveRecord::Base.establish_connection(db_configuration["development"])
 
 obj_web_scrapper=WebScrapper.new

 obj_web_scrapper.set_scraping_data('https://www.oyorooms.com/','Pune')