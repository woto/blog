# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_uniqsystems_session',
  :secret      => 'c24eef6b9ffc8c7b1e599ac91b78ee9159289c93a5bd8f9036c20068d98d7f3b46bf200ee77cd8a7698e74b58363b6ae09652bf8ba4990aaf8e79703107770f5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
