# _cset is a method from the original
# Capistrano code.
#
# https://github.com/capistrano/capistrano/blob/cb38c68bf9ec079590e6124728a1027668914f68/lib/capistrano/recipes/deploy.rb#L5
#
# It wasn't accessible through this gem
# so I had to copy it there.
def _cset(name, *args, &block)
  unless exists?(name)
    set(name, *args, &block)
  end
end
