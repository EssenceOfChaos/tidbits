# Tidbits

A working demo of an Elixir/Phoenix application that attempts to follow best practices while implementing many of the modern features found in web applications.

## Features

  * User authentication & authorization using JSON Web Tokens [JWT](https://jwt.io/) via the [Guardian](https://github.com/ueberauth/guardian) library.
  * Database persistence with [Postgres](https://www.postgresql.org/), including modeling `has_many` and `belongs_to` relationships, input validation, and default values. We'll  also use trigger procedures and `pg_notify` to create a real-time pub/sub feature, pushing updates to the UI from the database.
  * Support for standard CRUD operations via a RESTful API. Authentication prevents users from editing or deleting posts that they did not create themselves.
  * Real-time bidirectional communication via [Phoenix Channels](https://hexdocs.pm/phoenix/Phoenix.Channel.html#content), which utilize websockets.

  * *More coming soon...currently in active development*

---

## Run locally

  * Clone or download the repo
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:5000`](http://localhost:4000) from your browser.

## Links

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
