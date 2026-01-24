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
* Added rich text `description` (Action Text)
* Added `featured_image` uploads (Active Storage)
* Added basic styling via Propshaft (CSS) and reviewed import maps / Hotwire
* Added I18n with locale switching via `?locale=` and translated index title
* Added inventory tracking (`inventory_count`) + validation (no negatives)
* Built subscriber flow for out-of-stock products (nested routes + flash notice)
* Implemented “back in stock” emails with Action Mailer (`deliver_later`)
* Added notification logic (callback) and extracted to a Concern (`Product::Notifications`)
* Added unsubscribe via signed token + UnsubscribesController + email links
* Added tests:

  * emails sent when inventory goes from 0 → positive
  * mailer test coverage
  * fixtures for products/subscribers
* Verified code quality/security: RuboCop + Brakeman
* Noted CI with GitHub Actions + deployment workflow with Kamal (including Solid Queue guidance)

---

## Purpose

This project exists as a hands-on Rails revision effort following my application for a Ruby on Rails Software Engineer role. Development will continue daily with incremental improvements and commits.
