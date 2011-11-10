class JeevesController < ApplicationController

  include Eliza
  respond_to :html
  respond_to :json, :only => :view

  def ping
	render :text => Eliza.respond(params[:msg])
	#render :text => "hi. what can I do for you?" + params[:msg]
  end
end
