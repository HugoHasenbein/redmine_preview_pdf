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

# **1.0.4** fixed aspect ratio problem for img preview
# **1.0.3** cleaned code - never published
# **1.0.2** 
#  - added check for Ghostscript
#  - added option to show full original pdf embedded in preview pane
#  - added option how to embed pdf in preview pane with `<object><embed>` or `<iframe>`-tags
# **1.0.1** running on Redmine 3.4.6

require 'redmine'

Redmine::Plugin.register :redmine_preview_pdf do
  name 'Redmine Preview PDF'
  author 'Stephan Wenzel'
  description 'This is a plugin for Redmine to preview a pdf attachment file'
  version '1.0.4'
  url 'https://github.com/HugoHasenbein/redmine_preview_pdf'
  author_url 'https://github.com/HugoHasenbein/redmine_preview_pdf'

  # link to settings page
  # pdf_embedding
  #   0 - <object>-tag, fallback with <embed>-tag
  #   1 - <iframe>-tag
  #   2 - <img>-tag with only first page of pdf 
  #
  settings :default => {'pdf_embedding' 	=> '2' # use <img>-tag
                       },
           :partial => 'settings/redmine_preview_pdf/settings'

end

require "redmine_preview_pdf"
