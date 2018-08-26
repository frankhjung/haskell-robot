{-# LANGUAGE UnicodeSyntax #-}

module Main (main) where

import           Robot (Robot (..), tournament)

--
-- MAIN robot fight demonstration.
--

main :: IO ()
main = do

  let
    fastRobot = Robot "fast"  7 40
    slowRobot = Robot "slow" 15 30

  putStrLn "Showing history of fast robot ..."
  mapM_ print $ tournament 4 slowRobot fastRobot

  putStrLn "Showing history of slow robot ..."
  mapM_ print $ tournament 4 fastRobot slowRobot

