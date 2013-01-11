require 'pony'

module SilverLining
  class FailMail < Chef::Handler
 
    def initialize(from_address, to_address, cc_address)
      @from_address = from_address
      @to_address   = to_address
      @cc_address   = cc_address
    end
 
    def report
      unless run_status.success?
        subject = "[CHEF] Run failed on #{node.name}\n"
        message = "#{run_status.formatted_exception}\n"
        message << Array(backtrace).join("\n")

        if cc_address.nil?
          Pony.mail(:to => @to_address, :from => @from_address, :subject => subject, :body => message)
        else
          Pony.mail(:to => @to_address, :cc => @cc_address, :from => @from_address, :subject => subject, :body => message)
        end
      end
    end
  end
end
