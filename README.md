========
Supervisor
========

**WARNING!!!!**
* This gem is extremely rough. There are no tests of any kind. Use at your own risk!

Delayed Jobs Administration for the Masses! 

Built for/by [Contently](http://www.contently.com) by [thoughpunch](http://www.about.me/thoughtpunch)

## Description

**Supervisor** is a Sinatra-based web front-end for managing [Delayed Jobs](https://github.com/collectiveidea/delayed_job) heavily inspired by the excellent [delayed_job_web](https://github.com/ejschmitt/delayed_job_web) gem.

What makes **Supervisor** unique is that it can be run in one of two modes. 'Gem' mode runs the mounted Sinatra app inside your Rails app via a route. 'Stand Alone' mode can be run from the same server or even a different location, provided that you configure the database settings to connect to the instance that is storing the delayed jobs. It's a Sinatra app, it's a Gem, it's a Sinatra app inside a gem!

## Installation

    gem install 'supervisor'

## Usage

**Gem Mode**
* Mount the Sinatra app in your route.rb file like so:
* ```match "/jobs" => Supervisor::App, :anchor => false```

**Stand Alone Mode**
* Cloning the entire repo into its own directory.
* Add Delayed Job database and host info in the ```config.yml``` file
* Run ``ruby supervisor_app.rb```
* **Supervisor** should be up and running on ```http://localhost:4567```

## Known Issues ##

1. Running as a gem inside a Rails app fails to display worker info.


## RoadMap

The overall goal is to allow full management of Delayed Jobs workers and tasks from both inside and outside a Rails App.
To do so *might* require stubbing enough Rails functionality that Delayed::Worker and Delayed::Command can run without error.

1. Make fully functional as stand alone app
    1. Ensure can use any ActiveRecord-supported database
2. Add PID/Daemon monitoring for Delayed Job Deamons
    1. Ability to restart jobs if not running from outside Rails app
3. Delayed Job log parsing/tailing
    1. Tail all delayed_job logs in the view via JS [like so](http://dojo4.com/blog/easy-cheasy-realtime-log-tailing-in-a-rails-admin-view)
4. Ability to edit jobs on the fly, individually or in bulk
    1. Change PID, queue, run_at
5. Delayed Jobs statistics and processing numbers
	1. Store jobs total and jobs per second while app is running, maybe store in YAML?
	2. Use request-log-analyzer for past dj stats (Note: Current version can not parse logs from Delayed Job v3.0 and later)
	3. Realtime Graphs and charts
6. Write Tests
    1. Integration tests for Sinatra App, unit tests for all modules and classes.
    2. Version lock all gems after testing

## Contributing

1. Fork it
2. Writer tests or extend functionality from the roadmap
3. Submit a pull request