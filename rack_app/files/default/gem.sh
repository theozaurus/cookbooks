if [ -d ~/.gem/ruby/1.8/bin ]; then
  export PATH=~/.gem/ruby/1.8/bin:$PATH
  export GEM_HOME=~/.gem/ruby/1.8
fi

if [ -d ~/.gem/ruby/1.9/bin ]; then
  export PATH=~/.gem/ruby/1.9/bin:$PATH
  export GEM_HOME=~/.gem/ruby/1.9
fi