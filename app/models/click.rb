class Click < ActiveRecord::Base
  attr_accessible :banner_id, :ip_address, :publisher_key, :latitude, :longitud
  belongs_to :banner
  
  def self.total_on(date)
    #where("date(created_at) = ?", date).count
    find(:all,:conditions => ["date(created_at) = ?", date]).count
  end
  
end


