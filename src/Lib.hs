{-# LANGUAGE DerivingStrategies         #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

{-|
  Module      : Robot
  Description : Test fighting robots.
  Copyright   : © Frank Jung, 2018-2023
  License     : BSD-3
  Maintainer  : frankhjung@linux.com
  Stability   : stable
  Portability : portable
-}

module Lib
        (
          -- * Data Types
          Robot (..)
        , HitPoint (..)
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
newtype HitPoint = HitPoint Word deriving stock (Eq, Ord, Show)
                                 deriving newtype Num

-- | Hit Point value of health when dead.
dead :: HitPoint
dead = HitPoint 0

-- | Hit Point value of health when weak.
weak :: HitPoint
weak = HitPoint 5

-- | Reduce a robots health by damage points.
damage :: Robot -> HitPoint -> Robot
damage robot attackDamage =
  Robot { name = name robot, attack = attack robot, health = damaged }
  where
    damaged
      | health robot > attackDamage = health robot - attackDamage
      | otherwise                   = dead

-- | Issue damage from attacking robot to the defending robot.
fight :: Robot -> Robot -> Robot
fight attacker defender = damage defender attackPoints
  where
    attackPoints
      | health attacker > weak = attack attacker
      | otherwise              = dead

-- | Run a tournament until attacking robot is dead.
tournament :: Robot -> Robot -> [Robot]
tournament attacker defender = takeWhile isAlive $ iterate (fight attacker) defender
  where
    isAlive robot = health robot > dead
