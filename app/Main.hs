{-# LANGUAGE UnicodeSyntax #-}

module Main (main) where

import           Robot (Robot (..), tournament)

{-|
  MAIN robot demonstration project.
-}

main :: IO ()
main = do

  let
    fastRobot = Robot "fast"  7 40
    slowRobot = Robot "slow" 15 30

  putStrLn "How long the fast robot survives ..."
  mapM_ print $ tournament slowRobot fastRobot

  putStrLn "How long the slow robot survives ..."
  mapM_ print $ tournament fastRobot slowRobot

