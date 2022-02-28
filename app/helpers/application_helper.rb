module ApplicationHelper
  def alert_notice
    return unless flash[:notice]

    "<div class='alert alert-info py-1'>#{flash[:notice]}</div>".html_safe
  end

  def alert_success
    return unless flash[:success]

    "<div class='alert alert-success py-1'>#{flash[:success]}</div>".html_safe
  end

  def alert_alert
    return unless flash[:alert]

    "<div class='alert alert-warning py-1'>#{flash[:alert]}</div>".html_safe
  end

  def active_page_class(current)
    return '' unless params[:controller] == current

    return 'active' if params[:controller].include? 'admin'

    'bg-light'
  end

  def order_status(status)
    { 'paid' => 'تم الدفع' }[status]
  end

  def user_status(status)
    return '<span class="badge bg-warning">محظور</span>'.html_safe if status

    '<span class="badge bg-success">مفعل</span>'.html_safe
  end
end
