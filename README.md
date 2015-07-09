syclink
=======
_syclink_ is a comand line application to create a website with a link 
collection. _syclink_ allows to add, update and delete links.

Installation
============
The application is installed with _RubyGems_

    $ gem install syclink

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
* website check   - Check from links that are not active anymore
* webiste edit    - Open the YAML file for editing

_Link commands_
* add    - Add a link
* file   - Add links from a file
* update - Update a link
* delete - Delete a link 
* list   - List all links with an optional filter
* find   - Find links based on a search string

_Import commands_
* import mf - Import Mozilla Firefox bookmarks
* import gc - Import Google Chrome bookmarks
* import ie - Import Internet Explorer bookumarks

_Export commands_
* export xml  - Export links in XML fromat
* export json - Export links in JSON format
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

    $ syclink -w my-new-website add "http://example.com"

Before the command `add` is executed the website is created. In this 
case a website called 'my-new-website' is created in the default directory at
`~/.syc/syclink/websites/my-new-website.website

Commands that require a website are `add`, `update`, `delete`, `list`, `find`
and `website create`.

If no website is specified the default website is used.

Add a link
----------
A link may have a title, a description and a tag. Title, description and tag
are optional but a link obviously has to be provided. If no title is given the
link is used as the title.
  
    $ syclink add --title "Test page" --tag TEST \
                  --description 'For testing purposes' http://example.com 

It is also possible to add links from a file

    $ syclink file file-with-links

Update a link
-------------
To update a link the URL has to be specified. If more than one link has the 
same URL only the first link is updated.

    $ syclink update --title "Example" http://example.com 

Remove a Link
-------------
To remove one or more links the URLs have to be provided.

    $ syclink delete http://example.com,http://challenge.com

List links
----------
Links can be selected based on a filter. If no filter is given all links are
listed. It is possible to specify the columns to print. Possible columns are
`url`, `name`, `description` and `tag`.

    $ syclink list --tag TEST --columns 'url,description'

    url                | description
    -------------------+---------------------
    http://example.com | For testing purposes

Find links
----------
It is also possible to search for links based on a search string. The find
command searches all attributes of the links and is searching for the occurance
of the search string within the attributes. So the search is not list only 
exact matches.

    $ syclink find --columns 'url,tag' 'example' 

    url                | tag
    -------------------+-----
    http://example.com | TEST

List websites
-------------
The websites are saved to `~/.syc/syclink/websites/` and the html 
representations are saved to `~/.syc/syclink/html/`. When listing websites
both _webstites_ and _html_ files are listed.

The following command will list all websites

    $ syclink website list

To list websites based on a search string the search string has to be send to
the list command

    $ syclink website list "example"

If the `--exact` switch is given the command is only listing exact matches of
the search string

    $ syclink website list -e "http://example.com"

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

    $ syclink -w example add "http://example.com" --tag EXAMPLE
    $ syclink add "http://github.com" --tag DEVELOPMENT
    $ syclink website create

Importing Bookmarks from Webrowsers
===================================

Firefox
-------
The bookmarks of _Firefox_ are located in the user's home folder in
`~/.mozilla/SOME_CRYPTIC_NAME.default/places.sqlite`.

The database can be explored with _sqlite3_ from the command line

    $ cd ~/.mozilla/SOME_CRYPTIC_NAME.default/
    $ sqlite3 places.sqlite
    >

We want to retrieve url, title, description, tag, key and bookmark. tag, key 
and bookmark are good candidates for tags for the application.

At the command prompt of SQLite3 We can issue the query

````
sqlite> select p.id, p.url, p.title, b.id, b.fk, b.parent, b.title, 
   ...> k.keyword, a.content, b_t.title from moz_bookmarks b 
   ...> left outer join moz_keywords k on b.keyword_id = k.id 
   ...> left outer join moz_items_annos a on a.item_id = b.id 
   ...> left outer join moz_bookmarks b_t on b.parent = b_t.id 
   ...> join moz_places p on p.id = b.fk where p.url like "http%";
1|https://www.mozilla.org/en-US/firefox/central/||6|1|3|Getting Started|||\
Bookmarks Toolbar
2|http://www.ubuntu.com/||8|2|7|Ubuntu|||Ubuntu and Free Software links
3|http://wiki.ubuntu.com/||9|3|7|Ubuntu Wiki (community-edited website)|||\
Ubuntu and Free Software links
4|https://answers.launchpad.net/ubuntu/+addquestion||10|4|7|Make a Support \
Request to the Ubuntu Community|||Ubuntu and Free Software links
5|http://www.debian.org/||11|5|7|Debian (Ubuntu is based on Debian)|||Ubuntu \
and Free Software links
6|https://one.ubuntu.com/||12|6|7|Ubuntu One - The personal cloud that brings\
your digital life together|||Ubuntu and Free Software links
7|https://www.mozilla.org/en-US/firefox/help/||14|7|13|Help and Tutorials|||\
Mozilla Firefox
8|https://www.mozilla.org/en-US/firefox/customize/||15|8|13|Customize \
Firefox|||Mozilla Firefox
9|https://www.mozilla.org/en-US/contribute/||16|9|13|Get Involved|||Mozilla \
Firefox
10|https://www.mozilla.org/en-US/about/||17|10|13|About Us|||Mozilla Firefox
4717|http://codekata.com/|CodeKata|30|4717|5|CodeKata|liklo|How do you get \
to be a great musician? It helps to know the theory,
and to understand the mechanics of your instrument. It helps to have
talent. But …|Unsorted Bookmarks
399|http://localhost:3000/|Secondhand | Home|34|399|2|Secondhand | Home|||\
Bookmarks Menu
12870|https://www.sqlite.org/cli.html|Command Line Shell For SQLite|35|12870|\
5|Command Line Shell For SQLite|dark|What is this sqlite all about?|Unsorted \
Bookmarks
4717|http://codekata.com/|CodeKata|37|4717|36||||wenga
12870|https://www.sqlite.org/cli.html|Command Line Shell For SQLite|39|12870|\
38||||lite
12883|http://ruby.bastardsbook.com/chapters/sql/#h-2-5|SQL | The Bastards \
Book of Ruby|40|12883|5|SQL | The Bastards Book of Ruby|||Unsorted Bookmarks
12883|http://ruby.bastardsbook.com/chapters/sql/#h-2-5|SQL | The Bastards \
Book of Ruby|42|12883|41||||Ruby
sqlite> 
````

