{-# LANGUAGE OverloadedLabels #-}

module Robot (
                robot
              , fight
              , printRobot
             ) where

robot :: (a, b, c) -> ((a, b, c) -> t) -> t
robot (name, attack, hp) message = message (name, attack, hp)

name :: (a, b, c) -> a
name (n, _, _) = n

attack :: (a, b, c) -> b
attack (_, a, _) = a

hp :: (a, b, c) -> c
hp (_, _, h) = h

getName :: (((a, b, c) -> a) -> t) -> t
getName aRobot = aRobot name

getAttack :: (((a, b, c) -> b) -> t) -> t
getAttack aRobot = aRobot attack

getHP :: (((a, b, c) -> c) -> t) -> t
getHP aRobot = aRobot hp

setName :: (((a1, b, c) -> ((a2, b, c) -> t1) -> t1) -> t2)
                 -> a2 -> t2
setName aRobot newName =
    aRobot (\(_, a, h) -> robot (newName, a, h))

setAttack :: (((a, b1, c) -> ((a, b2, c) -> t1) -> t1) -> t2)
                   -> b2 -> t2
setAttack aRobot newAttack =
    aRobot (\(n, _, h) -> robot (n, newAttack, h))

setHP :: (((a, b, c1) -> ((a, b, c2) -> t1) -> t1) -> t2)
               -> c2 -> t2
setHP aRobot newHP =
    aRobot (\(n, a, _) -> robot (n, a, newHP))

damage :: Num c =>
                (((a, b, c) -> ((a, b, c) -> t1) -> t1) -> t2) -> c -> t2
damage aRobot attackDamage =
    aRobot (\(n,a,h) -> robot (n,a,h-attackDamage))

fight :: (Ord c1, Num c1) =>
               (((a1, c2, c2) -> c2) -> c1)
               -> (((a2, b, c1) -> ((a2, b, c1) -> t1) -> t1) -> t2) -> t2
fight aRobot defender = damage defender attack
  where attack =
          if getHP aRobot > 5
            then getAttack aRobot
            else 0

printRobot :: (Show a2, Show a1) =>
                    (((String, a1, a2) -> String) -> t) -> t
printRobot aRobot =
  aRobot (\(n, a, h) -> n ++ " attack:" ++ show a ++ " hp:"++ show h)
