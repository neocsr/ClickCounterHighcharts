namespace :db do 
  desc "Erase and fill database"
  task  :populate => :environment do
    require 'populator'
    
    [Banner, Click].each(&:delete_all)
    
    Banner.populate 20 do |banner|
      banner.name = Populator.words(1..3).titleize
      Click.populate 10..100 do |click|
        click.banner_id = banner
        click.ip_address = (1..20).map{|x| "192.168.4.#{x}"}
        click.publisher_key = ['AAFF', 'FFVV', 'TTSS']
      end
    end
    
  end
end