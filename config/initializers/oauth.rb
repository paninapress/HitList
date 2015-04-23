Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, ENV['API_KEY'], ENV['SECRET_KEY'],
  :scope => 'r_basicprofile r_network',
  :callback_path => '/auth/linkedin/callback',
  :fields => ["id", "email-address", "first-name", "last-name", "picture-url", "connections"]
end