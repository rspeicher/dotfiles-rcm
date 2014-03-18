unless defined?(MACRUBY_VERSION)
  # print SQL to STDOUT
  if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
   require 'logger'
   RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
  end

  # Prompt behavior
  ARGV.concat [ '--rubygems', "--readline", "--prompt-mode", "simple" ]

  # Utilities
  begin
    require 'irb/completion'
    require 'rubygems'
    require 'ap'
    require 'interactive_editor'
  rescue LoadError
  end

  # History
  require 'irb/ext/save-history'
  IRB.conf[:SAVE_HISTORY] = 100
  IRB.conf[:AUTO_INDENT]  = true

  # Easily print methods local to an object's class
  class Object
    def local_methods
      (methods - Object.instance_methods).sort
    end
  end
end
