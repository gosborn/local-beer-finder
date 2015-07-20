# local-beer-finder

Sinatra app that uses info parsed from BreweryDB to randomly generate beer info based on current state.

Uses ActiveRecord to maintain data for states, breweries and beer.

Features that could be added: 
- defintiely some front-end styling
- some session persistence to save favorited beers 
- a age verifier
- geolocation
- some sort of tool to choose new beers based on characteristic of current beer: like a slider to choose more or less hoppy than current beer
- maybe some stats about the database? i.e. breweries per state, some nice visualization with D3?

Jul 20, 2015
And pretty sure I messed up the seeds file by playing around with rescuing errors...need to remember how to pass blocks to RestClient
