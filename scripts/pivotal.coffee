# Description:
#   List Stories from Pivitol based off state
#
# Commands:
#   hubot show {state} stories for {project} - Display list of stories


Pivotal = require "pivotal"
token = process.env.HUBOT_PIVOTAL_TOKEN || null
cache = {};
try
  Pivotal.useToken token
catch err
  throw "A valid token for Pivotal Tracker to use Pivotal Commands"

#gets a project using project name
getProject = (query, callback) ->
  Pivotal.getProjects (err, projects) ->
    console.log err if err
    cache.projects = projects;
    if projects
      for project in projects.project
          if query.test project.name
            project.id = parseFloat project.id
            callback project
            return null
    callback null

module.exports = (robot) ->
  robot.respond /show\s+(me\s+)?(.*)+stories\s+(for\s+)?(.*)/i, (msg) ->
    filter = "current_state:\"#{msg.match[2]}\""
    query = new RegExp msg.match[4]
    getProject query, (project) ->
      if !project
        msg.send("I could not find #{query}, perhaps you spelt something wrong");
      else
        #console.log "project found"
        Pivotal.getStories project.id, 
          limit : 20
          filter : filter
        , (err, stories) ->
          console.log err if err
          stories = stories.story
          for story in stories
            if story.id
              msg.send("##{story.id} - #{story.name}")

  robot.respond /show\s+(me\s+)?comments\s+(for|on)\s+story\s+#(0-9)+/, (msg) ->
    #story = parseFloat msg.match[4]
    msg.send "so you want me to find story comments"
    #Pivotal.getStory story, (err, story) ->

