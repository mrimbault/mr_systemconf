
# Configuration file to manage various *PATH environment variables.

# Set PATH so it includes user's private bin if it exists.
if [ -d "${HOME}/bin" ]; then
    PATH="${HOME}/bin:$PATH"
fi

# FIXME custom PATH for ruby
export PATH="${HOME}/.gem/ruby/2.3.0/bin:$PATH"




