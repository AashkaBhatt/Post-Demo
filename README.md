# Steps to install

1. Installation manual
Follow these steps to setup the application.

  1.1 Software requirements
    The following minimum setup is required:

    Ruby version: 3.0.0
    Rails Version: 6.0.3
    Database: Postgresql

  1.2 Setup
    Follow steps to run the application.

    bundle install
    rails webpack:install
    rails webpack:compile
    yarn install --check-files
    rails db:create
    rails db:migrate
    rails s
