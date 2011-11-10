require eliza

class JeevesController < ApplicationController

  respond_to :html
  respond_to :json, :only => :view

  def ping
	Eliza.respond(params[:msg])
