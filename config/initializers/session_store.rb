# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ClickCounter_session',
  :secret      => '2d41738a7dcf6df70f1e65b82352f24c745d52d3c9e6af3c812150a1818a847127ae2d27048234f929c9128cc9012f72e9205f6a5c5588e1a12a088ddaef1ec7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
