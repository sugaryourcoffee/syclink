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
* website list    - list alle website or search for websites
* website add     - Create a new website
* website default - Set the default website to operate on
* website remove  - Remove website
* website make    - Make a HTML representation of the website

_Link commands_
* add    - Add a link
* update - Update a link
* remove - Remove a link
* invoke - Invoke a link
* list   - List all links with an optional filter
* find   - Find links based on a search string

Commands
========
Following the commands and how to use them is explained based on examples.

Create a website
----------------
To create a website we use the command `create`

    $ syclink --create --title TITLE

This create a website called TITLE.html in the default directory at
`~/.syc/syclink/html/TITLE.html

Add a link
----------
A link may have a title, a descritption and a tag. title, description and tag
are optional but a link obviously has to be provided. If no title is given the
link is used as the title.
  
    $ syclink http://example.com --title "Test page" --tag TEST

It is also possible to add links from a file

    $ syclink file-with-links


