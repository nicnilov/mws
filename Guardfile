# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec feature)

## Uncomment to clear the screen before every task
# clearing :on

## Guard internally checks for changes in the Guardfile and exits.
## If you want Guard to automatically start up again, run guard in a
## shell loop, e.g.:
##
##  $ while bundle exec guard; do echo "Restarting Guard..."; done
##
## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), the you will want to move the Guardfile
## to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

guard 'ctags-bundler', :src_path => ["lib", "spec"] do
  watch(/^(lib|spec)\/.*\.rb$/)
  watch('Gemfile.lock')
end

guard 'rspec', all_on_start: false, all_after_pass: false, cmd: 'bundle exec rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch('spec/spec_helper.rb')                  { "spec" }

  watch(%r{^lib/mws/(.+)\.rb$})                 { |m| "spec/unit/#{m[1]}_spec.rb" }
  watch(%r{^lib/mws/(.+)\.rb$})                 { |m| "spec/integration/#{m[1]}_spec.rb" }
  watch(%r{^spec/support/(.+)\.rb$})            { "spec" }
end
