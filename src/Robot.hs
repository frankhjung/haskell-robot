{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedLabels           #-}

{-|
  Module      : Robot
  Description : Test fighting robots.
  Copyright   : © Frank Jung, 2018
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
          -- * Constructors
        , makeHitPoint
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

newtype HitPoint = HitPoint Int deriving (Eq, Num, Ord, Show)

makeHitPoint :: Int -> HitPoint
makeHitPoint = HitPoint . abs
-- pointful version:
-- makeHitPoint hp = HitPoint (abs hp)

-- | Health value when dead.
dead :: HitPoint
dead = HitPoint 0

-- | Health value when weak.
weak :: HitPoint
weak = HitPoint 5

-- | Reduce a robots health by damage points.
damage :: Robot -> HitPoint -> Robot
damage robot attackDamage =
  Robot { name = name robot , attack = attack robot , health = damaged }
  where damaged =
          if health robot - attackDamage > dead
            then health robot - attackDamage
            else HitPoint 0

-- | Issue damage from attacking robot to the defending robot.
fight :: Robot -> Robot -> Robot
fight attacker defender = damage defender attackPoints
  where attackPoints =
          if health attacker > weak
            then attack attacker
            else HitPoint 0

-- | Run a robot fight tournament.
tournament :: Int -> Robot -> Robot -> [Robot]
tournament n attacker defender = take n $ iterate (fight attacker) defender

