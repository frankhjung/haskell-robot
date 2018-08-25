{-# LANGUAGE UnicodeSyntax #-}

module Main (main) where

import           Robot (Robot (..), fight)

--
-- MAIN robot fight demonstration. Results are:
--
-- round 0
-- Robot {name = "fast", attack = 7, health = 40}
-- Robot {name = "slow", attack = 15, health = 30}
--
-- round 1
-- Robot {name = "fast", attack = 7, health = 25}
-- Robot {name = "slow", attack = 15, health = 23}
--
-- round 2
-- Robot {name = "fast", attack = 7, health = 10}
-- Robot {name = "slow", attack = 15, health = 16}
--
-- round 3
-- Robot {name = "fast", attack = 7, health = 0}
-- Robot {name = "slow", attack = 15, health = 9}
--
--
main :: IO ()
main = do

  -- crazy - but true
  -- this works fine as is Haskell lazy ...
  let
    slowRobotRound3 = fight fastRobotRound2 slowRobotRound2
    fastRobotRound3 = fight slowRobotRound2 fastRobotRound2
    slowRobotRound2 = fight fastRobotRound1 slowRobotRound1
    fastRobotRound2 = fight slowRobotRound1 fastRobotRound1
    slowRobotRound1 = fight fastRobot slowRobot
    fastRobotRound1 = fight slowRobot fastRobot
    fastRobot = Robot "fast"  7 40
    slowRobot = Robot "slow" 15 30

  print "round 0"
  print fastRobot
  print slowRobot
  print "round 1"
  print fastRobotRound1
  print slowRobotRound1
  print "round 2"
  print fastRobotRound2
  print slowRobotRound2
  print "round 3"
  print fastRobotRound3
  print slowRobotRound3

