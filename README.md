# ClockApi

This is the [API implementation](https://github.com/dapengli2005/clock-api) (referred to as _the backend below) for [clock-web-client](https://github.com/dapengli2005/clock-web-client) (referred to as _the frontend below), built with [Rails](https://rubyonrails.org/) 5.2.3.

View live demos here, they run on free dynos, so delay is expected:
- [frontend on heroku](https://clock-client.herokuapp.com/)
- [backend on heroku (api only)](https://clock-api.herokuapp.com/)

# Features

- login user `POST /users`
  - `username` is required
- get user `GET /users/:id`
- get suggested next clock action for a user `GET /users/:user_id/clock_entries/next`
- create clock action for a user `POST /users/:user_id/clock_entries/`
  - `action_type` is required and must be 'IN' or 'OUT'
  - `datetime` is required and must not be in the future (5 minutes later than current)
- get clock actions for a user `GET /users/:user_id/clock_entries/`
- get clock action for a user `GET /users/:user_id/clock_entries/:id`
- update clock action for a user `PUT /users/:user_id/clock_entries/:id`
  - `action_type` is required and must be 'IN' or 'OUT'
  - `datetime` is required and must not be in the future (5 minutes later than current)
- delete clock action for a user `DELETE /users/:user_id/clock_entries/:id`

## Validations

Please see 'Features' action.

## More about date time format

- the backend persists date time in UTC
- the backend sends and expects date time fields in [ISO 8601 format](https://en.wikipedia.org/wiki/ISO_8601) in its API

# Development

## Dependencies

- Ruby 2.6.3
- Rails 5.2.3
- PostgreSQL server

## Setup

Update `config/database.yml` according to your system then run the follow commands.

```
bundle install
rails db:create
rails db:migrate
```

## Development server

Run `rails server` for a dev server.

## Running unit tests

Run `rspec` to execute the unit tests.
