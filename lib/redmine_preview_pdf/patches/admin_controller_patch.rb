# encoding: utf-8
#
# Redmine plugin to preview a pdf attachment file
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
    module AdminControllerPatch
      def self.included(base)
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable
            
          alias_method_chain :info, :gs_for_preview_pdf
          
        end #base
        
      end #self

      module InstanceMethods

        def info_with_gs_for_preview_pdf
        
         info_without_gs_for_preview_pdf
         @checklist << [:text_gs_available_for_preview_pdf, Redmine::Thumbnail.gs_available?]
        
        end #def 

      end #module  
      
      module ClassMethods      
      end #module    

    end #module
  end #module
end #module

unless AdminController.included_modules.include?(RedminePreviewPdf::Patches::AdminControllerPatch)
    AdminController.send(:include, RedminePreviewPdf::Patches::AdminControllerPatch)
end



