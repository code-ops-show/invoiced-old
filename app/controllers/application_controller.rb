class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  respond_to :json, :html, :js
  
  include Transponder::Transmission

  before_filter :set_gon_pusher

  before_action :set_fake_session

  def set_gon_pusher
    gon.pusher  = { key: '0ceb1f71fb0348080f2b' }
  end

  # in a real app you can use current_user.id or session or something
  def set_fake_session
    session[:who] ||= SecureRandom.hex(6)
    gon.who = session[:who]
  end

  protected
  def configure_devise_permitted_parameters
    registration_params = [:email, :first_name, :last_name, :address, :phone_number, :fax, :logo_image, :vat, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.for(:account_update) { 
        |u| u.permit(registration_params << :current_password)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.for(:sign_up) { 
        |u| u.permit(registration_params) 
      }
    end
  end
end

