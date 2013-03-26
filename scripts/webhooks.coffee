# Description:
#   Some webhooks for various git services
#
# Commands:
#   n/a

Parser = require("xml2js").parseString

  

module.exports = (robot) ->
    
  robot.router.post "/message/create", (req, res) ->
    params = req.body
    console.log params
    message = params["message"]
    room = params["room"]
    robot.messageRoom room, message 
    res.end "Message Sent"

  # github webhook

  robot.router.post "/webhook", (req, res) ->
    params = JSON.parse(req.body.payload);
    if params.commits
      index = params.commits.length - 1
      commit = params.commits[index]
      author = commit.committer.name
      message = commit.message
      repo = params.repository.name
      # static right need to store this dat in database
      # room = robot.brain.data.webkooks[repo].room
      room = "#eGood"
      txt = "#{author} commited to #{repo} - #{message}"
      robot.messageRoom room, txt 
    
    res.end "webhook"

  # event webhook

  robot.router.post "/event", (req, res) ->
    params = req.body;

    if params.event
  
      event = params.event
      # static right need to store this dat in database
      # room = robot.brain.data.webkooks[repo].room
      room = "#eGood"
      txt = "Event - #{event}"
      robot.messageRoom room, txt 
    
    res.end "success"

  # pivotal webhook

  robot.router.post "/pivotal", (req, res) ->

    room = '#eGood'
    if /(application\/xml|text\/xml)/.test req.headers["content-type"]
      body = null
      req.on "data", (chunk) ->
        console.log chunk
        body = chunk
      req.on "end", () ->
        console.log "req.end #{body}"
        Parser body, (err, result) ->
          if err
            console.log err 
          else
            console.log result
            activity = result.activity
            robot.messageRoom room, "#{activity.description[0]} - #{activity.stories[0].story[0].url[0]}"

    else
      console.log "we do not have xml #{req.headers["content-type"]}"  

    res.end "success"