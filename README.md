## Summary

This gem only provides method to get depth, ticker and orderbook from bitcoin.de
It uses nokogiri to parse the data so sometimes api calls are a bit long

Don't hesitate to contribute.
If you liked it:
BTC: 1PizgAWLJbwEsNWG9Cf27skcbgbgZGgeyK
LTC: LQtM1t6BRd64scsdSBk8nnCLJuc8Qfhm53

## Installation

Add this line to your application's Gemfile:

    gem 'bitcoinde'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bitcoinde

## Usage

Create a bitcoinde client:

```ruby

bitcoinde = Bitcoinde::Client.new

```

### Ticker
```ruby
ticker = bitcoinde.ticker

```
returns ticker price
### Depth

 ```ruby
 depth = bitcoinde.depth

 ```

 returns asks and bids in orderbook

### Trades

```ruby
trades = bitcoinde.trades
```
returns last trades