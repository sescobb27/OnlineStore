module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end

  def hidden_link_if(condition, attributes = {})
  	if condition
  		attributes["style"] = "display: none"
  	end
  	content_tag("div", link_to(t('.log_in'), '#',attributes))
  end
end
