# Docs

[Documentation](https://dalgona.github.io/Serum/docs/mix-tasks.html#serum)

## Key Tasks

## Development

- mix serum.server - Starts the Development Server
- mix serum.gen.page - Adds a New Page
- mix serum.gen.post (-t|--title) TITLE (-o|--output) OUTPUT [Options]
  eg. `mix serum.gen.post -t "Using React Navigation with Okta" -o using-react-navigation-with-okta`

## Deploy

run ./scripts/publish.sh
mix serum.server
