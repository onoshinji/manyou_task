class ApplicationController < ActionController::Base
  # セキュリティ対策としての一文である。CSRF対策
  protect_from_forgery with: :exception
  include SessionsHelper
end
