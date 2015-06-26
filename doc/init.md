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
     |--syclink
         |--test-files-go-here
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

