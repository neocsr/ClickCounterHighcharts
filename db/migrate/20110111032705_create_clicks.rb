class CreateClicks < ActiveRecord::Migration
  def self.up
    create_table :clicks do |t|
      t.integer :banner_id
      t.string :ip_address
      t.string :publisher_key
      t.float :latitude
      t.float :longitud
      t.timestamps
    end
  end

  def self.down
    drop_table :clicks
  end
end
