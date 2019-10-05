module Main (main) where

import           Robot           (HitPoint, Robot (..), damage, dead,
                                  makeHitPoint)
import           Test.QuickCheck

instance Arbitrary HitPoint
  where arbitrary = fmap makeHitPoint arbitrary

instance Arbitrary Robot
  where arbitrary = Robot <$> arbitrary <*> arbitrary <*> arbitrary

-- if you didn't want to write an instance then can use these generators:
--
-- genNonNegative :: Gen Int
-- genNonNegative = abs `fmap` (arbitrary :: Gen Int) `suchThat` (>= 0)
--
-- genHitPoint :: Gen HitPoint
-- genHitPoint = fmap makeHitPoint (arbitrary :: Gen Int)
--
-- then test with:
-- quickCheck $ forAll genHitPoint $ \d -> prop_damage r d

prop_damaged :: Robot -> HitPoint -> Bool
prop_damaged r d = health (damage r d) == newhealth
  where newhealth =
          if health r - d > dead
            then health r - d
            else dead

prop_dead :: Robot -> Bool
prop_dead robot = health deadrobot == dead
  where deadrobot = damage robot (health robot)

main :: IO ()
main = do
  quickCheck prop_damaged
  quickCheck prop_dead
