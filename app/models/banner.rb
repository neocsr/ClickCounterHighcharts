class Banner < ActiveRecord::Base
  attr_accessible :name, :counter
  has_many :clicks
  
end
