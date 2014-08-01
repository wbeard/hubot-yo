# Description:
#   YO! Zero characters communication
#
# Dependencies:
#   yo-api
#
# Configuration:
#   YO_API_TOKENS   - (Object) The hash of tokens for YO {'foo':'bbbaaa', 'fooalerts':'aaazzz'}
#   YOUR_HUBOT_YO_ACCOUNT   - (String) The name you want to be the default sender of all the Yos
#
# Commands:
#   hubot yo from <yo username> - Sends a Yo to all subscribers of the registered yo username.
#   hubot yo to <name> - send a yo to <name>
#   hubot yo bomb all - send yos to everyone who has ever Yo'd Hubot back (the Yo API stores this "subscribers" list for us)
#   hubot yo list - list all usernames you can use 'yo from' with.
#
# Authors
#   wbeard, mfarrar

Yo = require 'yo-api'

yo_api_tokens = process.env.YO_API_TOKENS

unless yo_api_tokens
  throw "You must enter your YO_API_TOKENS in your environment variables"

yo_hubot_name = process.env.YO_HUBOT_NAME

unless yo_hubot_name
  throw "You must enter your YO_HUBOT_NAME in your environment variables"

module.exports = (robot) ->

  robot.respond /yo from (([a-zA-Z0-9])+)/i, (msg) ->
    user_name = msg.match[1]
    user_to_yo_as = yo_api_tokens[user_name.toLowerCase()]

    unless user_to_yo_as
      msg.send "Can't yo from that user. It's not one I know."
      return false

    yo_client = new Yo user_to_yo_as

    yo_client.yoall (err, res, body) ->
      if err
        msg.send "Yo fail. The Yo API is not happy with me: #{body}"
        return false

      msg.send "Yo sent to all of #{user_name}'s subscribers."


  robot.respond /yo to (([a-zA-Z0-9])+)/i, (msg) ->
    user_to_yo = msg.match[1]

    yo_jarvis = new Yo yo_api_tokens[yo_hubot_name]

    yo_jarvis.yo user_to_yo, (err, res, body) ->
      if err
        msg.send "Yo fail. The Yo API is not happy with me: #{body}"
        return false

      msg.send "Yo sent. I just Yo'd #{user_to_yo}."


  robot.respond /yo bomb/i, (msg) ->
    yo_jarvis = new Yo yo_api_tokens[yo_hubot_name]
    yo_jarvis.yoall (err, res, body) ->
      if err
        msg.send "Yo fail. The Yo API is not happy with me: #{body}"
        return false

      msg.send "Yo bomb sent. I just Yo'd everyone who's ever responded to me."

  robot.respond /yo list/i, (msg) ->
    yo_names = []

    for key, value of yo_api_tokens
      yo_names.push key

    msg.send "Hubot-powered YOs you can subscribe to: \n\t#{yo_names.join('\n\t')}"
