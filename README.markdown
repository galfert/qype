Qype API
--------

The official Ruby library for interacting with the Qype API.


Installation
------------

add github to your sources if you haven't

    gem sources -a http://gems.github.com

install required gems:

    sudo gem oauth
    sudo gem install jnunemaker-happymapper
    sudo gem install jnunemaker-httparty

Usage
-----

    qype = Qype::Client.new('your_api_key', 'your_api_secret')
    places = qype.search_places('sushi', 'Hamburg')
