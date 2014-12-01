assert = require 'assert'
liveleakInfo = require('./src/liveleak-info')

class DummyRobot
  constructor: () ->
    @handlers = []
  hear: (regex, handler) ->
    @handlers.push handler

class MockMessage
  constructor: (options) ->
    {@match, @callback} = options
  send: (output) ->
    @callback output


describe 'liveleak-info', ->
  it 'registers handler correctly', ->
    dummyRobot = new DummyRobot
    liveleakInfo dummyRobot
    handler = dummyRobot.handlers[0]
    assert typeof handler == 'function'
    msg = new MockMessage
      match: [
        ''
        'http://www.liveleak.com/view?i=eb9_1417387762'
      ]
      callback: (output) ->
        'cant do anything here'
    handler msg
