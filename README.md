# Search
====
The search feature uses Elastic Search. The advantages Elastic Search has over basic searching with SQL queries are
1. Extra whitespaces - where dishwasher matches dish washer
2. Misspellings - it rials matches rails
3. Highly scallable

In addition to searching by title and body, I've added an autocomplete feature on the body of Questions.

To get search working on development, you'll have to install elastic search:

`brew install elasticsearch`

Then start elasticseach by running:

`brew services start elasticsearch`

It is advisable to reindex in development and production after adding Questions so the search feature delivers accurate results. You can do so with: `rake searchkick:reindex:all` on the terminal.
