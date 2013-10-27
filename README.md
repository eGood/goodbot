<<<<<<< HEAD
Goodbot
==================

eGoods personal bot. Loves Tacos --- dont ask.

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

=======
# Hubot

Hubot is a chat bot, modeled after GitHub's Campfire bot, hubot. He's pretty
cool. He's extendable with
[community scripts](https://github.com/github/hubot-scripts) and your own custom
scripts, and can work on [many different chat services](docs/adapters.md).

This repository provides a library that's distributed by `npm` that you
use for building your own bots.  See the [docs/README.md](docs/README.md)
for details on getting up and running with your very own robot friend.

In most cases, you'll probably never have to hack on this repo directly if you
are building your own bot. But if you do, check out [CONTRIBUTING.md](CONTRIBUTING.md)

## License

Copyright (c) 2011-2013 GitHub, Inc. See the LICENSE file for license rights and
limitations (MIT).
>>>>>>> hubot/master
