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

Rails.configuration.to_prepare do


  # link patches - model patches
  require 'redmine_preview_pdf/patches/attachment_patch'

  # link patches - helper patches
  require 'redmine_preview_pdf/patches/application_helper_patch'

  # link patches - controller patches
  require 'redmine_preview_pdf/patches/attachments_controller_patch'
  require 'redmine_preview_pdf/patches/admin_controller_patch'
  
  # link patches - library/core plugin patchges
  require 'redmine_preview_pdf/patches/thumbnail_patch'

end