class JeevesController < ApplicationController

  respond_to :html
  respond_to :json, :only => :view

  def ping
		
	"hi. what can I do for you?" + params[:msg]
