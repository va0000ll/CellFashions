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
end
