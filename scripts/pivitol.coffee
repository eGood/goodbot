# Description:
#   Get current stories from PivotalTracker
#
# Dependencies:
#   "xml2js": "0.1.14"
#
# Configuration:
#   HUBOT_PIVOTAL_TOKEN
#   HUBOT_PIVOTAL_PROJECT
#
# Commands:
#   show me stories for <project> - shows current stories being worked on
#   pivotal story <story_id> - shows story title, owner and status
#
# Author:
#   assaf

module.exports = (robot) ->
  robot.respond /show\s+(me\s+)?stories(\s+for\s+)?(.*)/i, (msg)->
    Parser = require("xml2js").Parser
    token = process.env.HUBOT_PIVOTAL_TOKEN
    project_name = msg.match[3]
    if project_name == ""
      project_name = RegExp(process.env.HUBOT_PIVOTAL_PROJECT, "i")
    else
      project_name = RegExp(project_name + ".*", "i")

    msg.http("http://www.pivotaltracker.com/services/v3/projects").headers("X-TrackerToken": token).get() (err, res, body) ->
      if err
        msg.send "Pivotal says: #{err}"
        return
      (new Parser).parseString body, (err, json)->
        projects = json.projects.project
        console.log(projects);
        for project in projects
          if project_name.test(project.name[0])
            msg.http("https://www.pivotaltracker.com/services/v3/projects/#{project.id}/iterations/current").headers("X-TrackerToken": token).query(filter: "state:unstarted,started,finished,delivered").get() (err, res, body) ->
              if err
                msg.send "Pivotal says: #{err}"
                return
      
              (new Parser).parseString body, (err, json)->
                stories = json.iterations.iteration[0].stories
                msg.send "second loop"
                for story in stories
                  story = story.story
                  msg.send "third loop"
                  for thisstory in story
                    
                    message = "#{thisstory.name[0]}"
                    message += " (#{thisstory.owned_by[0]})" if thisstory.owned_by
                    message += " is #{thisstory.current_state[0]}" if thisstory.current_state && thisstory.current_state[0] != "unstarted"
                    msg.send message
            return
        msg.send "No project #{project_name}"

  robot.respond /(pivotal story)? (.*)/i, (msg)->
    Parser = require("xml2js").Parser
    token = process.env.HUBOT_PIVOTAL_TOKEN
    project_id = process.env.HUBOT_PIVOTAL_PROJECT
    story_id = msg.match[2]

    msg.http("http://www.pivotaltracker.com/services/v3/projects").headers("X-TrackerToken": token).get() (err, res, body) ->
      if err
        msg.send "Pivotal says: #{err}"
        return
      (new Parser).parseString body, (err, json)->
        for project in json.project
          msg.http("https://www.pivotaltracker.com/services/v3/projects/#{project.id}/stories/#{story_id}").headers("X-TrackerToken": token).get() (err, res, body) ->
            if err
              msg.send "Pivotal says: #{err}"
              return
            if res.statusCode != 500
              (new Parser).parseString body, (err, story)->
                if !story.id
                  return
                message = "##{story.id['#']} #{story.name}"
                message += " (#{story.owned_by})" if story.owned_by
                message += " is #{story.current_state}" if story.current_state && story.current_state != "unstarted"
                msg.send message
                storyReturned = true
                return
    return