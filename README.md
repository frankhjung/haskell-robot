# Robot

Implementation of capstone project, Lesson 10. Capstone: Functional
object-oriented programming with robots of [Get Programming in
Haskell](https://www.manning.com/books/get-programming-with-haskell), by Will
Kurt, Published by Manning Publications, 2018.


## Execution can be done in random order

(This was the old solution code before refactoring.)

As Haskell is lazy, robots can appear in *any* order. Only when a value is
required (`print`) is it evaluated.

```haskell
let
  fastRobot = Robot "fast"  7 40
  slowRobot = Robot "slow" 15 30

rounds = tournament 1 ((fastRobot,slowRobot) :: [])
  fastRobotRound1 = fight slowRobot fastRobot
  fastRobotRound2 = fight slowRobotRound1 fastRobotRound1
  fastRobotRound3 = fight slowRobotRound2 fastRobotRound2
  slowRobotRound1 = fight fastRobot slowRobot
  slowRobotRound2 = fight fastRobotRound1 slowRobotRound1
  slowRobotRound3 = fight fastRobotRound2 slowRobotRound2

print "round 0"
print fastRobot
print slowRobot
print "round 1"
print fastRobotRound1
print slowRobotRound1
print "round 2"
print fastRobotRound2
print slowRobotRound2
print "round 3"
print fastRobotRound3
print slowRobotRound3
```

Running the above gives these results:

```text
round 0
Robot {name = "fast", attack = 7, health = 40}
Robot {name = "slow", attack = 15, health = 30}

round 1
Robot {name = "fast", attack = 7, health = 25}
Robot {name = "slow", attack = 15, health = 23}

round 2
Robot {name = "fast", attack = 7, health = 10}
Robot {name = "slow", attack = 15, health = 16}

round 3                                         # Slow robot wins!
Robot {name = "fast", attack = 7, health = 0}
Robot {name = "slow", attack = 15, health = 9}
```


## API Documentation

* [GitHub](https://frankhjung.github.io/haskell-robot/)
* [GitLab](https://frankhjung1.gitlab.io/haskell-robot/)


## References

* [GitLab CI for Haskell](https://vadosware.io/post/zero-to-continuous-integrated-testing-a-haskell-project-with-gitlab)
* [GitLab Docker Image for lts-11.17](https://hub.docker.com/r/fpco/stack-build/tags/)
* [Haskell Docker Images](https://hub.docker.com/_/haskell/)
* [QuickCheck](https://begriffs.com/posts/2017-01-14-design-use-quickcheck.html)
* [Smart Constructors](https://wiki.haskell.org/Smart_constructors)

