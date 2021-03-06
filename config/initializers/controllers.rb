ActionController::Base.class_exec do

  protect_from_forgery

  layout "layouts/application_body_only"

  helper ApplicationHelper
  helper OpenStax::Utilities::OsuHelper

  helper_method :current_account, :current_administrator, :current_agent, :current_researcher

  protected

  def current_administrator
    Administrator.where(:account_id => current_account.id).first
  end

  def current_agent
    Agent.where(:account_id => current_account.id).first
  end

  def current_researcher
    Researcher.where(:account_id => current_account.id).first
  end

  def authenticate_administrator!
    current_administrator || raise(SecurityTransgression)
  end

  def authenticate_agent!
    current_agent || raise(SecurityTransgression)
  end

  def authenticate_researcher!
    current_researcher || raise(SecurityTransgression)
  end
end
