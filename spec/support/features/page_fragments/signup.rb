module PageFragments
  module Signup
    def submit_with(args)
      args.each{|(label,value)| browser.fill_in(label.capitalize, with: value) }
      browser.click_on('Sign up')
    end
  end
end
