# Streetfoodr
Streetfoodr provides accress to [Street Food App](http://streetfoodapp.com/)'s
REST API.

##Installation
Install Streetfoodr

```bash
$ gem install streetfoodr
```

or add it to your Gemfile

```ruby
gem 'streetfoodr'
```

##API Reference

The streetfoodapp api documentation is located [here](http://streetfoodapp.com/api),
 but it's not totally accurate -
in particular, there aren't actually any API keys required at this time and the
locations GET url does not require a city.

##Examples of use

####Find all food trucks in a city

    require 'streetfoodr'  

    Streetfoodr::FoodTruck.get_city_trucks("boston")

####Find API identifier for a given food truck

    require 'streetfoodr'  

    Streetfoodr::FoodTruck.get_api_identifier_by_name("Stoked Wood Fired Pizza Co.", "boston")

####Find specific food truck's schedule

    require 'streetfoodr'  

    #API identifier, which is related to the name, but is usually not the same, then city
    truck = Streetfoodr::FoodTruck.new("stoked", "boston")

    truck.locations

####Find specific food truck's schedule from a past month/year

    require 'streetfoodr'  

    truck = Streetfoodr::FoodTruck.new("stoked", "boston")

    #year, then number of month
    truck.history(2013, 11)

##Contributing
This gem is still in beta, so there's plenty of fine-tuning to be done. Anyone who wants to contribute is welcome!
Feel free to fork the project, make your changes in a feature or bugfix branch, and send me a pull request.
However, please make sure that any code you send me has comprehensive tests.

##Boilerplate
This is release under the MIT license. I'm not affiliated with Street Food App, I just created this gem to help other
developers work with their API.
