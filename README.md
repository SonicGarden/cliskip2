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

## Examples
### get the authorized user
    client = Cliskip2::Client.new
    client.current_user

### create new user
    client = Cliskip2::Client.new
    client.post_user :user => {:name => 'hoge', :email => 'hoge@hoge.com'}

### get the user by email
    client = Cliskip2::Client.new
    client.get_user :email => 'hoge@hoge.com'

### update the user by email
    client = Cliskip2::Client.new
    puts client.put_user :user => {:name => 'foobar', :email => 'hoge@hoge.com'}
