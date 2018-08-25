
module Main (main) where

import           Robot           (HitPoint, Robot (..), damage, makeHitPoint)
import           Test.QuickCheck

-- instance Arbitrary HitPoint where
--     arbitrary = makeHitPoint `fmap` arbitrary :: Gen Int

-- genPositive :: Gen Int
-- genPositive = abs `fmap` (arbitrary :: Gen Int) `suchThat` (>= 0)

genHitPoint :: Gen HitPoint
genHitPoint = fmap makeHitPoint (arbitrary :: Gen Int)

prop_damage :: Robot -> HitPoint -> Bool
prop_damage r d = health (damage r d) == newhealth
    where newhealth =
            if health r - d > 0
              then health r - d
              else 0

main :: IO ()
main = do

  r <- generate $ Robot <$> arbitrary <*> genHitPoint <*> genHitPoint
  quickCheck $ forAll genHitPoint $ \d -> prop_damage r d

