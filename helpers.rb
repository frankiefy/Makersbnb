module ApplicationHelper
  def current_user
    @current_user ||= User.first(email: session[:email])
  end

  def check_user_existing
    redirect '/user/login' unless current_user
  end

  def correct_date_format(date)
    date.strftime('%d/%m/%Y')
  end
end
