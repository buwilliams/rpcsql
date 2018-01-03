# RpcSql

Experimenting with remote procedure calls for SQL in Rails.

## Getting Started

- Clone repo
- bundle
- bundle exec rake db:create db:migrate
- bundle exec rails s
- Click the 'Submit'

## Context

Much of our work is building mini-SPAs (single-page apps.) When building a
a mini-SPA often you want to get JSON in a certain structure. Available APIs
are cumbersome, largely getting in the way. I believe this is because most
people are designing API technology with outsiders in mind. If however, you
are consuming your own front-end (as most of us are) then this approach is
slow. If you make changes, you make changes on both sides of the app, the
front-end and backend.

Here's an example of mini-SPA:
- Browser makes request to load "mini-SPA"
- Vue.js and HTML template coded in a standard Rails view
- The mini-SPA calls JSON API to load initial data
- Users interacts with mini-SPA (Vue.js)

## Need

It would be nice to only focus on the front-end for most screens. You could
sit down and code up the Ajax calls with a backend API that is smart enough
to get you the data you are requesting with validation and authorization
keeping you safe.

grahpQL allows you to define your data in your post. Why not do the same thing
with SQL? We could have a common interface to describe the data we want to
retrieve or mutate.

## Approach

- Define a JSON data format which converts nicely to SQL
- Create a small JS lib to interact with
- Build a simple API for the backend that can accept these requests
- Build a service which supports building SQL, handling errors, validating
  the request, and authorization.
