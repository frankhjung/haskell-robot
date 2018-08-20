
module Main (main) where

import           Robot           (HitPoint, Robot (..), damage)
import           Test.QuickCheck

genPositive :: Gen Int
genPositive = abs `fmap` (arbitrary :: Gen Int) `suchThat` (>= 0)

prop_damage :: Robot -> HitPoint -> Bool
prop_damage r d = health (damage r d) == newhealth
    where newhealth =
            if health r - d > 0
              then health r - d
              else 0

main :: IO ()
main = do

  -- test damage for positive attacks and health
  r <- generate $ Robot <$> arbitrary <*> genPositive <*> genPositive
  quickCheck $ forAll genPositive $ \d -> prop_damage r d

