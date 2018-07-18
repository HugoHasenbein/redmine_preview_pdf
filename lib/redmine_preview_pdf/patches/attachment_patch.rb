# encoding: utf-8
#
# Redmine plugin to show pdf attachments as thumbnails
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
    module AttachmentPatch
      def self.included(base)
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)
        base.class_eval do
          unloadable
          

          # Returns the full path the attachment pdf preview, or nil
          # if the preview cannot be generated.
          def preview_pdf(options={})
            if is_pdf? && readable?
              size = options[:size].to_i
              if size > 0
                # Limit the number of previews per image
                size = (size / 50) * 50
                # Maximum preview size
                size = 1600 if size > 1600
              else
                size = Setting.thumbnails_size.to_i
              end
              size = 100 unless size > 0
              target = File.join(self.class.thumbnails_storage_path, "#{id}_#{digest}_#{size}.png")

              begin
                Redmine::Thumbnail.generate_preview_pdf(self.diskfile, target, size)
              rescue => e
                logger.error "An error occured while generating preview for #{disk_filename} to #{target}\nException was: #{e.message}" if logger
                return nil
              end
            end
          end #def

        end #base
      end #def

       module InstanceMethods        
       end #module      

       module ClassMethods
       end #module

    end
  end  
end

unless Attachment.included_modules.include?(RedminePreviewPdf::Patches::AttachmentPatch)
    Attachment.send(:include, RedminePreviewPdf::Patches::AttachmentPatch)
end


