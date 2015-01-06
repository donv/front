module ApplicationHelper
  def txt(textile_source)
    textilize(textile_source).html_safe
  end
end
