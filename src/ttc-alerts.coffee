# Description:
#   hubot script to display TTC (Toronto transit) alerts
#
# Dependencies:
#   "htmlparser": "1.7.6"
#   "soupselect": "0.2.0"
#
# Configuration:
#   None
#
# Commands:
#   hubot ttc me - display TTC (Toronto transit) alerts
#
# Author:
#   gordonc

Select      = require('soupselect').select
HtmlParser  = require 'htmlparser'

module.exports = (robot)->
  robot.respond /ttc( me)?/i, (msg)->
    msg.http('http://www.ttc.ca/Service_Advisories/all_service_alerts.jsp').get() (error, response, body)->
      handler = new HtmlParser.DefaultHandler()
      parser  = new HtmlParser.Parser handler
      parser.parseComplete body
      
      for h3 in Select(handler.dom, 'h3.alert-header')
        msg.send h3.children[0].raw

      for p in Select(handler.dom, 'div.alert-content p.veh-replace')
        msg.send p.children[0].raw

