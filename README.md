## Haskell Setup

1. If you haven't already, [install Stack](https://haskell-lang.org/get-started)
    * On POSIX systems, this is usually `curl -sSL https://get.haskellstack.org/ | sh`
    * *Note to Portland State University students/staff* This is absolutely necessary on CAT managed systems. The `stack` shipped on PSU systems is out of date.
2. Install the `yesod` command line tool: `stack install yesod-bin --install-ghc`
3. Create a vendor subdirectory: `mkdir vendor`
4. Link todo-hs into the vendor subdirectory: `cd vendor && ln -s ../../todo-hs todo-hs` (note, this requires that you checked out [todo-hs](https://github.com/peschkaj/todo.hs/))
3. Build libraries: `stack build`

If you have trouble, refer to the [Yesod Quickstart guide](https://www.yesodweb.com/page/quickstart) for additional detail.

## Development

Start a development server with:

```
stack exec -- yesod devel
```

As your code changes, your site will be automatically recompiled and redeployed to localhost.

## Documentation

* Read the [Yesod Book](https://www.yesodweb.com/book) online for free
* Check [Stackage](http://stackage.org/) for documentation on the packages in your LTS Haskell version, or [search it using Hoogle](https://www.stackage.org/lts/hoogle?q=). Tip: Your LTS version is in your `stack.yaml` file.
* For local documentation, use:
    * `stack haddock --open` to generate Haddock documentation for your dependencies, and open that documentation in a browser
    * `stack hoogle <function, module or type signature>` to generate a Hoogle database and search for your query
* The [Yesod cookbook](https://github.com/yesodweb/yesod-cookbook) has sample code for various needs

## Getting Help

* Ask questions on [Stack Overflow, using the Yesod or Haskell tags](https://stackoverflow.com/questions/tagged/yesod+haskell)
* Ask the [Yesod Google Group](https://groups.google.com/forum/#!forum/yesodweb)
* There are several chatrooms you can ask for help:
    * For IRC, try Freenode#yesod and Freenode#haskell
    * [Functional Programming Slack](https://fpchat-invite.herokuapp.com/), in the #haskell, #haskell-beginners, or #yesod channels.
