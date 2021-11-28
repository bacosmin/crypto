# README

#Requierments
You need to create a web page that renders a table that contains following data:
* Name of cryptocurrency. There will be a total of 4 of them.
* The cost of a single transaction in USD for this cryptocurrency. Formula will be given
below.
* The cost of a multisig transaction in USD for this cryptocurrency. Multisig transaction
cost is calculated by multiplying single transaction cost by some predefined factor specific to particular cryptocurrency.


 # setup
   * install redis(suggest to use docker)
     * docker run --restart unless-stopped -p 6379:6379 --name some-redis -d redis
   * have ruby 2.6.2 installed
   * install bundler
       * gem install bundler
   * bundle gems
     * bundle install
   * update database
     * rails db:create db:migrate db:seed
     
# project boot 
   * rails server 
   * bundle exec sidekiq
   * go to http://localhost:3000
 