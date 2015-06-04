require! {
  'chai': { expect }
  '../src/robot': { Robot }
}

describe 'Given a new Robot' ->
  specify 'it should not allow negative coordinates' ->
    expect (-> new Robot -1, -1) .to .throw Error

  specify 'it should not allow an invalid orientation' ->
    expect (-> new Robot 1, 1, \F) .to .throw Error

  specify 'it should land on Mars facing North' ->
    robot = new Robot 1, 1
    expect robot.facing .to .equal \N
