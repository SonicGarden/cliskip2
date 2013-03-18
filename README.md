[![Dependency Status](https://gemnasium.com/SonicGarden/cliskip2.png)](https://gemnasium.com/SonicGarden/cliskip2)

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
    client.create_user :user => {:name => 'hoge', :email => 'hoge@hoge.com'}

### get the user by email
    client = Cliskip2::Client.new
    client.get_user :email => 'hoge@hoge.com'

### update the user by email
    client = Cliskip2::Client.new
    client.update_user :user => {:name => 'foobar', :email => 'hoge@hoge.com'}

### update the email by params_email
    client = Cliskip2::Client.new
    client.update_email 'before@hoge.com', 'after@hoge.com'

### delete the user by email
    client = Cliskip2::Client.new
    client.delete_user :user => {:email => 'hoge@hoge.com'}

### search communities by the community-name
    client = Cliskip2::Client.new
    client.search_communities({:search => {:name => 'I love ruby'} })

### get a community member
    client = Cliskip2::Client.new
    client.get_community_member(community, {:email => 'hoge@hoge.com'})

### join new member to the community
    client = Cliskip2::Client.new
    community = client.search_communities({:search => {:name => 'I love ruby'} }).first
    user = client.get_user :email => 'hoge@hoge.com'
    client.join_community(community, user)

### leave the member from the community
    client = Cliskip2::Client.new
    community = client.search_communities({:search => {:name => 'I love ruby'} }).first
    member = client.get_community_member(community, {:email => 'hoge@hoge.com'})
    client.leave_community(community, member)
