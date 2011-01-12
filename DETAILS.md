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

- ruby script/generate nifty_layout
- ruby script/generate nifty_scaffold Banner name:string counter:integer index show new edit destroy
- `ruby script/generate nifty_scaffold Click banner_id:integer ip_address:string publisher_key:string latitude:float longitud:float index new edit destroy`

POPULATE
========
- nano lib/tasks/populate.rake

TASKS
=====

- rake db:migrate
- rake db:populate

OPTIMIZE QUERIES
================

`c = Click.all(:conditions => ["date(created_at) IN (?)", (1.week.ago.to_date)..(Date.today)], :limit => 1) `
> `SELECT * FROM "clicks" WHERE (date(created_at) IN ('2011-01-05','2011-01-06','2011-01-07','2011-01-08','2011-01-09','2011-01-10','2011-01-11','2011-01-12')) LIMIT 1`

`c = Click.all(:conditions => {:created_at => (1.week.ago.to_date)..(Date.today)}, :limit => 1)`
> `SELECT * FROM "clicks" WHERE ("clicks"."created_at" BETWEEN '2011-01-05' AND '2011-01-12') LIMIT 1`

