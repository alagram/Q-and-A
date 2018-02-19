Overview
===

Users can auth with Google, submit, questions and answers. Both question and answer bodies are in markdown.

# Search
The search feature uses ElasticSearch. The advantages ElasticSearch has over basic searching with SQL queries are:

1. Extra whitespaces - where dishwasher matches dish washer
2. Misspellings - it rials matches rails
3. Highly scallable

In addition to searching by title and body, I've added an autocomplete feature on the body of Questions.

To get search working on development, you'll have to install elastic search:

`brew install elasticsearch`

Then start elasticseach by running:

`brew services start elasticsearch`


# Action Cable
ActionCable has been used to allow updates to answers to display automatically. It is done through ActiveJob with Sidekiq, and a service object. It is fully tested and I think it's a very interesting feature as it shows other ways of making good use of ActionCable that aren't a chat app.

The way is works is that, given a question, if any other user should post an answer it will display automatically without the user having to refresh their page.


# Other features
Questions and answers can be updated. Pagination has been added to the questions index page to help users with navigating questions easily should the number of questions increase.


How to get started:

* run `bundle install` to install gem dependencies.

* run `rake db:create:all` and `rake db:migrate` to create databases and run migrations


* run `PORT=300 foreman start -m web=1,worker=2 -f Procfile.dev`

* run `rspec` to run entire test suite.
