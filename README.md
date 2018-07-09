# redmine_preview_pdf

Plugin for Redmine. Show pdf attachments in preview pane. Also will show pdf thumbnails.
This plugin includes the functionality of redmine_thumbnail_pdf

### Use case(s)

* View first page of a large pdf-file as a smaller preview image in Redmine's preview pane

### Install

1. go to plugins folder

`git clone https://github.com/HugoHasenbein/redmine_preview_pdf.git`

2. restart server f.i.  `sudo /etc/init.s/apache2 restart`

### Uninstall

2. go to plugins folder

`rm -r redmine_preview_pdf`

3. restart server f.i.  `sudo /etc/init.s/apache2 restart`

### Use

* Go to Administration->Settings->Display and choose "Display attachment thumbnails"
* Go to issues and view your pdf attachments as thumbnailable images
* On Issue show page click on a pdf attachmen to to view the first page of the pdf - good for large pdf files

**Have fun!**

### Localisations

* N.A. - no localizable strings present in plugin

### Change-Log* 

**1.0.1** Running on Redmine 3.4.6
