class User < ApplicationRecord
   validate :validate_username

   private

   def validate_username
     if username.index(' ') or username.index("\t")
       errors.add(:username, 'cannot have white space')
     end

     if username.index('?')
       errors.add(:username, 'cannot have question mark')
     end
   end
end
