namespace :db do 
  desc "Erase and fill database"
  task  :populate => :environment do
    require 'populator'
    
    [Banner, Click].each(&:delete_all)
    
    # Populate banners and clicks
    Banner.populate 20 do |banner|
      banner.name = Populator.words(1..3).titleize
      #banner.counter = (1..100).to_a
      Click.populate 10..100 do |click|
        click.banner_id = banner.id
        click.ip_address = (1..20).map{|x| "192.168.4.#{x}"}
        click.publisher_key = ['AAFF', 'FFVV', 'TTSS']
        click.created_at = 1.week.ago..Time.now
      end
    end
    
    # Update banners click count
    counters = Banner.find(:all, :select => 'count(*) as counter, "banners".id', :joins => :clicks, :group => '"banners".id')
    counters.each{|c| Banner.find(c.id).update_attributes({:counter => c.counter})}
    
    puts "Population success."
    
  end
end