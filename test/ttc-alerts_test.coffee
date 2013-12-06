chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'ttc-alerts', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()

    require('../src/ttc-alerts')(@robot)

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/ttc/)

