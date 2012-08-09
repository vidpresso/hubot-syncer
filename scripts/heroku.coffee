module.exports = (robot) ->
  robot.router.post "/heroku", (req, res) ->
    robot.messageRoom "heroku", "#{req.body.app}- #{req.body.user} pushed #{req.body.head} to #{req.body.url}."
    robot.messageRoom "heroku", "Comment: #{req.body.git_log}"
    res.end "thanks."
