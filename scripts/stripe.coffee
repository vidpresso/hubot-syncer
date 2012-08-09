util = require "util"
module.exports = (robot) ->
  robot.router.post "/stripe", (req, res) ->
    bod = req.body
    robot.messageRoom "stripe", "Stripe event: #{bod.type}. Details: https://manage.stripe.com/#events/#{bod.id}"
    res.end JSON.stringify req.body
  robot.router.post "/test/stripe", (req, res) ->
    bod = req.body
    robot.messageRoom "stripe", "(test) Stripe event: #{bod.type}. Details: https://manage.stripe.com/#events/#{bod.id}"
    res.end JSON.stringify req.body

