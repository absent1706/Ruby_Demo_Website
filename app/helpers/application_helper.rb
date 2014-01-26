module ApplicationHelper
  include SessionsHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Ruby on Rails Tutorial Sample App"
    if page title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end



end
