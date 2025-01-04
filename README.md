syclink
=======
_syclink_ is a comand line application to create a website with a link 
collection. _syclink_ allows to add, update and delete links.

Installation
============
The application is installed with _RubyGems_

    $ gem install syclink

[![Gem Version](https://badge.fury.io/rb/syclink.svg)](http://badge.fury.io/rb/syclink)

Command Line Interface
======================
_syclink_ comes with a default website template and a CSS file. This can be
adjusted to your convenience.

Templates
---------
The templates are located in ~/.syc/syclink/templates and can be adjusted or
completely replaced.

Command Line
------------
Following list comprises the commands available

_Website commands_
* website show    - show all websites or search for websites
* website remove  - Remove website
* website create  - Create a HTML representation of the website
* website check   - Check links for availability

_Link commands_
* add link    - Add a link
* add file    - Add links read from a file
* update link - Update a link
* update file - Update links read from a file
* delete link - Delete one or more links
* delete file - Delete links based on URLs read from a file
* list        - List all links with an optional filter
* find        - Find links based on a search string
* merge       - Merge multiple links with same URL

_Import commands_
* import mf  - Import Mozilla Firefox bookmarks
* import gc  - Import Google Chrome bookmarks
* import ie  - Import Internet Explorer bookmarks
* import dir - Import links to files from a directory

_Export commands_
* export xml  - Export links in XML fromat (pending)
* export json - Export links in JSON format (pending)
* export csv  - Export links in csv format

Commands
========
Following the commands and how to use them is explained based on examples.

Create a website
----------------
A website is send to syclink with the global `-w` flag. If the website does not
exist yet the user is asked whether to create it and whether to set it as the
default website. This is done with commands that require a website to operate
on.

    $ syclink -w my-new-website add link "http://example.com"

Before the command `add link` is executed the website is created. In this 
case a website called 'my-new-website' is created in the default directory at
`~/.syc/syclink/websites/my-new-website.website

If an existing website is specified by the `-w` command and it is different
to the default command, the user is asked whether to set the selected 
website as the default one.

Commands that require a website are `add`, `update`, `delete`, `list`, `find`,
merge, import, export and `website create`.

If no website is specified the default website is used.

Link Commands
=============

Add a link
----------
A link may have a title, a description and a tag. Title, description and tag
are optional but a link obviously has to be provided. If no title is given the
link is used as the title.
  
    $ syclink add link --title "Test page" --tag TEST \
                       --description 'For testing purposes' http://example.com 

It is also possible to add links from a file

    $ syclink add file file-with-links

Update a link
-------------
To update a link the URL has to be specified. If more than one link has the 
same URL only the first link is updated.

    $ syclink update link --title "Example" http://example.com 

It is also possible to update links with links saved to a file

    $ syclink update file file-with-links

If many links have to be updated they can be exported to a csv file. Then
the changes are made in the csv file and finally the update command is called.

    $ syclink export csv > exported-links
    edit the links
    $ syclink update file exported-links

Delete a Link
-------------
To delete one or more links the URLs have to be provided.

    $ syclink delete link http://example.com http://challenge.com

It is also possible to delete links based on URLs saved in a file. Asume we 
have a file _urls_ with following content

    http://example.com
    http://challenge.com

Then we can delete the links with the URLs stored in the _urls_ file with

    $ syclink delete file urls

List links
----------
Links can be selected based on a filter. If no filter is given all links are
listed. It is possible to specify the columns to print. Possible columns are
`url`, `name`, `description` and `tag`.

    $ syclink list --tag TEST --columns 'url,description'

    url                | description
    -------------------+---------------------
    http://example.com | For testing purposes

The is a switch `--expand` and a flag `--width`. If no width is specified list
will print the complete content and probably mess up the table. With a width
specified the the columns are scaled so the overall width of the table will be
the size of width specified. The expand switch will expand the table to the 
specified width if the table would be smaller than width.

    $ syclink list --tag TEST --columns `url,description` --width 70 --expand

Find links
----------
It is also possible to search for links based on a search string. The find
command searches all attributes of the links and is searching for the occurance
of the search string within the attributes. So the search does not list exact 
matches only.

    $ syclink find --columns 'url,tag' 'example' 

    url                | tag
    -------------------+-----
    http://example.com | TEST

The `--expand` switch and the `--width` flag are also available with the 
`find` command. Details see at [List links](#list-links).

Merge Links
-----------
If there are multiple links with the same URL, these links can be merged. During a merge the first link found will be updated with the join of the values of the other links. 

    $ syclink add link --tag "Day" --name "Work" --description "Busy time" \
                       http://example.com
    $ syclink add link --tag "Night" --name "Fun" --description "Fun time" \
                       http://example.com
    $ syclink merge 
    $ syclink list

    url                | name      | description        | tag
    -------------------|-----------|--------------------|---------
    http://example.com | Day,Night | Busy time,Fun time | Work,Fun

Import Commands
===============
Bookmarks can be imported from _Mozilla Firefox_, _Google Chrome_, 
_Internet Explorer_ and from directories.

The command is `syclink import` followed by a sub-command indicating from which
web browser to import, or from which directory.

In case of importing from Internet Explorer and from a directory the parent
directories are used as tags beginning below the path to the Internet Explorer
directory or the standard directory. To control to which level the directory
should be used a `level` switch can be used.

    $ syclink import dir --level 2

will only use two parent directories as tags. It is also possible to specify
tags to use during import. In this case if level is 1 and also 1 tag is 
specified this tag is the only tag used.

    $ syclink import dir --level 1 --tags Books PATH/TO/BOOKS

If the level is greater than tags specified the difference between tags 
specified and levels is the number of parent directories added as tags

    $ syclink import dir --level 2 --tags Books PATH/TO/BOOKS

If there is a file in PATH/TO/BOOKS/RUBY then Books and RUBY is used as tags.

Firefox
-------
Firefox stores its bookmarks in a SQLite3 database called places.sqlite. With 
Ubuntu this database is usually located in 

    '~/.mozilla/firefox/*.default/places.sqlite'. 

If you are on Windows the file is located in the user's home directory 

    '~/AppData/Roaming/Mozilla/Profiles/*.default/places.sqlite'.

The bookmarks on Ubuntu can be imported with 

    $ syclink import mf ~/.mozilla/SOME_CRYPTIC_NAME.default/places.sqlite

Chrome
------
Google Chrome stores its bookmarks in a JSON file called Bookmarks. With Ubuntu
this file is usually located in 

    '~/.config/chromium/Default/Bookmarks'. 

If you are on Windows the file is located in the user's home directory 

    '~/AppData/Local/Google/Chrome/User Data/Bookmarks'.

The bookmarks on Ubuntu can be imported with 

    $ syclink import gc ~/.config/chromium/Default/Bookmarks

Internet Explorer
-----------------
Internet Explorer stores its bookmarks in a directory structure. The bookmarks 
are located in the user's home directory 

    '~/AppData/Favorites'

The bookmarks (of course on Windows) can be imported with

    $ syclink import ie ~/Appdata/Favorites

Directory
---------
The PATH\_TO\_DIRECTORY can have patterns that allows to import specific
files.

Examples:

    PATH_TO_DIRECTORY/**/*.pdf 
    
will import all pdf-files in the directories and sub-directory

    PATH_TO_DIRECTORY/**/* 
    
will import all files in the specified directory and sub-directories

To import all files from `some-directory` call

    $ syclink import dir ~/some-directory/**/*

A path given like ~/some-directory/ will be expanded to ~/some-directory/* which
will read all files in the given directory, but not in sub-directories.

If on Windows and the directory contains .URL-files the URL within the .URL-file
will be used as the link target.

Export Commands
===============
If links have to be changed in a buld then it is easier to do so in a file and
when done updating the links from the file.

The links can be exported with

    $ syclink export csv

This will print to the standard output. To save it to a file can be done as
follows

    $ syclink export csv > my-links

Now we can edit the links in the file and when done updating them like so

    $ sylinks update file my-links

Website Commands
================

Show websites
-------------
The websites are saved to `~/.syc/syclink/websites/` and the html 
representations are saved to `~/.syc/syclink/html/`. When listing websites
both _webstites_ and _html_ files are listed.

The following command will list all websites indicating the default website

    $ syclink website show
    [default] ~/.syc/syclink/website/one.website
              ~/.syc/syclink/website/two.website

To list websites based on a search string the search string has to be send to
the show command

    $ syclink website show "example"

If the `--exact` switch is given the command is listing exact matches of the 
search string only

    $ syclink website find -e "http://example.com"

Check websites
--------------
The `website check` command checks the availability of the urls and files. The 
result can be printed to the STDOUT in a table format or as CSV.

    $ syclink website check --table --width 70 --available --unavailable

Available URLs or Files show a response "200" and unavailable show "Error". It 
is also possible to choose upon the columns to print. Available columns are
`url` and `response`. If no columns flag is provided both columns are printed.

    $ syclink website check --columns "url,response" --table

Remove websites
---------------
Websites and their html representations can be deleted based on a filter string.
To delete all websites and respective html representation the filter string
'\*' can be provided

    $ syclink website remove "*"

    About to delete:

    Websites
    --------
    /home/user/.syc/syclink/website/example.website

    HTML-Files
    ----------
    /home/user/.syc/syclink/html/example.html

    Delete websites and corresponding html files (y/n)? 

Other exmamples of filter strings are `*mple` which will find `example` as well
as `ex*`.

Make a html representation of the website
-----------------------------------------
The ultimate command is `website create` which will create the html
representation of the website.

The html file is created based on an erb file located in 
`~/.syc/syclink/templates/syclink.html.erb`. This can be adjusted to your
convenience. The methods that can be used can be looked up in
`lib/syctask/website.rb`.

The html file will search for a css file in the directory `stylesheets` which
is relative to the html file. The stylesheet is named `styles.css`. It is 
possible to change it or replace it entirely. If the stylesheet's name is
changed this also has to be done in `~/.syc/syclink/templates/syclink.html.erb`.

There is also a _scss_ file which needs to be compiled to _css_ with _sass_
like so

    $ sass ~/.syc/syclink/html/stylesheets/styles.css.scss:\
      ~/.syc/syclink/html/stylesheets/styles.css

Warning: If the _css_ file has been changed all changes will be overridden by
_sass_.

Workflow
========
To create a website the steps are as follows

* add links to a website
* create the html representation

Following is showing the above sequence in commands

    $ syclink -w example add link "http://example.com" --tag EXAMPLE
    $ syclink add link "http://github.com" --tag DEVELOPMENT
    $ syclink website create

