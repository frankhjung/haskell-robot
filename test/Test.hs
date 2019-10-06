module Main (main) where

import           Robot           (HitPoint (..), Robot (..), damage, dead)
import           Test.QuickCheck

-- | Arbitrary Robot.
instance Arbitrary Robot where
  arbitrary = Robot <$> arbitrary <*> arbitrary <*> arbitrary

-- | Arbitrary HitPoint.
instance Arbitrary HitPoint where
  arbitrary = HitPoint <$> arbitrary

-- | Test property damage. Either robot weakened or killed.
prop_damaged :: Robot -> HitPoint -> Bool
prop_damaged r d = health (damage r d) == newhealth
  where
    newhealth
      | health r > d = health r - d
      | otherwise    = dead

-- | Test property damage that will kill a robot.
prop_dead :: Robot -> Bool
prop_dead robot = health deadrobot == dead
  where deadrobot = damage robot (health robot)

main :: IO ()
main = do
  quickCheck prop_damaged
  quickCheck prop_dead
