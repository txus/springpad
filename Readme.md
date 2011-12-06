# springpad

Command-line client for [Springpad](http://springpadit.com). Currently WIP.

## Getting an API key

To use this, even to run the tests, you need to be registered at Springpad
(it's a free service) and also have an API key.

You can [register here](http://springpadit.com/) and [request an API key here](
http://springpadit.com/developers/oauth/register-app). They give them FAST (I
got mine the minute after sending the form, no kidding).

After that you have to create a `~/.springpad` file in a YAML format with this
data:

    user: YOUR_USERNAME
    password: YOUR_PASSWORD
    token: YOUR_CONSUMER_KEY

## Running the tests

Once you have the config file in place, you just have to:

    git clone git://github.com/txus/springpad
    cd springpad
    bundle install
    rake

You should see some serious green stuff going on!

## Who's this

This was made by [Josep M. Bach (Txus)](http://txustice.me) under the MIT
license. I'm [@txustice](http://twitter.com/txustice) on twitter (where you
should probably follow me!).
