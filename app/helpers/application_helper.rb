module ApplicationHelper
  def bootstrap_class_for flash_type
    {'success'=> 'alert-success', 'notice'=> 'alert-info', 'error'=> 'alert-error', 'alert'=> 'alert-block'}[flash_type] || flash_type.to_s
    # Does not work {success: 'alert-success', notice: 'alert-info', error: 'alert-error', alert: 'alert-block'}[flash_type] || flash_type.to_s
  
  end
  

end
