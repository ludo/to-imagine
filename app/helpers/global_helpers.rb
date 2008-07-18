module Merb
  module GlobalHelpers
    # Little helper for selecting which menu will be active
    #
    # ==== Parameters
    # selected<Symbol>:: Name of the active menu
    #
    # --
    # @api public
    def menu(selected)
      @menu = selected
    end
    
    def render_menu
      menu = ""
      menu_items.sort { |a,b| a[1][:position] <=> b[1][:position] }.each do |item|
        # Set the active menu
        if item[0] == @menu
          item[1][:attrs] ||= {}
          item[1][:attrs][:class] = "#{item[1][:attrs][:class]} active"
        end

        # Create a tag for each item
      	menu += tag "li", item[1][:content], item[1][:attrs]
    	end
    	tag "ul", menu
    end
    
    # Set the <title> for a page
    #
    # --
    # @api public
    def title(value)
      throw_content(:for_title, "#{h(value)} - ")
    end
    
  private

    # Collection of menu items
    #
    # ==== Returns
    # Hash:: Hash containing menu items
    #
    # --
    # @api private
    def menu_items
      {
        :dashboard => {
          :content => link_to("Dashboard", url(:root)),
          :position => 1
        },
        :collections => {
          :content => link_to("Collections", url(:collections)),
          :position => 2
        },
        :upload => {
          :content => link_to("Upload", url(:new_image)),
          :position => 3,
          :attrs => { :class => "right" }
        }
      }
    end
  end
end
