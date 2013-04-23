# rr_publish

Used for Rubber Ring publishing.

this is the fork of original [rbackup](https://github.com/winton/rbackup) from Winton Welsh. Thanks!

## Installation

Add this line to your application's Gemfile:

    gem 'rr_publish', :git => 'TODO'

And then execute:

    $ bundle

## Usage

Create YAML file like this

    site:
      server:
        source: /Users/me/site
        destination: deploy@server:/var/www
        exclude:
         - .git
         - /site/config/database.yml

Run the code with path to the YAML file

    RRPublish::Sync.new('path/to/yaml').run
