# README

### Setup

1. Clone the project repository
  ```bash
  git@github.com:ImMPrada/TOP-flights-booking.git
  ```
2. `cd` into the project folder and install node dependencies
  ```bash
  cd TOP-flights-booking
  bundle install
  ```
3. Set up the database
  ```bash
  rails db:create
  rails db:load:schema
  rails db:seed
  ```
4. Create a .env file based on the existing .env.example file
  ```bash
    cp .env.example .env
  ```
5. Ask for Google credentials, or you can use yours
6. Start the rails server
  ```bash
    rails s
  ```
7. Start the rails tailwind server
  ```bash
    rails tailwindcss:watch
  ``