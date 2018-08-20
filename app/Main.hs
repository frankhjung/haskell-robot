{-# LANGUAGE UnicodeSyntax #-}

module Main (main) where

import           Robot (fight, printRobot, robot)

--
-- MAIN robot demonstration
--
main :: IO ()
main = do

  -- robot fight
  let
    fastRobot = robot ("fast", 15 :: Int, 40 :: Int)
    slowRobot = robot ("slow", 20 :: Int, 30 :: Int)
  print "round 0"
  print $ printRobot fastRobot
  print $ printRobot slowRobot

  -- fight

  -- round 1
  let
    slowRobotRound1 = fight fastRobot slowRobot
    fastRobotRound1 = fight slowRobot fastRobot
  print "round 1"
  print $ printRobot fastRobotRound1
  print $ printRobot slowRobotRound1

  -- round 2
  let
    slowRobotRound2 = fight fastRobotRound1 slowRobotRound1
    fastRobotRound2 = fight slowRobotRound1 fastRobotRound1
  print "round 2"
  print $ printRobot fastRobotRound2
  print $ printRobot slowRobotRound2

  -- round 3
  let
    slowRobotRound3 = fight fastRobotRound2 slowRobotRound2
    fastRobotRound3 = fight slowRobotRound2 fastRobotRound2
  -- "fast attack:15 hp:0"
  -- "slow attack:20 hp:0"
  print "round 3"
  print $ printRobot fastRobotRound3
  print $ printRobot slowRobotRound3

