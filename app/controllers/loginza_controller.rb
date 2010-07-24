require 'pp'

class LoginzaController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def new

  end

  def create
    pp params
    puts '--------------------'
    result = Net::HTTP.get_print(URI::parse('http://loginza.ru/api/authinfo/?token=' + params[:token]))
    pp result


#    if data = Loginza.user_data(params[:token])
#      data = {:name => data[:username], :email => data[:email], :identifier => data[:identifier]}
#      self.current_user = User.find_by_identifier(data[:identifier]) || User.create!(data)
#      redirect_to '/'
#    else
#      flash[:error] = :default
#      redirect_to :action => :new
#    end
  end
end
