# RpcSql

Experimenting with remote procedure calls for SQL with JavaScript, Rails, and SQL.

## The vision

Make API call without creating the API using JS lib and a graphGL like SQL interface.

Here's an example of what the JavaScript so far:

```JavaScript
RpcSql('/api')
  .select('posts.id', 'email as author', 'title', 'body')
  .from('users')
  .join('posts', 'users.id', '=', 'posts.user_id')
  .orderBy('posts.id', 'desc')
  .post(callbackFn)
```

The interesting code is here:
- [Examples](https://github.com/buwilliams/rpcsql/blob/master/app/views/home/index.html.erb)
- [RpcSql JS library](https://github.com/buwilliams/rpcsql/blob/master/app/views/home/_rpcsql.html.erb)
- [RpcSql Ruby library](https://github.com/buwilliams/rpcsql/blob/master/app/services/rpc_sql.rb)

## The experiment

The questions are:

- Can the JS interface be enjoyable?
- Can the backend avoid SQL injection properly?
- How hard is this effort? Or is simply limiting the feature enough?

## Getting Started

- Clone repo
- bundle
- bundle exec rake db:create db:migrate
- bundle exec rails s
- Click the 'Submit'

## Context

Much of our work is in building screens which support our business. In our shop
we use a `mini-SPA` pattern. Instead of a SPA for the entire product we build
little apps for sections of our product. These little apps use UI frameworks
such as Vue.js. Often when requesting data from the backend you want the JSON
in a certain structure. This is because you don't want to organize the data once
you get it. Available API solutions are cumbersome, largely getting in the way.
I believe this is because most people are designing API technology with external
callers in mind. If however, you are consuming your own backend (as most of us
are) then the accepted approach is unnecessarily slow requiring you to write
serializers which cannot adapt to new requirements. SQL already does this
in a nice way. If you could send a SQL query via POST, you can easily get
different results in the a nice format.

Overview of a mini-SPA:
- Browser makes request to load "mini-SPA" view
- Vue.js and HTML template coded in a standard Rails view
- The mini-SPA calls JSON API to load initial data and future requests
- Users interacts with mini-SPA (Vue.js) until they leave the section

## Solution

It would be nice to focus solely on the front-end for most screens. You could
sit down and code up the Ajax calls with a backend API that is smart enough
to get you the data you are requesting with validation and authorization
keeping you safe.

grahpQL allows you to define your data in your post. Why not do the same thing
with SQL? We could have a common interface to describe the data we want to
retrieve or mutate.

## Approach

This project is a starting point for that solution.

- The goal is support a limited amount of SQL, just enough for querying.
- Define a JSON data format which converts nicely to SQL
- Create a small JS lib to interact with
- Build a simple API for the backend that can accept these requests
- Build a service which supports building SQL, handling errors, and removes possible SQL injection.
- If all that goes well then add authorization.

## Security Concerns

The most obvious concern with this approach is security, namely, SQL injection. I'm hoping to solve this in a two fold approach. 1. Limit SQL with a SQL-like data-structure. 2. White-list and validate data coming from client. I'm not a security expert, advice is welcome.
