# Description:
#   Some webhooks for various git services
#
# Commands:
#   n/a


module.exports = (robot) ->
  robot.router.post "/message/create", (req, res) ->
    params = req.body
    console.log params
    message = params["message"]
    room = params["room"]
    robot.messageRoom room, message 
    res.end "Message Sent"

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