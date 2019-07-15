class User < ApplicationRecord
   validate :validate_username

   private

   def validate_username
     if username.index(' ') or username.index("\t")
       errors.add(:username, 'cannot have white space')
     end
   end
end
