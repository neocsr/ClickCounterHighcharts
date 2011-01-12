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

