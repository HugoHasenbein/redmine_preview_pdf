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
		   _size = options.delete(:size) || 800
		   image_tag(
			   thumbnail_path(attachment, :size => _size),
			   { :class => "thumbnail",
			     :srcset => "#{thumbnail_path(attachment, :size => _size * 2)} 2x",
			     :style => "max-width: #{_size}px; max-height: #{_size}px; height: #{_size}px;",
                 :title => attachment.filename
			    }.merge(options)
		   )
		 end                      
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


