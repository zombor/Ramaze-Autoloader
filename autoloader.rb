$LOAD_PATH.unshift(__DIR__+'/')

module Autoloader
  # == Model Module
  #
  # Models are the back end classes that handle business logic and data access. They accept input from controllers,
  # and can manipulate data sources such as databases and other kinds of data.
  #
  # === Creating Model Files
  #
  # You can use any kind of modeling library to represent your models, such as DataMapper or ActiveRecord.
  # You can also create "raw" models that don't use a library, and directly access a database. You will need
  # to include your own database access methods in this case
  #
  # === Model Naming Conventions
  # * Models live in the Picombo::Models namespace. They must be prefaced with these modules in the file
  # * Models are placed in the /models directory
  # * Model filenames must be named the same as the class name: class Foobar would live in /models/foobar.rb
  # * Model filenames must be lowercase
  module Model
    # Autoloader for missing models
    def Model.const_missing(name)
      filename = name.to_s

      require 'classes/model/'+filename.downcase.gsub(/_/, '/')

      raise filename+' not found!' if ! const_defined?(name)

      klass = const_get(name)
      return klass if klass
      raise klass+" not found!"
    end
  end

  # == Controller Module
  #
  # Controllers are the front level classes that expose your app to the web. They pass information to the model,
  # retrieve information from the model, and pass data to views, which contain the final output for users.
  #
  # === Calling Controllers
  # Controllers are called via URIs, i.e. http://example.com/foobar/baz
  # * Segment #1 is the controller name
  # * Segment #2 is the controller method to call
  #
  # Controller Naming Conventions
  # * Controllers live in the Picombo::Controllers namespace. They must be prefaced with these modules in the file
  # * Controllers are placed in the /controllers directory
  # * Controller filenames must be named the same as the class name: class Foobar would live in /controllers/foobar.rb
  # * Controller filenames must be lowercase
  #
  # === Controller Arguments
  # Controller arguments are passed via URI segments after the second, i.e. http://example.com/foobar/baz/foo/bar
  # * This would match the baz method of the foobar controller, and match the arg1 and arg2 method arguments
  # * def baz(arg1, arg2)
  # The arguments must match the method exactly or a 404 exception will occur
  #
  # === Example Controller
  #
  #   module Picombo
  #     module Controllers
  #       class Foobar
  #         def index
  #           Picombo::Core.response('Hello World!')
  #         end
  #       end
  #     end
  #   end
  # This controller and method could be called via http://example.com/foobar/index
  module Controller
    # Autoloader for missing controller names
    def Controller.const_missing(name)
      filename = name.to_s

      require 'classes/controller/'+filename.downcase.gsub(/_/, '/')

      raise LoadError if ! const_defined?(name)

      klass = const_get(name)
      return klass if klass
      raise LoadError
    end
  end

  # == Mustache Module
  # 
  # Picombo comes with builtin support for Mustache view templates
  # 
  # === How to use
  # 
  # All view files go into the views folder. You need a .rb class along with a .mustache template file. Your view class files should extend the Mustache class:
  # 
  #   module Picombo
  #     module Stache
  #       class Home_Index < Mustache
  #         self.template = File.open(Picombo::Core.find_file('views', 'home/index', true, 'mustache').shift).read
  #       end
  #     end
  #   end
  # 
  # You should always set the template in your class. In most scenarios, it's easiest to read it in from a file as displayed above. You can also specify a raw string template there and not do the file read.
  # 
  # To render the template to your browser, use the output method:
  #   Picombo::Stache::Home_Index.new.output
  
  module Stashe
    require 'mustache'
    Mustache.template_path = __DIR__('templates')

    # Autoloader for missing mustache classes.
    def Stashe.const_missing(name)
      filename = name.to_s

      require __DIR__('classes/view/'+filename.downcase.gsub(/_/, '/'))

      raise name.inspect+' not found!' if ! const_defined?(name)

      const_get(name)
    end
  end
end