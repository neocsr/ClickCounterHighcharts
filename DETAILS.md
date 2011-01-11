DETAIL
======

Simple demo using Highcharts.
Simple text banners and click counter

PREREQUISITES
=============
- ruby 1.8.7
- gem 1.3.7
- rails 2.3.8

SCAFFOLDS
=========

- ruby script/generate nifty_scaffold Banner name:string counter:integer index new edit destroy
- `ruby script/generate nifty_scaffold Click banner_id:integer ip_address:string publisher_key:string latitude:float longitud:float index new edit destroy`

POPULATE
========
- nano lib/tasks/populate.rake

TASKS
=====

- rake db:migrate
- rake db:populate


TODO
=====
- Reproduce behavior from managers point of view
- CanCan
- i18n



Ignore from here.

LEGACIES (Not in use now)
========
                            
[Optional]
> sudo gem install rapt --no-ri --no-rdoc (fork of script/plugin)
> rapt install <plugin_name>
> rapt install memory_test_fix

To support tests in memory
> ruby script/plugin install git://github.com/lda/memory_test_fix.git
> EDIT: config/database.yml

To support ENUMs:
> ruby script/plugin install git://github.com/zargony/activerecord_symbolize.git
  (http://github.com/zargony/activerecord_symbolize)
    targetings->  symbolize :gender, :in => [:female, :male]
    targetings->  symbolize :device, :in => [:android, :iphone, :ipad, :pc]
    targetings->  symbolize :age_range, :in => [:0,:13,:20,:30,:45]
    campaigns->   symbolize :delivery_type, :in => [:fast, :normal]
    campaigns->   symbolize :test, :in => [:true, :false]
    campaigns->   symbolize :active, :in => [:true, :false]
    resources->   symbolize :object_type, :in => [:mix, :audio, :video, :image]
    biddings->    symbolize :type, :in => [:true, :false]
    products->    symbolize :type, :in => [:web, :native]
    
    Categories-> Initial data [:medical, :books, :business, :education, :finance,
                                :entertainment, :games, :fitness, :productivity, :photography,
                                :news, :music, :utilities, :lifestyle, :travel, :reference, :food, :other]

 =======================
 = USER AUTHENTICATION =
 =======================

http://github.com/rubyist/aasm
> sudo gem install aasm --no-ri --no-rdoc

http://github.com/technoweenie/restful-authentication
(http://avnetlabs.com/rails/restful-authentication-with-rails-2)
> ruby script/plugin install git://github.com/technoweenie/restful-authentication.git
  rename: restful-authentication -> restful_authentication
> ruby script/generate authenticated user sessions --include-activation --stateful --aasm
  vendor/plugins/restful_authentication/init.rb < require 'aasm'
> rake db:migrate:up VERSION=20100603091225
> EDIT: config/environments/development.rb -> SITE_URL = "192.168.4.43:3002"
> EDIT: config/environment.rb(action_mailer), config/routes.rb, models/user_mailer.rb
> TEST: http://host:port/users/new (create admin user)

http://code.google.com/p/rolerequirement/
http://github.com/timcharper/role_requirement
(http://eric.lubow.org/2009/ruby/rails/checking-roles-in-views-using-rolerequirement/)
(http://net.tutsplus.com/tutorials/ruby/getting-started-with-restful-authentication-in-rails/) GOOD!
(http://railsonedge.blogspot.com/2008/03/rails-forum-restful-authenticationpart.html)
> ruby script/plugin install git://github.com/timcharper/role_requirement.git
> script/generate roles Role User (This modifies the User model user.rb and creates a migration for a Role model).
> rake db:migrate:up VERSION=20100607021706
> ruby script/console
    u=User.find(1) r=Role.new r.name="admin" r.save
    u.roles << Role.find_by_name("admin")

admin:  crake -> test123
user:   kevin -> test123

 ===============
 = Breadcrumbs =
 ===============
 http://szeryf.wordpress.com/2008/06/13/easy-and-flexible-breadcrumbs-for-rails/
 
application_controller.rb:

  class ApplicationController < ActionController::Base
    ...
  protected
    def add_breadcrumb name, url = ''
      @breadcrumbs ||= []
      url = eval(url) if url =~ /_path|_url|@/
      @breadcrumbs << [name, url]
    end
  
    def self.add_breadcrumb name, url, options = {}
      before_filter options do |controller|
        controller.send(:add_breadcrumb, name, url)
      end
    end
  end

layout:
  <% if @breadcrumbs %>
    You are here:
    <% @breadcrumbs[0..-2].each do |txt, path| %>
      <%= link_to(h(txt), path) %> >
    <% end %>
    <%= h(@breadcrumbs.last.first) %>
  <% end %>
  
controllers:
  class ApplicationController < ActionController::Base
    add_breadcrumb 'Home', '/'
    ...
  end
  class ThingsController < ApplicationController
    add_breadcrumb 'Things', 'things_path'
    add_breadcrumb 'Create a new thing', '', :only => [:new, :create]
    add_breadcrumb 'Edit a thing', '', :only => [:edit, :update]
  
    def show
      @thing = Thing.find(params[:id])
      add_breadcrumb @thing.name, ''
    end
    ...
  end


 =============
 = SCAFFOLDS =
 =============

> ruby script/generate controller Root
> ruby script/generate scaffold product publisher_id:integer name:string key:string detail:string
> ruby script/generate model Channel detail:string
> ruby script/generate scaffold campaign advertiser_id:integer delivery_type:string test:string active:string name:string description:text start:datetime end:datetime url:string phone:string

> ruby script/generate model Targeting campaign_id:integer device:string gender:string age_range:string
> ruby script/generate model Bidding campaign_id:integer bid_type:string current_budget:integer current_bid:integer daily_limit:integer


> ruby script/plugin install git://github.com/technoweenie/attachment_fu.git
> ruby script/generate scaffold resource campaign_id:integer resource_type:string content_type:string filename:string thumbnail:string size:integer width:integer height:integer children:integer
  resource types: html5bundle, video, image, audio, playlist

 ==============
 = Ajax Forms =
 ==============
> Note: Makes js.erb to send escaped JavaScript. Something like before('<div></div>') fails because "<" and ">" are escaped
> jQuery form plugin:
http://github.com/malsup/form
http://jquery.malsup.com/form/#ajaxSubmit
$("#new_resource").ajaxSubmit({
  beforeSubmit: function(formData, jqForm, options) {
    options.dataType = 'script'; // 'xml', 'script', or 'json' (expected server response type) 
    options.url += '.js'; // !!!Important to get *.js.erb
    },
  complete: function(XMLHttpRequest, textStatus) {
    //$('#uploaded_image').attr('src', XMLHttpRequest.responseText);
    },
});

 =======
 = CSS =
 =======
<p> tags and <div> tags are naturally displayed block-style. To change their behavior we should use "display: inline"

 =======
 = DRY =
 =======
> http://blog.bleything.net/2006/06/27/dry-out-your-database-yml

login: &login
  adapter: mysql
  username: username
  password: password
  host: mysql.example.com

development:
  <<: *login
  database: app_dev

test:
  <<: *login
  database: app_test

production:
  <<: *login
  database: app_prod

 ==================
 = Sessions in DB =
 ==================
 Helps to fix the annoying problem in Safari with Sessions.
> rake db:sessions:create
> config/environment.rb:
  config.action_controller.session_store = :active_record_store   
  
 ==========================
 = Disable Warning in Mac =
 ==========================
 Attachment Fu causes a warning:
 
> echo "ENV['RUBYCOCOA_THREAD_HOOK_DISABLE']='1'" > config/initializers/disable_rubycocoa_warning.rb

 ========
 = i18n =
 ========
 
 Textmate Plugin
> sudo gem install httparty ruby-hmac ya2yaml
> git clone git://github.com/ryanstout/rails_i18n.tmbundle.git "Rails i18n.tmbundle"
> osascript -e 'tell app "TextMate" to reload bundles'
 
                                                       
 
From the old CAAD Server
========================

(http://www.xml.com/pub/a/2006/04/19/rest-on-rails.html)
(http://www.hackido.com/2009/11/install-ruby-on-rails-on-ubuntu-karmic.html)

Linux: sudo aptitude install libmysqlclient-dev

sudo gem install rails --include-dependencies

MacPorts:
http://paulsturgess.co.uk/articles/show/46-using-macportsdarwinports-to-install-ruby-on-rails-mysql-subversion-capistrano-and-mongrel-on-mac-os-x

Mac: IMPORTANT: http://hivelogic.com/articles/compiling-ruby-rubygems-and-rails-on-snow-leopard
Mac: sudo port install rb-mysql
Mac: export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH
Mac: sudo gem update --system
Mac: sudo port install postgresql83 postgresql83-server
Mac: export PATH=/opt/local/lib/postgresql83/bin:${PATH}
Mac: env ARCHFLAGS="-arch x86_32" sudo gem install pg
Mac: sudo gem install pg --no-rdoc --no-ri
Mac: sudo gem install ruby-pg
Mac: sudo gem install mongrel --no-rdoc --no-ri
Mac: sudo gem update --system
Mac: sudo env ARCHFLAGS="-arch x86_32" gem install mysql -- --with-mysql-config=/usr/local/mysql/bin/mysql_config


sudo gem install mysql --no-rdoc --no-ri
sudo gem install ruby-pg --no-rdoc --no-ri
sudo aptitude install libopenssl-ruby (gem_original_require: no such file to load -- net/https)
(https://help.ubuntu.com/community/RubyOnRails)
sudo gem install rails --remote
export PATH=/var/lib/gems/1.8/bin:$PATH
rails -v 
mkdir Advertisement
mkdir Advertisement/Scripts
cd Advertisement/
rails CAADServer
ruby script/server -p 3000
rake db:schema:load

#======
RMagick
#======

Ubuntu 9.10 
===========
(http://snippets.dzone.com/posts/show/8967)
sudo aptitude install imagemagick librmagick-ruby libmagick-dev libmagickwand-dev
sudo gem install rmagick --no-rdoc --no-ri

Snow Leopard
============
(http://onrails.org/articles/2009/09/04/rmagick-from-source-on-snow-leopard)
(rmagick-build.sh)
sudo port install ImageMagick
sudo port install rb-rmagick
sudo gem install rmagick --no-rdoc --no-ri

Test
====
require 'RMagick'
#=> true
require 'rvg/rvg'
#=> true
include Magick
#=> Object

#======
GeoRuby
#======

Ubuntu 9.10 
===========
(http://georuby.rubyforge.org/)
sudo gem install GeoRuby --no-rdoc --no-ri
require 'geo_ruby'
#========================
Spatial Adapter for Rails
#========================

Ubuntu 9.10 
===========
(http://georuby.rubyforge.org/)
ruby script/plugin install git://github.com/fragility/spatial_adapter.git
(ruby script/plugin install svn://rubyforge.org/var/svn/georuby/SpatialAdapter/trunk/spatial_adapter)

#========================
Geokit
#========================
(http://geokit.rubyforge.org/readme.html)
sudo gem install geokit --no-rdoc --no-ri
rake gems:install
require 'geokit'
$>environment.rb <- config.gem "geokit"

ruby script/plugin install git://github.com/andre/geokit-rails.git

#========================
YM4R/GM 
#========================
sudo gem install ym4r --no-rdoc --no-ri
ruby script/plugin install svn://rubyforge.org/var/svn/ym4r/Plugins/GM/trunk/ym4r_gm
(Google Map Key -> ABQIAAAAkfKQnX8ySFxnjXDyN4NQKhT2yXp_ZAY8_ufC3CFXhHIE1NvwkxTzUIqa8qDYg9R4cfbtGJ7RyyUTGg)

#========================
Attachment_fu
#========================
(http://clarkware.com/cgi/blosxom/2007/02/24)
RMagick
ruby script/plugin install http://svn.techno-weenie.net/projects/plugins/attachment_fu/
ruby script/plugin install git://github.com/technoweenie/attachment_fu.git

ALTER TABLE `caad`.`adlocations` 
ADD SPATIAL INDEX `LOCATION` (`geo_loc` ASC) ;



#========================
Password hashing Bcrypt
#========================
#(http://www.zacharyfox.com/blog/ruby-on-rails/password-hashing)
#Copy "password.rb" to "lib" directory
(http://media.pragprog.com/titles/msenr/password.pdf)
sudo gem install bcrypt-ruby --no-rdoc --no-ri
$>environment.rb <- require 'bcrypt'

require 'bcrypt'
class Advertiser < ActiveRecord::Base
  def password
    @password ||= BCrypt::Password.new(self.hashed_password)
  end
  
  def password=(new_password)
    @password = BCrypt::Password.create(new_password, :cost => 10)
    self.hashed_password = @password
  end
  
  def self.authenticate(name, plain_password)
    if user = self.find_by_name(name)
      user = nil if user.password != plain_password
    end
    user
  end
end

#======
MySQL
#======
create database caad;
grant all on caad.* to 'caadsys'@'localhost' identified by 'skillup';

backup: # mysqldump -u root -p[root_password] [database_name] > dumpfilename.sql
restore:# mysql -u root -p caad < adserv.sql

#rake db:create RAILS_ENV='development'
ruby script/generate scaffold advertiser name:string login:string hashed_password:string
ruby script/generate scaffold ad advertiser_id:integer ad_text:string start:datetime duration:datetime timestamp:datetime compensation_model:integer interactivity_type:integer device_type:string color_mask:string upload_ip:string test:integer keywords:string url:string phone:string description:string
ruby script/generate scaffold adlocation geo_loc:point geo_lon:double geo_lat:double ad_id:integer address:string zip:string
(attachment_fu)ruby script/generate scaffold banner color:string uri:string type:integer ad_id:integer parent_id:integer content_type:string filename:string thumbnail:string size:integer width:integer height:integer

rake db:migrate
ruby script/generate controller user login private
rake db:migrate:up VERSION=20100309052003
rake db:migrate:down VERSION=20100311070153

curl -H "Accept: application/xml" -i -X GET http://localhost:3000/advertisers/1
curl -H "Content-type: application/xml" -H "Accept: application/xml" \
-i -X GET -d "<?xml version='1.0' encoding='UTF-8'?><banner> \
<id>1</id><ad_id>1</ad_id> \
</banner>" http://127.0.0.1:3000/banners

#========
Resources
#========
http://www.ankoder.com/api/
http://gist.github.com/214133
http://developer.admob.com/wiki/Requests
http://code.google.com/p/adwhirl/wiki/SDKInstructions211
http://www.adwhirl.com/instructions
http://blog.admob.com/2009/03/page/2/

http://www.adwhirl.com/instructions
http://www.frankodwyer.com/blog/?p=355
http://www.billeisenhauer.com/examples/geokit#finders
http://ym4r.rubyforge.org/tutorial_ym4r_georuby.html
http://ym4r.rubyforge.org/
http://ym4r.rubyforge.org/tutorial_traffic.html

INSERT INTO `ads` (id,advertiser_id,ad_text,interactivity_type,url,phone,description) 
VALUES (1,1,'Pizza Hut','1','http://www.4008123123.com/','4008123123','The Best Delivery'),
(2,2,'Haagendazs','1','http://www.haagendazs.com.cn/news/news_prom_1001vday.html','800-820-7917','The Night of Romance'),
(3,3,'Quanjude Beijing Duck','1','http://www.quanjude.com.cn/direct.php?optionid=19','010-6701-1379','Enjoy the Best Pekin Duck');

Charts:
http://railsontherun.com/2007/10/4/sexy-charts-in-less-than-5-minutes/
http://www.amcharts.com/
http://www.maani.us/xml_charts/index.php
http://ziya.liquidrail.com/docs/index.html
http://nubyonrails.com/pages/gruff

#==============
Quick Debugging
#==============
(http://www.infinitecube.com/?p=5=1)
(http://weblog.jamisbuck.org/2007/2/5/nesting-resources)
(http://slash7.com/2006/12/21/secrets-of-the-rails-console-ninjas/)
$> ruby script/console [environment]
>> helper.link_to "this", "that"
=> <a href="that">this</a>
>> helper :my_custom_helper
>> include ActionController::UrlWriter
=> Object
>> banners_path
>> banner = Banner.find(:first)
>> helper.link_to "Show", banner_path(banner)
=> "<a href=\"/banners/1\">Show</a>"
>> app.users_path
>> helper.text_field(:book, :title)

# restart without quit
>> Dispatcher.reset_application!
or
>> reload!

select id,advertiser_id,ad_text from ads;
select id,ad_id,filename from banners;

advertiser_ads(ad)

http://transfs.com/devblog/2009/06/26/nested-forms-with-rails-2-3-helpers-and-javascript-tricks/
skillup / pajarito

http://maps.google.com/maps?f=q&source=s_q&hl=en&q=&vps=2&jsv=212a&sll=39.982242,116.306125&sspn=0.012101,0.026135&g=39.982242++%09116.3061249&ie=UTF8&geocode=FaIUYgIdzbDuBg&split=0

http://maps.google.com/maps?f=q&source=s_q&hl=en&q=&vps=2&jsv=212a&sll=39.982242,116.3061249&g=39.982242++%09116.3061249&geocode=FaIUYgIdzbDuBg&split=0

http://maps.google.com/maps?f=q&source=s_q&hl=en&q=39.982242,116.306125&sll=39.982242,116.306125

http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=39.982242,116.306125&sll=39.982242,116.306125&sspn=0.013252,0.032487&ie=UTF8&ll=39.983138,116.306119&spn=0.006626,0.016243&t=h&z=16&iwloc=A

http://maps.google.com/maps?f=q&source=s_q&hl=en&geocode=&q=39.982242,116.306125&sll=39.982242,116.306125

find(:all, :origin => @somewhere, :within => 5, :conditions=>['state=?',state])
find_within(distance, :origin => @somewhere)
find_beyond(distance, :origin => @somewhere)
find_closest(:origin => @somewhere)
find_farthest(:origin => @somewhere)


#==============
API
#==============
(http://kkaempf.blogspot.com/2009/05/designing-restful-api-for-yast.html)
(http://www.ankoder.com/api/)
(http://hinchcliffe.org/archive/2008/01/10/16613.aspx)

On Load: CREATE
Get Current Location and IP address from iPhone

http://localhost:3000/Requests.xml

ruby script/generate scaffold target id:integer ip:string geo_lat:float geo_lon:float timestamp:datetime banner_type:integer pub_keywords:string pub_key:string closest_lat:float closest_lon:float distance:float banner_url:string ad_url:string ad_phone:string ad_googlemap_url:string
ruby script/generate migration add_click_to_targets ad_click:integer
ruby script/generate migration add_text_description_to_targets ad_text:string ad_description:string
ruby script/generate migration add_ids_to_targets banner_id:integer ad_id:integer

ruby script/generate scaffold gpslocation loc:point lat:float lon:float description:string 
ruby script/generate migration add_details_to_gpslocation search_keywords:string classification:string display_english:string display_japanese:string
update gpslocations SET search_keywords = 'conbini' where description like '%circle%';


__________________________User_______________
ip
geo_lat
geo_lon
timestamp
banner_type
__________________________Publisher__________
pub_keywords: kids / adults
pub_key
__________________________CAAD Server(SDK)___
id
closest_lat
closest_lon
distance
banner_id
banner_url
ad_id
ad_url
ad_phone
ad_googlemap_url
ad_click
ad_text
ad_description


On Display: SHOW
- Get available "Ads" within an area (origin: gps/ip geocode, distance:km)  filtered by our recommendation engine (keywords, ip, timestamp).

On Touch:
- Get "n" closest "Adlocations" from an "Ad".


#========================
Active Resource
#========================
(http://www.weromans.com/mingle_comments_activeresource)
sudo gem install activeresource --no-ri --no-rdoc


curl http://localhost:3000/clusters/300.xml
<?xml version="1.0" encoding="UTF-8"?>
<adlocation>
  <ad-id type="integer">1</ad-id>
<address>&#21271;&#20140;&#26397;&#38451;&#21306;&#19996;&#30452;&#38376;&#22806;&#22823;&#34903;27&#21495;</address>
  <geo-lat type="float">116.4455719</geo-lat>
  <geo-loc type="geometry">#&lt;GeoRuby::SimpleFeatures::Point:0x2625258&gt;</geo-loc>
  <geo-lon type="float">39.9412934</geo-lon>
  <id type="integer">300</id>
  <zip nil="true"></zip>
</adlocation>

curl http://localhost:3000/clusters.xml?search=closest
<?xml version="1.0" encoding="UTF-8"?>
<adlocation>
  <ad-id type="integer">3</ad-id>
  <address>&#21271;&#20140;&#24066;&#28023;&#28096;&#21306;&#35199;&#32736;&#36335;9&#21495;</address>
  <distance type="">6979.8334887225</distance>
  <geo-lat type="float">116.2834219</geo-lat>
  <geo-loc type="geometry">#&lt;GeoRuby::SimpleFeatures::Point:0x2565ef8&gt;</geo-loc>
  <geo-lon type="float">39.9105056</geo-lon>
  <id type="integer">353</id>
  <zip nil="true"></zip>
</adlocation>

curl -v -H "Content-Type: application/xml; charset=utf-8" --data-ascii @createAd.xml http://localhost:3000/ads.xml

http://maps.google.com/maps/api/staticmap?zoom=14&size=512x512&maptype=roadmap&markers=color:blue|label:S|39.9074,116.443&markers=color:red|color:red|label:C|39.9097,116.44&sensor=false

http://maps.google.com/maps/api/staticmap?
center=39.9074,116.443&
zoom=16&
size=480x320&
maptype=roadmap&
markers=color:blue|label:S|39.9074,116.443&
markers=color:red|color:red|label:C|39.9097,116.44&
sensor=false

http://maps.google.com/maps/api/staticmap?center=39.9074,116.443&zoom=16&size=480x320&maptype=roadmap&markers=color:blue|label:S|39.9074,116.443&markers=color:red|color:red|label:C|39.9097,116.44&sensor=false

http://maps.google.com/maps/api/staticmap?center=39.9074,116.443&
zoom=16&
size=480x320&
maptype=roadmap&
markers=color:blue|label:S|39.9074,116.443&
markers=color:red|color:red|label:C|39.9097,116.44&
sensor=false

#==============
iPhoneification
#==============
(http://jameswilding.net/2009/08/10/iphone-on-rails/)
(http://www.slashdotdash.net/2007/12/04/iphone-on-rails-creating-an-iphone-optimised-version-of-your-rails-site-using-iui-and-rails-2/)

config/initializers/mime_types
Mime::Type.register_alias "text/html", :iphone
ruby script/plugin install git://github.com/jameswilding/iphoneification.git

#==============
Radiant
#==============
sudo gem install radiant --no-rdoc --no-ri


#==============
BrowserCMS
#==============
(http://groups.google.com/group/browsercms/browse_thread/thread/8c4d95b7f9f0c038/c0b22aa04c3925fc?lnk=gst&q=windows#c0b22aa04c3925fc)
sudo gem install browsercms

Linux, Mac:
rails MyBrowserCMS -d mysql -m http://browsercms.org/templates/demo.rb (MySQL)
"WILL FAIL" -> Edit "database.yml" to update the password of the DB. Then re-run the command without overwriting the files.

rails MyBrowserCMS -m http://browsercms.org/templates/demo.rb (SQLite)

cd my_new_project_name
script/server
rake  db:create

Windows: (Ruby MUST BE IN THE SAME DRIVE as the Application)
rails MyBrowserCMS -d sqlite3 -m demo.rb
cd MyBrowserCMS
rake db:create
ruby script\generate browser_cms
ruby script\generate browser_cms_demo_site
rake db:migrate

#==============
DataTables
#==============
(http://github.com/phronos/rails_datatables)
ruby script/plugin install git://github.com/phronos/rails_datatables.git

#==============
Will_paginate
#==============
(http://nasir.wordpress.com/2007/10/31/pagination-in-ruby-on-rails-using-will_paginate-plugin/)
(http://workingwithrails.com/railsplugin/4765-will-paginate)
ruby script/plugin install svn://errtheblog.com/svn/plugins/will_paginate

http://rd.skillupjapan.net/content/BBB360_300k.mp4
http://rd.skillupjapan.net/content/BBB360_500k.mp4
http://rd.skillupjapan.net/content/china_300k.mp4
http://rd.skillupjapan.net/content/china_500k.mp4
http://rd.skillupjapan.net/content/suj.mp4
http://rd.skillupjapan.net/content/movies/6/FujiTV.m4v
http://rd.skillupjapan.net/content/movies/4/Did_You_Know_4.mp4
http://rd.skillupjapan.net/content/movies/5/fight.mp4
http://rd.skillupjapan.net/content/movies/1/suj.mp4


#==============
OpenX
#==============
(http://github.com/touchlocal/openx)
sudo aptitude install php5 php5-gd

'agency' is now known as a 'manager'
    * Advertiser
    * Banner
    * Campaign
    * Manager (Agency)
    * Publisher
    * User
    * Zone

sudo ln -s /home/crake/Advertisement/openx-2.8.5/www/ openx

sudo gem install touchlocal-openx --source "http://gemcutter.org"

Ruby
# Load it using
require 'rubygems'
gem 'touchlocal-openx'
require 'openx'

Rails
config.gem "touchlocal-openx", :lib => "openx", :source => "http://gemcutter.org"

svn add config/credentials.yml
svn add config/initializers/openx.rb

#==============
Maxmind GeoIP
#==============
sudo aptitude install libgeoip-dev
net-geoip-0.07$ruby extconf.rb
require 'net/geoip'
#Net::GeoIP::TYPE_DISK                 >> access type constant
Net::GeoIP::TYPE_RAM                  >> access type constant

g = Net::GeoIP.new(Net::GeoIP::TYPE_RAM)
g = Net::GeoIP.open('../GeoIPCityjp.dat')

g.geoip_record_by_name('skillup.co.jp')

gem install geoip 

require 'geoip'
geo = GeoIP.new('#{RAILS_ROOT}/app/geoip/GeoLiteCity.dat')
geo = GeoIP.new('GeoIP-132jp_20100301/GeoIPCityjp.dat')
g = geo.city('google.com')

g[0]  #hostname
g[1]  #ip
g[2]  #countrycode
g[4]  #country
g[7]  #city
g[8]  #postalcode
g[9]  #latitude
g[10] #longitude 

#!/bin/sh
curl -g http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz > GeoLiteCity_20100408.dat.gz
gunzip -d /tmp/GeoLiteCity.dat.gz
mv /tmp/GeoLiteCity.dat /yourlocation/ 


#==============
New Design
#==============

Admob:
- Advertiser: Get his info. Registration and authentication
- Campaigns: 
	Campaign Info
		Campaign Name:  
		Start:
		End:
		Daily Budget:
		Delivery Method: 
			Standard - Show ads evenly through the day    
			Accelerated - Show ads as quickly as possible
		Campaign Note:
- Ad Group Goal:
 	What do you want to promote?
	Mobile website
		Drive traffic to your mobile website. For example: http://m.google.com, http://m.cnn.com, etc.
	Application
		Drive downloads of your app.
		Please select an application platform:
	    * iPhone
	    * Android
	Media
		Promote a video or iTunes Store listing.
		Please select a media type:
		    * Audio (iTunes)
		    * Video (Streaming or Download Video)
	Location & Utilities
		Promote a local business with Click-to-Call, Click-to-Maps and iPhone Search ad types.
		Please select a utility:
		    * Click-to-Call
		    * Click-to-Map
		    * Search
	Ad Group Name: 
- Targeting
	Platforms / Devices
		Target all devices
		Target devices by platform or operating system (OS)
			Android
			iPhone
			Symbian
			Windows Mobile
			webOS
			BlackBerry
		    * iPhone and iPod Touch
		          o iPhone and iPod Touch
		                + iPhone
		                      # Original iPhone (2G)
		                      # iPhone 3G
		                      # iPhone 3G S
		                + iPod Touch
		                      # First generation (2007)
		                      # Second generation (2008)
		                      # Third generation (2009)
			Android versions
				Min:
				Max:
			iPhone OS versions
				Min:
				Max:
			Target devices by manufacturer
			Target devices by capability
				Flash Lite
				Java MIDP 1.0
				Java MIDP 2.0
			Video playback (streaming/download)
			Flash Lite options
			Minimum supported version:
			Maximum supported version:
			Target devices by device model
				Enter the brand name and model name of the device you'd like to target and then press "Search". To search for multiple devices, enter each device on its own line.
			Your Targeted Devices
	Geography / Operators
		Target all geographic locations
		Target specific geographic locations
		  At this time, you cannot target a country and a sub-country region or territory simultaneously. Please create another ad group if you need to do this.
		Target all traffic, including Wi-Fi traffic
		Target Wi-Fi traffic only
		Target mobile operator traffic
	Demographics
		Customize
			If you change any option here, your ad group will appear only on sites that provide demographic information to AdMob. As a result, you will receive significantly fewer impressions.
		Gender
			All users
			Male users only
			Female users only
		Age Groups
			All age groups
			Specific age groups
			18-24
			25-34
			35-44
			45-54
			55-64
			65+
		Device Search Results
		Unmatched Handsets
	Default Bid: $0.03
- Creative & Bid

- An ontology is a formal representation of the knowledge by a set of concepts within a domain and the relationships between those concepts. 
- Semantics is the study of meaning, usually in language.
- The Semantic Web is an evolving development of the World Wide Web in which the meaning (semantics) of information and services on the web is defined, making it possible for the web to "understand" and satisfy the requests of people and machines to use the web content.
