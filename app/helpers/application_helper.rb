module ApplicationHelper
  def nav_link_to(title, path)
    content_tag :li, class: current_page?(path) ? "active" : "inactive" do
      link_to(title, path)
    end
  end
end
