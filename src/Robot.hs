{-# LANGUAGE OverloadedLabels #-}

{-|
  Module      : Robot
  Description : Test fighting robots.
  Copyright   : © Frank Jung, 2018-2019
  License     : GPL-3
  Maintainer  : frankhjung@linux.com
  Stability   : stable
  Portability : portable
-}

module Robot
        (
          -- * Data Types
          Robot (..)
        , HitPoint
          -- * Constants
        , dead
        , weak
          -- * Functions
        , damage
        , fight
        , tournament
        ) where

-- | A robot has name, attack strength and health.
data Robot =
  Robot {
          name   :: String
        , attack :: HitPoint
        , health :: HitPoint
        } deriving (Show)

-- | Hit points are non-negative integers (i.e. Natural numbers).
type HitPoint = Word

-- | Hit Point value of health when dead.
dead :: HitPoint
dead = 0 :: HitPoint

-- | Hit Point value of health when weak.
weak :: HitPoint
weak = 5 :: HitPoint

-- | Reduce a robots health by damage points.
damage :: Robot -> HitPoint -> Robot
damage robot attackDamage =
  Robot { name = name robot, attack = attack robot, health = damaged }
  where damaged =
          if health robot > attackDamage
            then health robot - attackDamage
            else dead

-- | Issue damage from attacking robot to the defending robot.
fight :: Robot -> Robot -> Robot
fight attacker defender = damage defender attackPoints
  where attackPoints =
          if health attacker > weak
            then attack attacker
            else dead

-- | Run a tournament until attacking robot is dead.
tournament :: Robot -> Robot -> [Robot]
tournament attacker defender = takeWhile isAlive $ iterate (fight attacker) defender
  where
    isAlive :: Robot -> Bool
    isAlive robot = health robot > dead
