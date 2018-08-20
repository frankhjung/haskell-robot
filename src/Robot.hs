{-# LANGUAGE OverloadedLabels #-}

{-|
  Module      : Robot
  Description : Test fighting robots.
  Copyright   : © Frank Jung, 2018
  License     : GPL-3
  Maintainer  : frankhjung@linux.com
  Stability   : stable
  Portability : portable
-}

-- TODO attack and health must be non-negative integers
-- use smart types to validate attack and health
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
        ) where

-- | A robot has name, attack strength and health.
data Robot =
  Robot {
          name   :: String
        , attack :: HitPoint
        , health :: HitPoint
        } deriving (Show)

type HitPoint = Int

-- | Health value when dead.
dead :: HitPoint
dead = 0

-- | Health value when weak.
weak :: HitPoint
weak = 5

-- | Reduce a robots health by damage points.
damage :: Robot -> HitPoint -> Robot
damage robot attackDamage =
  Robot { name = name robot , attack = attack robot , health = damaged }
  where damaged =
          if health robot - attackDamage > dead
            then health robot - attackDamage
            else 0

-- | Issue damage from attacking robot to a defending robot.
fight :: Robot -> Robot -> Robot
fight attackingRobot defendingRobot = damage defendingRobot attackPoints
  where attackPoints =
          if health attackingRobot > weak
            then attack attackingRobot
            else 0

