util = require "util"
exec = require("child_process").exec


module.exports = (robot) ->
  robot.router.post "/github", (req, res) ->
    payload = JSON.parse req.body.payload
    if payload.ref is "refs/heads/master"
      robot.messageRoom 'github', "Recieved master, deploying to production."
      child = exec "/app/pullpushprod.sh", (err, stdout, stderr) ->
        console.log stdout
        console.log stderr
        console.log err
        robot.messageRoom 'github', "Production deployed. Spinning up. #{process.env["PROD_URL"]}"
        robot.messageRoom 'github', err if err
        robot.messageRoom 'github', stderr if stderr
        ###robot.messageRoom 'github', stdout###

    else if payload.ref is "refs/heads/develop"
      robot.messageRoom 'github', "Recieved develop, pushing to stage.."
      child = exec "/app/pullpushstage.sh", (err, stdout, stderr) ->
        console.log stdout
        console.log stderr
        console.log err
        robot.messageRoom "github", "Deployed to staging. Spinning up. #{process.env["STAGE_URL"]}"
        robot.messageRoom "github", err if err
        robot.messageRoom "github", stderr if stderr
        ###robot.messageRoom "github", stdout###
    else if payload.ref.indexOf("release") > -1
      #robot.messageRoom 'github', "Recieved release, pushing to stage."
      robot.messageRoom 'github', "Recieved release. Should push to stage, but not configured yet. Edit Hubot to do that if you want it bad enough."
    else
      robot.messageRoom 'github', "got some random commit hook."
      robot.messageRoom 'github', "Payload ref was: #{payload.ref}"
      console.log payload
    res.end "thanks github."
