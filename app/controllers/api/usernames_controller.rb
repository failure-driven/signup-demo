module Api
  class UsernamesController < ApiController
    def attempt
      @user = User.new(username: params[:username])
      return if username_valid?

      @not_valid = true
      @errors = @user.errors
      @username_suggestions = suggested_usernames(params[:username])
    end

    private

    def username_valid?
      params[:username] == '' ||
        @user.valid? ||
        @user.errors.messages[:username].blank?
    end

    def suggested_usernames(username)
      taken_usernames = User.where(
        User.arel_table[:username].matches("#{username}%")
      ).pluck(:username)
      @username_suggestions = (
        generated_usernames(username) - taken_usernames
      ).map { |suggestion| { username: suggestion } }
    end

    def generated_usernames(username)
      (1..9).to_a.each_with_object([]) do |index, suggestions|
        suggestions << [username, index].join
      end
    end
  end
end
