module BannersHelper
  def click_series(clicks, date)
    clicks_by_day = clicks.find(:all, 
                                :conditions => {:created_at => date..Date.today},
                                :group => 'date(created_at)',
                                :select => 'date(created_at) as day, count(id) as counter'
                                ) #.map{|c| c['counter']}.inspect
    (date..Date.today).map do |day|
      click = clicks_by_day.detect { |c| c['day'] == day.to_s } # Careless comparison!
      (click && click['counter']) || 0
    end.inspect     
  end
end

#(date..Date.today).map {|date| Click.total_on(date)}.inspect
    
#c = Click.all(:conditions => ["date(created_at) IN (?)", (1.week.ago.to_date)..(Date.today)], :limit => 1) 
# SELECT * FROM "clicks" WHERE (date(created_at) IN ('2011-01-05','2011-01-06','2011-01-07','2011-01-08','2011-01-09','2011-01-10','2011-01-11','2011-01-12')) LIMIT 1

#c = Click.all(:conditions => {:created_at => (1.week.ago.to_date)..(Date.today)}, :limit => 1)
# SELECT * FROM "clicks" WHERE ("clicks"."created_at" BETWEEN '2011-01-05' AND '2011-01-12') LIMIT 1

#c = Click.all(:group => "date(created_at)")
