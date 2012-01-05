require 'ramaze'   # Always required

# Sets the root directory to the current directory by default. Feel free to
# add more directories when needed.
Ramaze.options.roots = [__DIR__]

require __DIR__('autoloader')

# Can we possibly autoload this? Seems ramaze needs all controllers pre-required...
require __DIR__('classes/controller/main')