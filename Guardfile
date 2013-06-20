# A sample Guardfile
# More info at https://github.com/guard/guard#readme

# Add files and commands to this file, like the example:
#   watch(%r{file/path}) { `command(s)` }
#
# guard 'shell' do
#   watch(/(.*).txt/) {|m| `tail #{m[0]}` }
# end

guard 'sublime-ctags' do
  watch(%r{^(app|config|lib|vendor).*(/[^.][^/]+$)})
end

guard 'sublime-gemtags' do
  watch("Gemfile.lock")
end

guard 'annotate' do
  watch( 'db/schema.rb' )

  # Uncomment the following line if you also want to run annotate anytime
  # a model file changes
  #watch( 'app/models/**/*.rb' )

  # Uncomment the following line if you are running routes annotation
  # with the ":routes => true" option
  #watch( 'config/routes.rb' )
end
