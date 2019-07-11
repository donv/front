# frozen_string_literal: true

module ApplicationHelper
  def txt(textile_source)
    textilize(textile_source).html_safe
  end
end
