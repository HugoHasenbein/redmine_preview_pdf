# encoding: utf-8
#
# Redmine plugin to show all files as file icons or thumnails
#
# Copyright © 2018 Stephan Wenzel <stephan.wenzel@drwpatent.de>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#

module RedminePreviewPdf
  module Patches 
    module ApplicationHelperPatch
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.class_eval do

          unloadable 
          
		 def preview_pdf_tag(attachment, options={})
		 
            case Setting['plugin_redmine_preview_pdf']['pdf_embedding'].to_i
            
              when 0
                content_tag(:div, 
							 content_tag(
								 :object,
								 tag(:embed, :href => download_named_attachment_path(attachment, attachment.filename), :type => "application/pdf", :onload  => "resizeObject(this);"),
								 { :style   => "position:absolute;top:0;left:0;width:95%;height:100%;",
								   :title   => attachment.filename,
								   :type    => "application/pdf",
								   :data    => download_named_attachment_path(attachment, attachment.filename),
								   :onload  => "resizeObject(this);"
								  }.merge(options)
							 ),
							 :style => "position:relative;padding-top:141%;"
                )
              when 1
                content_tag(:div, 
							 content_tag(
								 :iframe,
								 "",
								 { :style                => "position:absolute;top:0;left:0;width:100%;height:100%;",
								   :seamless             => "seamless",
								   :scrolling            => "no",
								   :frameborder          => "0",
								   :allowtransparency    => "true",
								   :title                => attachment.filename,
								   :src                  => download_named_attachment_path(attachment, attachment.filename),
								   :onload               => "resizeObject(this);"
								  }.merge(options)
							 ),
							 :style => "position:relative;padding-top:141%;"
                )
              else
				_size = options.delete(:size) || 1600
				image_tag(
					preview_pdf_path(attachment, :size => _size),
					{ :class => "preview",
					  :srcset => "#{preview_pdf_path(attachment, :size => _size * 2)} 2x",
					  :style => "max-width: #{_size}px;",
					  :title => attachment.filename
					 }.merge(options)
				)
				
		   end #case
		   
		 end #def
		                    
        end #base
      end #self

      module InstanceMethods    
      end #module
      
    end #module
  end #module
end #module

unless ApplicationHelper.included_modules.include?(RedminePreviewPdf::Patches::ApplicationHelperPatch)
    ApplicationHelper.send(:include, RedminePreviewPdf::Patches::ApplicationHelperPatch)
end


