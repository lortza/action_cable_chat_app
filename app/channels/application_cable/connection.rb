module ApplicationCable
  # Built when a new connection is made
  class Connection < ActionCable::Connection::Base
    include SessionsHelper
    # Identify the user
    identified_by :message_user

    def connect
      # Requires the current_user before connecting
      self.message_user = find_verified_user
    end

    private

    def find_verified_user
      if logged_in?
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
