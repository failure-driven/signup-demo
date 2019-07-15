class User < ApplicationRecord
   validate :validate_username

   private

   def validate_username
     if username.index(' ')
       errors.add(:username, 'cannot have white space')
     end
   end
end
