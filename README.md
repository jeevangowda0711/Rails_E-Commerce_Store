# Store — Rails E-commerce Revision Project

A small e-commerce style Rails application built to refresh and demonstrate my Ruby on Rails skills while preparing for Software Engineer (Ruby on Rails) roles.

This repository is developed in **daily iterations**, with progress tracked below.

---

## Tech Stack

* Ruby 3.2+
* Rails 8.1.0+
* SQLite (development)
* Rails Authentication (User + Session)

---

## Features (So Far)

* Product model with validation (`name` required)
* Full Products CRUD (index, show, new/create, edit/update, destroy)
* RESTful routing using `resources :products`
* Shared form partial for New & Edit
* Authentication with role-based access:

  * Public: product index & show
  * Auth required: create, edit, update, delete
* Conditional UI based on authentication state

---

## Local Setup

```bash
git clone <REPO_URL>
cd store

bin/rails db:create
bin/rails db:migrate
bin/rails server
```

Visit: [http://localhost:3000](http://localhost:3000)

---

## Authentication

Create a user via Rails console:

```bash
bin/rails console
```

```ruby
User.create!(
  email_address: "you@example.com",
  password: "password",
  password_confirmation: "password"
)
```

Login: [http://localhost:3000/session/new](http://localhost:3000/session/new)

---

## Progress Log

### Day 1 — Rails Fundamentals & Product CRUD

* Initialized Rails app and database
* Implemented Product model, migration, and validations
* Built full CRUD flow with controllers, routes, and views
* Refactored controller logic using `before_action`
* Added Rails authentication and access control
* Updated UI to respect authentication state

---

## Purpose

This project exists as a hands-on Rails revision effort following my application for a Ruby on Rails Software Engineer role. Development will continue daily with incremental improvements and commits.
