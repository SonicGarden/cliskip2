cliskip2
========

A Ruby wrapper for the SKIP2 REST APIs

## Installation
    gem install cliskip2

## Configration
    Cliskip2.configure do |config|
      config.endpoint = 'http://localhost:3000'
      config.consumer_key = YOUR_CONSUMER_KEY
      config.consumer_secret = YOUR_CONSUMER_SECRET
      config.xauth_username = SKIP2_ADMIN_USER_NAME
      config.xauth_password = SKIP2_ADMIN_USER_PASSWORD
    end
