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
    module ThumbnailPatch
      def self.included(base)
        base.extend(ClassMethods)
        base.send(:include, InstanceMethods)
        base.class_eval do

          unloadable 	
          
          # for those, who read and analyze code: I haven't figured it out yet how to unset 
          # a constant and how to patch a function, which has been defined as self.function()
          # in a base.class_eval block
          #
          @REDMINE_PREVIEW_PDF_GS_BIN        = 'gs'.freeze
		  @REDMINE_PREVIEW_PDF_CONVERT_BIN   = (Redmine::Configuration['imagemagick_convert_command'] || 'convert').freeze
		  @REDMINE_PREVIEW_PDF_ALLOWED_TYPES = %w(application/pdf)

		  # Generates a thumbnail for the source image to target
		  def self.generate_preview_pdf(source, target, size)

			return nil unless convert_available?

			unless File.exists?(target)

			  mime_type = ""
			  unless File.open(source) {|f| mime_type = MimeMagic.by_magic(f).try(:type); @REDMINE_PREVIEW_PDF_ALLOWED_TYPES.include? mime_type }
				return nil
			  end

			  page_num, background_switch = (mime_type =~ /application\/pdf/ ? ["[0]", "-background white -alpha remove -alpha off" ] : ["", ""])

			  directory = File.dirname(target)
			  unless File.exists?(directory)
				FileUtils.mkdir_p directory
			  end
			  size_option = "#{size}"

			  cmd = "#{shell_quote @REDMINE_PREVIEW_PDF_CONVERT_BIN} #{shell_quote source}#{page_num} #{background_switch} -thumbnail #{shell_quote size_option} #{shell_quote target}"

			  unless system(cmd)
				logger.error("Creating preview failed (#{$?}):\nCommand: #{cmd}")
				return nil
			  end
			end
			target
		  end #def 
		                     
		  def self.gs_available?
			return @gs_available if defined?(@gs_available)
			@gs_available = system("#{shell_quote @REDMINE_PREVIEW_PDF_GS_BIN} -version") rescue false
			logger.warn("Imagemagick's delegate (#{@REDMINE_PREVIEW_PDF_GS_BIN}) not available") unless @gs_available
			@gs_available
		  end

        end #base
      end #self

      module InstanceMethods          		  
      end #module
      
      module ClassMethods
      end #module
      
    end #module
  end #module
end #module

unless Redmine::Thumbnail.included_modules.include?(RedminePreviewPdf::Patches::ThumbnailPatch)
    Redmine::Thumbnail.send(:include, RedminePreviewPdf::Patches::ThumbnailPatch)
end


