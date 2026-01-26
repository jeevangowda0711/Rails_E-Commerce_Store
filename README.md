# Store — Rails E-commerce Revision Project

A small e-commerce style Rails application built to refresh and demonstrate my Ruby on Rails skills while preparing for Software Engineer (Ruby on Rails) roles.

This repository is developed in **daily iterations**, with progress tracked below.

---

## Tech Stack

* Ruby 3.2+
* Rails 8.1.0+
* SQLite (development)
* Solid Cache / Solid Queue (Rails defaults)
* Action Text + Active Storage
* Action Mailer

---

## Features

* Products: full CRUD with validations
* Authentication: product management restricted to authenticated users
* Rich product content: description (Action Text) + featured image (Active Storage)
* Inventory tracking + “back in stock” email notifications
* Subscribe / unsubscribe flow for out-of-stock products
* Performance: fragment caching for product show
* I18n: basic locale switching via query param
* Quality: tests (mail + inventory notifications), RuboCop, Brakeman
* Ops: GitHub Actions (lint/security/tests) and deployment notes via Kamal

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

## Progress Log

### Day 1 — Rails Fundamentals & Product CRUD

* Initialized Rails app and database
* Implemented Product model, migration, and validations
* Built full CRUD flow with controllers, routes, and views
* Refactored controller logic using `before_action`
* Added Rails authentication and access control
* Updated UI to respect authentication state

### Day 2 — Product Experience, Notifications, Testing, and Deployment Prep

* Added fragment caching for product show (dev cache toggle)
* Added rich text `description` (Action Text) + image uploads (Active Storage)
* Added inventory tracking + subscriptions + in-stock email notifications
* Added unsubscribe via signed token
* Added tests (mailer + inventory notification), verified RuboCop + Brakeman
* Noted CI (GitHub Actions) + deployment workflow (Kamal + Solid Queue)

### Day 3 — Sign Up and Settings (in progress)

* Added `first_name` and `last_name` to `User` (+ validations + `full_name`)
* Implemented Sign Up flow (`/sign_up`) with controller + form
* Restricted Sign Up to unauthenticated users only (`unauthenticated_access_only`)
* Added rate limiting for Sign Up POSTs
* Added Settings namespace:

  * Password settings at `/settings/password` (show + update)
  * Profile settings at `/settings/profile` (show + update)
  * Settings root redirects to profile
* Added nested Settings layout (`layouts/settings`) with sidebar navigation
* Refactored Settings controllers to inherit from `Settings::BaseController` (shared `layout "settings"`)
* Updated main navbar to show Settings / Logout when authenticated and Sign Up / Login when not
* Updated CSS selectors (`nav.navbar`) and added sidebar styles for Settings layout

---

## Purpose

This project exists as a hands-on Rails revision effort following my application for a Ruby on Rails Software Engineer role. Development will continue daily with incremental improvements and commits.
