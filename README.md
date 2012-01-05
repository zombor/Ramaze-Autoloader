# Ramaze Autoloader

This is a repo for my testing of creating a ramaze autoloader.

I'm not happy with (possibly incorrectly) how ramaze requires lots of...require statements to setup all it's files. We should not have to manually include all files we wish to use.

Right now, we can only autoload non-controllers, as ramaze needs all controllers loaded in order to route a request.

To use this, just run `ramaze start` from this directory, and navigate to http://localhost:7000/main

You'll see the default demo mustache output.