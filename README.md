# redmine_preview_pdf

Plugin for Redmine. Show pdf attachments in preview pane. Also will show pdf thumbnails.
This plugin requires imagemagick and ghostscript to be installed

![PNG that represents a quick overview](/doc/Overview.png)

### Use case(s)

* View first page of a large pdf-file as a smaller preview image in Redmine's preview pane

### Install

1. download plugin and copy plugin folder redmine_preview_pdf go to Redmine's plugins folder 

2. restart server f.i.  

`sudo /etc/init.d/apache2 restart`

### Uninstall

1. go to plugins folder, delete plugin folder redmine_preview_pdf

`rm -r redmine_preview_pdf`

2. restart server f.i.  

`sudo /etc/init.d/apache2 restart`

### Use

* Go to Administration->Information and verify if ImageMagick and Ghostscript are installed
* Go to Administration->Settings->Display and choose "Display attachment thumbnails"
* Go to issues and view your pdf attachments as thumbnailable images
* On Issue show page click on a pdf attachmen to to view -depending on your choice-
  * the first page of the pdf as an image - good for large pdf files
  * the whole pdf embedded

* Starting with version 1.0.3 choose to either embed full pdf in preview pane or only image of first page

**Have fun!**

### Localisations

* 1.0.3 
  - added option to embed original pdf instead of only first page
  - added check for Ghostscript availabilty under Administration->Information
  - option to choose beteween embedding method with iframe or object/embed (for enhanced compatibilty with legacy browswers)
* 1.0.2 
  - English
  - German
* 1.0.1 
  - no localizable strings present in plugin

### Change-Log* 

**1.0.2** 
 - added check for Ghostscript
 - added option to show full original pdf embedded in preview pane
 - added option how to embed pdf in preview pane with `<object><embed>` or `<iframe>`-tags
**1.0.1** Running on Redmine 3.4.6
