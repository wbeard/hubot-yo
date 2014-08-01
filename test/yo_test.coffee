chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'yo', ->
  beforeEach ->
    @robot = 
      respond: sinon.spy()
      hear: sinon.spy()
    require('../src/yo')(@robot)

  it 'listens for "yo for"', ->
    expect(@robot.response).to.have.been.calledWith('yo from jarvis')

  it 'listens for "yo to"', ->
    expect(@robot.response).to.have.been.calledWith('yo to jarvis')

  it 'listens for "yo bomb"', ->
    expect(@robot.response).to.have.been.calledWith('yo bomb')

  it 'listens for "yo list"', ->
    expect(@robot.response).to.have.been.calledWith('yo list')