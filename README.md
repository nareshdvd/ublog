# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  3.3.0
* Rails version
  2.7.2

* System dependencies
  Redis 7.0 or greater is required by sidekiq.

* Configuration

* Database creation
  rake db:create to create organizations and user_registry tables in primary database

* I have used rails built in sharding technique to create a new database every time a new organization gets created. Sidekiq job is created for doing this in background. After the database gets created, it automatically runs all the migrations for this db(shard).

* If a particular organization db needs to be connected from From rails console, follow:
  org = Organization.find_by(name: 'acme')
  Current.organization = org
* Afer that:
  - User and Post data can be fetched as per requirement
  - Organization needs to be created from console for now.
  - user creation is not available from UI. users have to be created from rails console:
    - org = Organization.find_by(name: 'acme')
    - Current.organization = org
    - user = User.new(email: 'test001@acme.com', password: '123456', password_confirmation: '123456')
    - user.save!
    - Once user is saved, an entry also gets entered into user_registries table, with organization_id and user_email. A column is_default has been added to user_registries table, so that the default organization can be determined at the time when user is trying to login to the system.
    - User can be part of multiple organizations, only one of them will be default.

* to run the application:
  - rails s -p 3000 from terminal.
  - visit lvh.me:3000 on browser, you will see a login screen
  - after login, it will automatically redirects to default organization subdomain for the logging in user.
  - User can only visit their default organization domain for now. If they try to visit any other domain, they will be redireced to their default domain automatically.

* Things to do
  - Pagination on posts listing screen, kaminari gem is added but not used.
  - Providing an admin panel
    - to perform CRUD operations for Organizations 
    - to perform CRUD operations for User registrations
    - sending emails to users on registering them to a given Organization
    - providing the users to switch between the organizations they are registered with
  - As I have sharded the organization data to different databases, filtering is not required on organization basis.
  - Haven't added specs. Need some more time to write specs.

* References taken from:
  - ChatGPT for db sharding, hotwire and stimulus
  - Google
  - Also went through ActiveRecord::MigrationContext and ActiveRecord::Migration files in Gem directory to figure out how to run migrations on a given db/shard at run time.
