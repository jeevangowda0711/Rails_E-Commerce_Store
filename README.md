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

### Storefront (Public + Authenticated Users)
* Products browsing: index + show pages (public)
* Rich product content: description (Action Text) + featured image (Active Storage)
* Inventory tracking:
  * “Out of stock” state
  * Subscribe form for back-in-stock alerts
* Email subscription flows:
  * Subscribe to product availability notifications
  * Unsubscribe via signed token link
* Performance: fragment caching on product show
* I18n: basic locale switching via `?locale=en|es`

### Authentication & User Account
* Authentication (sessions) with login/logout
* Sign Up flow (`/sign_up`) with:
  * first name + last name
  * rate limiting on Sign Up POSTs
  * sign up restricted to unauthenticated users only
* Settings area (nested layout + sidebar navigation):
  * Profile updates (`/settings/profile`)
  * Password updates with password challenge (`/settings/password`)
  * Email change + confirmation via signed token (`/settings/email`)
  * Account deletion (`/settings/user`)

### Admin / Store Management (Admins Only)
* Role-based access control:
  * `admin` flag on users, protected from updates (`attr_readonly`)
  * `admin_access_only` authorization guard
* Admin dashboards under `/store`:
  * Products CRUD (`/store/products`)
  * Users management (`/store/users`)
  * Wishlists viewer + filtering by user/product (`/store/wishlists`)
  * Subscribers viewer + filtering by product (`/store/subscribers`)
* Store sidebar navigation visible only to admins

### Wishlists
* Wishlists CRUD (`/wishlists`) owned by users
* Shareable wishlist URLs (friendly `to_param`)
* Add products to wishlists from product page
  * auto-creates default wishlist if user has none
* Manage wishlist items:
  * remove product from wishlist
  * move product between wishlists
* “Copy to clipboard” share button using Stimulus

### Quality, Tooling, and Ops
* Tests:
  * sign up, settings, email confirmations, admin access controls
  * wishlists + wishlist products flows + permissions
  * mailers and inventory notification behavior
* Lint + security: RuboCop + Brakeman
* CI: GitHub Actions (lint/security/tests)
* Deployment notes: Kamal + Solid Queue + Docker-based setup


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

### Day 4 — Accounts, Admin Roles, and Store/Admin Separation

- Added account deletion under Settings (`/settings/account`)
- Added email change flow with confirmation:
  - `unconfirmed_email` field
  - email verification via signed token
  - Email confirmation controller + mailer
- Introduced admin role:
  - `admin` flag on users
  - protected via `attr_readonly`
  - admin-only access guard via Authorization concern
- Added admin-only Users management:
  - Store namespace (`/store/users`)
  - Admin CRUD for users
  - Admin-only navigation in Settings sidebar
- Separated Products into public vs admin concerns:
  - Public `ProductsController` (index/show only)
  - Admin `Store::ProductsController` with full CRUD
- Refactored routes, controllers, and views to use namespaces cleanly
- Updated translations to support store/admin namespaces
- Cleaned up storefront views to remove admin-only actions

### Day 5 — Test Coverage for Auth, Email Confirmation, and Admin Access

- Added session authentication test helper (`sign_in_as`, `sign_out`) for integration/controller tests
- Added Sign Up controller tests:
  - renders sign up page
  - redirects when already authenticated
  - creates user on valid params
  - rejects invalid submissions (422)
  - ignores `admin` attribute to prevent privilege escalation
- Added Settings Email controller tests:
  - validates current password for email change
  - enqueues email confirmation on success
  - ensures `unconfirmed_email` persists correctly
- Added Email Confirmation controller tests:
  - rejects invalid tokens gracefully
  - confirms email change with valid token and clears `unconfirmed_email`
- Updated `UserMailer` test to validate confirmation email output
- Added integration tests for Settings sidebar:
  - regular users do not see Store Settings
  - admins see Store Settings
  - regular users are blocked from `/store/products` and `/store/users`
  - admins can access `/store/products` and `/store/users`
- Updated user fixtures to include names and an admin user
- Verified full test suite passes (`bin/rails test`)

### Day 6 — Wishlists + Admin Dashboards + Tests

- Implemented **Wishlists** feature:
  - Added `Wishlist` + `WishlistProduct` models with associations and **counter caches**
    - `wishlists.products_count`, `products.wishlists_count`
  - Enforced uniqueness for `(product_id, wishlist_id)` at both DB + model level
  - Added **friendly URLs** for wishlists using `to_param :name` (shareable links)
- Built wishlist UX:
  - Added **“Add to wishlist”** on product show page
  - Auto-creates a default wishlist (`"My Wishlist"`) if the user has none
  - Added wishlist CRUD pages (`/wishlists`) and navigation link in navbar
  - Added **Copy to clipboard** share button using Stimulus (`clipboard_controller.js`)
  - Added ability to **remove** products and **move** products between wishlists
- Added admin visibility + insights:
  - Added **Store::Wishlists** (index/show) with filtering by `user_id` and `product_id`
  - Refactored filtering into `Wishlist.filter_by(params)` (Fat Model, Skinny Controller)
  - Added **Store::Subscribers** (index/show/destroy) with product filter via `Subscriber.filter_by`
  - Added sidebar links for admins: **Products / Users / Subscribers / Wishlists**
  - Added quick links on admin product page to filtered wishlists/subscribers
- Added test coverage:
  - Added fixtures for wishlists, wishlist_products, and additional products
  - Added model tests for `Wishlist.filter_by` (no filters, user filter, product filter)
  - Added integration tests for wishlist CRUD + public visibility
  - Added integration tests for wishlist products:
    - add to specific wishlist
    - auto-create wishlist when none exist
    - prevent adding/moving into other users’ wishlists (404)
    - moving products + handling duplicates with flash error
  - Verified all wishlist-related tests pass via `bin/rails test`


---

## Purpose

This project exists as a hands-on Rails revision effort following my application for a Ruby on Rails Software Engineer role. Development will continue daily with incremental improvements and commits.
