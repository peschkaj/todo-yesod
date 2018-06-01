# Building and Testing

1. [install Stack](https://haskell-lang.org/get-started)
    * On POSIX systems, this is usually `curl -sSL https://get.haskellstack.org/ | sh`
    * If you are evaluating this on a PSU machine (e.g. `babbage`), this is absolutely critical - the `stack` shipped on these systems is woefully out of date.
2. Install the `yesod` command line tool: `stack install yesod-bin --install-ghc`
3. `cd todo-yesod && stack build`
4. Start the application with `stack exec -- yesod devel`
5. Visit [http://localhost:3000]() to view the application.

# Using The Best ToDo List Evah

The application features two pieces of functionality - Deadlines and Events.

## Deadlines

A deadline is a task that should be completed by a specific time.

The home page of the application will display _upcoming_ deadlines. These are deadlines that will occur in the next 5 hours. Overdue deadlines will be called out.

All deadlines can be viewed on the [deadlines](http://localhost:3000/deadline) page.

Deadlines can be created by clicking [Add deadline](http://localhost:3000/deadline/new). Once a deadline is added, the deadline is persisted to disk in the `Deadlines` file.

## Events

An event is a task with a concrete start and end time.

The home page of the application will display _upcoming_ events.

All events can be viewed on the [events](http://localhost/event) page.

Events can be created by clicking [Add event](http://localhost:3000/events/new). Once an event is added, the event is persisted to disk in the `Events` file.

# Using the API

It is also possible to use the Haskell APIs for the to do list directly. The following example assumes you are using `stack ghci` from within the `todo-hs` source tree, not the `todo-yesod` application.

``` haskell
import Data.Time
:set -XOverloadedStrings
t <- getCurrentTime
d1 = Deadline "First deadline" "It's the first deadline ever" (addMinutes 60 t)
d2 = Deadline "Second deadline" "It's the second deadline ever" (addMinutes 180 t)
d3 = Deadline "Third deadline" "Why so many deadlines?" (addMinutes 600 t)

-- Note: this line will wipe out all of your existing deadlines
l1 <- addDeadline d1 ([] :: [Deadline])
l2 <- addDeadline d2 l1
l3 <- addDeadline d3 l2

-- What are all of my upcoming tasks?
putStrLn $ unpack $ deadlinesToLines l3

-- What do I need to do next?
upcomingDeadlines l3 >>= Prelude.putStrLn . deadlinesToLines

-- Now we test writing to a file
(Just l') <- getCurrentDeadlines
```
