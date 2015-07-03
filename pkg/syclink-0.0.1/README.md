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

_Link commands_
* add    - Add a link
* file   - Add links from a file
* update - Update a link
* delete - Delete a link 
* list   - List all links with an optional filter
* find   - Find links based on a search string

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

