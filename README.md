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

Which is the same result as:

```text
$ make exec
How long the fast robot survives ...
Robot {name = "fast", attack = HitPoint 7, health = HitPoint 40}
Robot {name = "fast", attack = HitPoint 7, health = HitPoint 25}
Robot {name = "fast", attack = HitPoint 7, health = HitPoint 10}
How long the slow robot survives ...
Robot {name = "slow", attack = HitPoint 15, health = HitPoint 30}
Robot {name = "slow", attack = HitPoint 15, health = HitPoint 23}
Robot {name = "slow", attack = HitPoint 15, health = HitPoint 16}
Robot {name = "slow", attack = HitPoint 15, health = HitPoint 9}
Robot {name = "slow", attack = HitPoint 15, health = HitPoint 2}
         134,120 bytes allocated in the heap
          15,752 bytes copied during GC
          56,816 bytes maximum residency (1 sample(s))
          29,200 bytes maximum slop
               2 MB total memory in use (0 MB lost due to fragmentation)

                                     Tot time (elapsed)  Avg pause  Max pause
  Gen  0         0 colls,     0 par    0.000s   0.000s     0.0000s    0.0000s
  Gen  1         1 colls,     0 par    0.000s   0.000s     0.0001s    0.0001s

  TASKS: 4 (1 bound, 3 peak workers (3 total), using -N1)

  SPARKS: 0 (0 converted, 0 overflowed, 0 dud, 0 GC'd, 0 fizzled)

  INIT    time    0.001s  (  0.001s elapsed)
  MUT     time    0.001s  (  0.001s elapsed)
  GC      time    0.000s  (  0.000s elapsed)
  EXIT    time    0.001s  (  0.009s elapsed)
  Total   time    0.003s  (  0.010s elapsed)

  Alloc rate    126,302,982 bytes per MUT second

  Productivity  64.5% of total user, 92.4% of total elapsed

gc_alloc_block_sync: 0
whitehole_spin: 0
gen[0].sync: 0
gen[1].sync: 0
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

