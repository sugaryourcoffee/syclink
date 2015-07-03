Create Directory Structure
==========================
We follow the _RubyGems_ convention to organize a Ruby project. We create a
directory structure as follows.

````
syclink
 |
 |--LICENSE
 |--README.md
 |--bin
 |   |--command-line-file-goes-here
 |--lib
 |   |-syclink
 |      |--application-files-go-here
 |
 |--spec
 |   |--syclink
 |       |--test-files-go-here
 |--templates
 |   |--syclink.html.erb
 |   |--stylesheets
 |       |--style.css.scss
 |       |--style.css
 |--.rspec
 |--.gitignore
````

Organize the  source code with Git
=================================
To organize our source we use _Git_ and have to do an initialize like so

    $ git init

Then we have to create a repository at [Github](https://github.com) and push
our project to _Github_

    $ git commit -m "first commit"
    $ git remote add origin git@github.com:sugaryourcoffee/syclink.git
    $ git push -u origin master

Create addtional basic files
============================
We should add a README to describe our application and decide upon a license
we want to distribute it. We will use the [MIT License](http://opensource.org/licenses/MIT). 
Also a _.gitignore_ file should be created to exclude i.e. temp-files from the 
repository.

Select the Ruby version
=======================
For a new project we want to use the newst Ruby version. At this writing it is
verison 2.2.1. Suppose we use [RVM](https://rvm.io/). If not already installed
we install it with

    $ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    $ \curl -sSL https://get.rvm.io | bash -s stable
    $ rvm install 2.2.1
    $ rvm use 2.2.1

Install RSpec
=============
For tests we want to use _RSpec_. To install RSpec issue this command

    $ gem install rspec

This will install the latest version. To see results of RSpec in color add
following line to _.rspec_ in the application's root directory

    --color

Install Sass
============
As we will create a html file with links we need to style with CSS. But instead
of using plain CSS we will use Scss. For that we need to install Sass

    $ gem install sass

Then we can write stylesheets in the sassy style and when done compile them
to CSS with

    $ sass templates/stylesheets/style.scss:templates/stylesheets/style.css

Distribution
============
To distribute the application we need the gemspec and a Rakefile with the
'rubygems/package\_task'.

From the command line we call

    $ rake package

This will create a gem package we can distribute with

    $ gem push pkg/syclink-0.0.1.gem
    Enter your RubyGems.org credentials.
    Don't have an account yet? Create one at https://rubygems.org/sign_up
       Email:   pierre@sugaryourcoffee.de
       Password:

    Signed in.
    Pushing gem to https://rubygems.org...
    Successfully registered gem: syclink (0.0.1) 

