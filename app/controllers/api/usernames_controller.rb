module Api
  class UsernamesController < ApiController

    def attempt
      @user = User.new(username: params[:username])
      unless @user.valid?
        @errors = @user.errors
        taken_usernames = User.where(
          User.arel_table[:username].matches("#{params[:username]}%")
        ).pluck(:username)
        generated_usernames = (1..9).to_a
          .each_with_object([]){|index, suggestions| suggestions << [params[:username], index].join }
        @username_suggestions = (generated_usernames - taken_usernames)
          .map{|suggestion| {username: suggestion} }
      end
    end
  end
end
