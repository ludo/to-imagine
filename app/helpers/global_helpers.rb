require 'digest/md5'

module Merb
  module GlobalHelpers

    # Display a Gravatar avatar
    #
    # TODO Allow options, like different sizes
    #
    # ==== Parameters
    # email<String>:: E-mail address to show Gravatar for
    #
    # ==== Returns
    # String:: An URL to a Gravatar
    #
    # --
    # @api public
    def gravatar(email)
      str = "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}.jpg?s=40"
    end

    # Display an asset
    #
    # ==== Parameters
    # asset<Asset>:: The asset
    # opts<Hash>:: Additional options for the asset tag (see below)
    #
    # ==== Options
    # :geometry<Symbol>:: Specify a geometry for the asset
    #
    # All other options are passed to the +image_tag+ helper in merb-assets.
    #
    # --
    # @api public
    def asset_tag(asset, opts = {})
      image_tag(asset_url(asset, opts[:geometry]))
    end

    # Generate an url to an asset
    #
    # ==== Parameters
    # asset<Asset>:: An Asset object
    #
    #
    # ==== Returns
    # String:: The URL for the asset
    #
    # --
    # @api public
    def asset_url(asset, geometry = nil)
      geometry = "#{geometry}." if geometry

      "#{url(:asset, asset)}/#{geometry}#{asset.filename}"
    end

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
        :albums => {
          :content => link_to("Albums", url(:albums)),
          :position => 2
        },
        :upload => {
          :content => link_to("Upload", url(:new_asset)),
          :position => 3,
          :attrs => { :class => "right" }
        }
      }
    end
  end

end
