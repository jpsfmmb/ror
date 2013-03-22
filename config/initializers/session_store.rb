# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_escola_session',
  :secret      => 'dfc11ad0a57efff7a1cf48cd09c6edbbc3c4987cb214aee865fd9c3db792d207d4f2e949ae048ec438a5a27d7fd911130b7103073e5858dc81ecc1c8dbb14c0f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
