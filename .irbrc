# Print to yaml format with "y"
require 'yaml'
# Pretty printing
require 'pp'
# Ability to load rubygem modules
require 'rubygems'
# Tab completion
require 'irb/completion'
# For coloration
require 'wirble'
require 'yieldmanager'

# Include line numbers and indent levels:
IRB.conf[:PROMPT][:SHORT] = {
  :PROMPT_C=>"%03n:%i* ",
  :RETURN=>"%s\n",
  :PROMPT_I=>"%03n:%i> ",
  :PROMPT_N=>"%03n:%i> ",
  :PROMPT_S=>"%03n:%i%l "
}
# Uses short prompts instead of the irb(main):001:0
IRB.conf[:PROMPT_MODE] = :SIMPLE
# Adds readline functionality
IRB.conf[:USE_READLINE] = true
# Auto indents suites
IRB.conf[:AUTO_INDENT] = true
# Where history is saved
# IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"
# How many lines to save
# IRB.conf[:SAVE_HISTORY] = 1000

# Turn turn on colorization, off other wirble wierdness
Wirble.init
Wirble.colorize


# Return only the methods not present on basic objects
class Object
  def interesting_methods
    (self.methods - Object.new.methods).sort
  end
end
