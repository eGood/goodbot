Goodbot
==================

A pre-packaged runnable version of the [hubot-irc](https://github.com/nandub/hubot-irc) adapter.

## Dependencies

- [Node js](http://nodejs.org)
- [Redis](http://reistiago.wordpress.com/2011/07/23/installing-on-redis-mac-os-x/)

## Setup

```
git clone https://github.com/eGood/goodbot.git
cd goodbot
./bin/hubot
```
## Connecting to IRC

Follow directions here [Hubot IRC Adapter](https://github.com/nandub/hubot-irc)

Then run

```
./bin/hubot -n botname -a irc
```

If `redis` is not installed, goodbot will still work but his data will not be persistant, and scripts that depend on a database will not as intended

## Development 

```
redis-server
#new tab
./bin/hubot -n goodbot
```

## License

MIT License, available via a quick google search if needed.
