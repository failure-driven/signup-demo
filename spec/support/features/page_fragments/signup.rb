module PageFragments
  module Signup
    def fill_in_with(args)
      args.each do |(label, value)|
        browser.fill_in(label.capitalize, with: value)
      end
    end

    def submit_with(args)
      fill_in_with(args)
      browser.click_on("Sign up")
    end
  end
end
