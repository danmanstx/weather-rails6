# README

## Requirements:
	•	Must be done in Ruby on Rails
	•	Accept an address as input
	•	Retrieve forecast data for the given address. This should include, at minimum, the current temperature (Bonus points - Retrieve high/low and/or extended forecast)
	•	Display the requested forecast details to the user
	•	Cache the forecast details for 30 minutes for all subsequent requests by zip codes. Display indicator if result is pulled from cache.


## Dependencies 

software needed to run, as i'm on mac some of this was installed with homebrew or thru package managers like `asdf` or `rvm`, i used a combination of both. Best practice is probably just to use `asdf` for everything. 
```
node 18.12.1
yarn
ruby 3.2.1
postgresql@15
redis
```
as i was developing on a `m1` macbook i created `arm64-darwin-20` version so to be able to deploy on [render](https://render.com) i needed to run the following commands 
```
bundle lock --add-platform ruby
bundle lock --add-platform x86_64-linux
```
similarly with the various db/redis/api keys, i used `.dotenv` locally to store these `ENV VARS` as secrets and also set them up for [render](https://render.com) like i would for a production enviroment. 


## `ENV VARS` needed 

```
WEATHER_RAILS_DATABASE_PASSWORD=xxxxxxxxx
REDIS_URL=redis://server:6379/1
RAILS_MAX_THREADS=4
NODE_ENV=<env>
RACK_ENV=<env>
RAILS_ENV=<env>
GOOGLE_PLACE_API=xxxxxxxxxxxxxxxxxxxxxxxxxxx
OPEN_WEATHER_API=xxxxxxxxxxxxxxxxxxxxxxxxxx
```

## database creation 

after setting up postgresql you should be able to run the following:

```
bundle exec rails db:create 
bundle exec rails db:migrate 
``` 

## running the server locally
i created an alias to made sure webpacker and node ran smoothly, basically adding `NODE_OPTIONS=--openssl-legacy-provider` if you get issues about openssl and legacy versions. If you don't wanna do that, `node 16` or similar will likely work.
In one terminal i'd run
`NODE_OPTIONS=--openssl-legacy-provider ./bin/webpack-dev-server`
another 
`rails s`
and when messing with sidekiq in another
`bundle exec sidekiq`

This can also be accomplished with a `.proc` file and run with foreman

## Test Suite
the app is using `rspec` for testing, following commands will run worth for the first run, after that you should just be able to run the `rspec` command, `RAILS_ENV=test bundle exec` in front can never hurt too
```
RAILS_ENV=test bundle exec rails db:create
RAILS_ENV=test bundle exec rails db:migrate
RAILS_ENV=test bundle exec rspec spec/
```
## Services 
two APIs were defined for this project as service objects 

[Open Weather API](https://openweathermap.org/api) -- need to sign up for API key for access (is free for light use)
[Government Weather API](https://www.weather.gov/documentation/services-web-api) -- no API required 

there was/is a sidekiq worker to fire off and populate a forecast, but ultimately wasn't used in the final app. the job was left behind for possible future development. 


## Deployment to [Render](render.com)

this is actually super easy, after creating an account, you can use the free teir for a web service, redis, and postgresql. From there you can connect your github account to render, and use the supplied urls for both psql and redis as `env` vars. 
