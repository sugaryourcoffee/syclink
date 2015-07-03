var search_data = {"index":{"searchIndex":["object","syclink","designer","exporter","formatter","infrastructure","link","website","add_link()","add_link()","add_links_from_file()","contains?()","copy_file_if_missing()","create_directory_if_missing()","create_website()","cut()","delete_website()","extract_columns()","find_links()","find_links()","formatter_string()","html_file()","link_attribute_list()","links_group_by()","list_links()","list_links()","load_config()","load_website()","match?()","max_column_widths()","new()","new()","new_website()","print_header()","print_horizontal_line()","print_links()","print_table()","remove_link()","remove_links()","save_website()","table()","to_html()","update()","update_link()","yaml_file()","gemfile","gemfile.lock","license","readme","readme","links.csv","setup","syclink.gemspec","syclink","example.html","links","style.css","style.css.map","style.css.scss","syc-link.html"],"longSearchIndex":["object","syclink","syclink::designer","syclink::exporter","syclink::formatter","syclink::infrastructure","syclink::link","syclink::website","syclink::designer#add_link()","syclink::website#add_link()","syclink::designer#add_links_from_file()","syclink::link#contains?()","syclink::infrastructure#copy_file_if_missing()","syclink::infrastructure#create_directory_if_missing()","syclink::designer#create_website()","syclink::formatter#cut()","syclink::designer#delete_website()","syclink::formatter#extract_columns()","syclink::designer#find_links()","syclink::website#find_links()","syclink::formatter#formatter_string()","syclink::infrastructure#html_file()","syclink::website#link_attribute_list()","syclink::website#links_group_by()","syclink::designer#list_links()","syclink::website#list_links()","syclink::infrastructure#load_config()","syclink::designer#load_website()","syclink::link#match?()","syclink::formatter#max_column_widths()","syclink::link::new()","syclink::website::new()","syclink::designer#new_website()","syclink::formatter#print_header()","syclink::formatter#print_horizontal_line()","object#print_links()","syclink::formatter#print_table()","syclink::website#remove_link()","syclink::designer#remove_links()","syclink::designer#save_website()","syclink::formatter#table()","syclink::exporter#to_html()","syclink::link#update()","syclink::designer#update_link()","syclink::infrastructure#yaml_file()","","","","","","","","","","","","","","",""],"info":[["Object","","Object.html","",""],["SycLink","","SycLink.html","","<p>Module that creates a link list and generates an html representation\n<p>Module that creates a link list and …\n"],["SycLink::Designer","","SycLink/Designer.html","","<p>Creates a designer that acts as a proxy between the user and the website.\nThe designer will create a …\n"],["SycLink::Exporter","","SycLink/Exporter.html","","<p>Methods to export data into specific formats\n"],["SycLink::Formatter","","SycLink/Formatter.html","","<p>Methods to print data in a formatted way\n"],["SycLink::Infrastructure","","SycLink/Infrastructure.html","","<p>Helper methods to setup the infrastructure for syclink\n"],["SycLink::Link","","SycLink/Link.html","","<p>Creates a link with url, name, description and tag\n"],["SycLink::Website","","SycLink/Website.html","","<p>A Website is organizing a link list. The links can be added, updated and \nremoved. It is also possible …\n"],["add_link","SycLink::Designer","SycLink/Designer.html#method-i-add_link","(url, args = {})","<p>Adds a link based on the provided arguments to the website\n"],["add_link","SycLink::Website","SycLink/Website.html#method-i-add_link","(link)","<p>Add a link to the website\n"],["add_links_from_file","SycLink::Designer","SycLink/Designer.html#method-i-add_links_from_file","(file)","<p>Reads arguments from a CSV file and creates links accordingly. The links\nare added to the websie\n"],["contains?","SycLink::Link","SycLink/Link.html#method-i-contains-3F","(search)","<p>Checks whether the search string is contained in one or more of the\nattributes. If the search string …\n"],["copy_file_if_missing","SycLink::Infrastructure","SycLink/Infrastructure.html#method-i-copy_file_if_missing","(file, to_directory)","<p>Copies a file to a target directory\n"],["create_directory_if_missing","SycLink::Infrastructure","SycLink/Infrastructure.html#method-i-create_directory_if_missing","(directory)","<p>Creates a directory if it does not exist\n"],["create_website","SycLink::Designer","SycLink/Designer.html#method-i-create_website","(directory, template_filename)","<p>Creates the html representation of the website. The website is saved to the\ndirectory with websites title …\n"],["cut","SycLink::Formatter","SycLink/Formatter.html#method-i-cut","(string, size)","<p>Cuts the string down to the specified size\n"],["delete_website","SycLink::Designer","SycLink/Designer.html#method-i-delete_website","(directory)","<p>Deletes the website if it already exists\n"],["extract_columns","SycLink::Formatter","SycLink/Formatter.html#method-i-extract_columns","(rows, header)","<p>Extracts the columns to display in the table based on the header column\nnames\n"],["find_links","SycLink::Designer","SycLink/Designer.html#method-i-find_links","(search)","<p>Finds links based on a search string\n"],["find_links","SycLink::Website","SycLink/Website.html#method-i-find_links","(search)","<p>Finds all links that contain the search string\n"],["formatter_string","SycLink::Formatter","SycLink/Formatter.html#method-i-formatter_string","(widhts, separator)","<p>Creates a formatter string based on the widths and the column separator\n"],["html_file","SycLink::Infrastructure","SycLink/Infrastructure.html#method-i-html_file","(directory = '.', website)","<p>Creates an html filename to save the html representation of the website to\n"],["link_attribute_list","SycLink::Website","SycLink/Website.html#method-i-link_attribute_list","(attribute)","<p>List all attributes of the links\n"],["links_group_by","SycLink::Website","SycLink/Website.html#method-i-links_group_by","(attribute)","<p>Groups the links on the provided attribute\n"],["list_links","SycLink::Designer","SycLink/Designer.html#method-i-list_links","(args = {})","<p>List links contained in the website and optionally filter on attributes\n"],["list_links","SycLink::Website","SycLink/Website.html#method-i-list_links","(args = {})","<p>List links that match the attributes\n"],["load_config","SycLink::Infrastructure","SycLink/Infrastructure.html#method-i-load_config","(file)","<p>Loads the configuration from a file\n"],["load_website","SycLink::Designer","SycLink/Designer.html#method-i-load_website","(website)","<p>Loads a website based on the provided YAML-file and asigns it to the\ndesigner to operate on\n"],["match?","SycLink::Link","SycLink/Link.html#method-i-match-3F","(args)","<p>Checks whether the link matches the values provided by args and returns\ntrue if so otherwise false\n"],["max_column_widths","SycLink::Formatter","SycLink/Formatter.html#method-i-max_column_widths","(columns, header)","<p>Determines max column widths for each column based on the data and header\ncolumns\n"],["new","SycLink::Link","SycLink/Link.html#method-c-new","(url, params = {})","<p>Create a new link with url and params. If params are not provided  defaults\nare used for name the url …\n"],["new","SycLink::Website","SycLink/Website.html#method-c-new","(title = \"Link List\")","<p>Create a new Website\n"],["new_website","SycLink::Designer","SycLink/Designer.html#method-i-new_website","(title = \"SYC LINK\")","<p>Creates a new website where designer can operate on\n"],["print_header","SycLink::Formatter","SycLink/Formatter.html#method-i-print_header","(header, formatter)","<p>Prints the table&#39;s header\n"],["print_horizontal_line","SycLink::Formatter","SycLink/Formatter.html#method-i-print_horizontal_line","(line, separator, widths)","<p>Prints a horizontal line below the header\n"],["print_links","Object","Object.html#method-i-print_links","(links, columns)",""],["print_table","SycLink::Formatter","SycLink/Formatter.html#method-i-print_table","(columns, formatter)","<p>Prints columns in a table format\n"],["remove_link","SycLink::Website","SycLink/Website.html#method-i-remove_link","(link)","<p>Remove a link from the website\n"],["remove_links","SycLink::Designer","SycLink/Designer.html#method-i-remove_links","(urls)","<p>Deletes one or more links from the website. Returns the deleted links.\nExpects the links provided in …\n"],["save_website","SycLink::Designer","SycLink/Designer.html#method-i-save_website","(directory)","<p>Saves the website to the specified directory with the downcased name of the\nwebsite and the extension …\n"],["table","SycLink::Formatter","SycLink/Formatter.html#method-i-table","(rows, header)","<p>Based on the rows provided and the header values a table is printed\n"],["to_html","SycLink::Exporter","SycLink/Exporter.html#method-i-to_html","(template)","<p>Creates an html file based on an erb template\n"],["update","SycLink::Link","SycLink/Link.html#method-i-update","(args)","<p>Updates the attributes of the link specified by args\n"],["update_link","SycLink::Designer","SycLink/Designer.html#method-i-update_link","(url, args)","<p>Updates a link. The link is identified by the URL. If there is more than\none link with the same URL, …\n"],["yaml_file","SycLink::Infrastructure","SycLink/Infrastructure.html#method-i-yaml_file","(directory = '.', website)","<p>Creates the filename of the website for saving, loading and deleting\n"],["Gemfile","","Gemfile.html","","<p>source &#39;rubygems.org&#39; gemspec\n"],["Gemfile.lock","","Gemfile_lock.html","","<p>PATH\n\n<pre>remote: .\nspecs:\n  syclink (0.0.1)\n    gli (= 2.13.1)</pre>\n<p>GEM\n"],["LICENSE","","LICENSE.html","","<p>The MIT License (MIT)\n<p>Copyright © 2015 sugaryourcoffee\n<p>Permission is hereby granted, free of charge, …\n"],["README","","README_md.html","","<p>syclink\n<p><em>syclink</em> is a comand line application to create a website with a\nlink\ncollection. <em>syclink</em> allows ...\n"],["README","","README_rdoc.html","","<p>syclink\n<p>syclink can be used to create link list and turn them into an html \nrepresentation.\n<p>Detailed information …\n"],["links.csv","","links_csv.html","","<p>syc.dyndns.org:8080;Secondhand;Kinder- und Kleiderbörse;Sales\nsyc.dyndns.org:8081;Apptrack;Application …\n"],["setup","","setup_md.html","","<p>Create Directory Structure\n<p>We follow the <em>RubyGems</em> convention to organize a Ruby project. We\ncreate a\ndirectory ...\n"],["syclink.gemspec","","syclink_gemspec.html","","<p># Ensure we require the local version and not one we might have installed\nalready require File.join( …\n"],["syclink","","syclink_rdoc.html","","<p>syclink\n<p>NAME\n\n<pre>syclink - Create a link list and display it as an html page</pre>\n"],["example.html","","templates/example_html.html","","<p>&lt;!DOCTYPE html&gt; &lt;html lang=“en-CA”&gt;\n\n<pre>&lt;head&gt;\n  &lt;meta charset=&quot;utf-8&quot;&gt;\n  &lt;title&gt;Test&lt;/title&gt; ...</pre>\n"],["links","","templates/links.html","","<p>example.com;Example;An example website;Web\nsyc.dyndns.org:8080;Secondhand;Kinderkleider- und Spielzeugbörse;Sales …\n"],["style.css","","templates/stylesheets/style_css.html","","<p>header#page_header {\n\n<pre>background-color: #888888;\ncolor: #fff;\nheight: 68px;\nmargin-bottom: 10px;\noverflow: ...</pre>\n"],["style.css.map","","templates/stylesheets/style_css_map.html","","<p>{ “version”: 3, “mappings”:\n“AAAA,kBAAmB;EACjB,gBAAgB,EAAE,OAAO;EACzB,KAAK,EAAE,IAAI;EACX,MAAM,EAAE,IAAI;EACZ,aAAa,EAAE,IAAI;EACnB,QAAQ,EAAE,MAAM;EAChB,OAAO,EAAE,SAAS;;AAGpB,kBAAmB;EACjB,gBAAgB,EAAE,OAAO;EACzB,aAAa,EAAE,kBAAkB;EACjC,KAAK,EAAE,IAAI;EACX,MAAM,EAAE,IAAI;EACZ,OAAO,EAAE,SAAS;EAClB,KAAK,EAAE,IAAI;EAEX,qBAAG;IACD,eAAe,EAAE,IAAI;IACrB,OAAO,EAAE,MAAM;IAEf,wBAAG;MACD,KAAK,EAAE,IAAI;MACX,mCAAa;QACX,KAAK,EAAE,KAAK;;AAMpB,UAAW;EACT,MAAM,EAAE,QAAQ;;AAGlB,YAAa;EACX,KAAK,EAAE,IAAI;EACX,KAAK,EAAE,GAAG;EACV,MAAM,EAAE,YAAY;;AAGtB,eAAgB;EACd,KAAK,EAAE,KAAK;EACZ,KAAK,EAAE,GAAG;EACV,MAAM,EAAE,YAAY;EACpB,kBAAG;IACD,eAAe,EAAE,IAAI;;AAIzB,CAAE;EACA,eAAe,EAAE,IAAI;EACrB,OAAQ;IACN,eAAe,EAAE,SAAS;;AAI9B,KAAM;EAAG,eAAe,EAAE,QAAQ;EAChC,KAAK,EAAE,IAAI;EAEX,kBAAO;IACL,MAAM,EAAE,IAAI;EAGd,QAAG;IACD,gBAAgB,EAAE,OAAO;IACzB,KAAK,EAAa,IAAI;EAKpB,gCAAoB;IAClB,gBAAgB,EAAE,OAAO”,\n…\n"],["style.css.scss","","templates/stylesheets/style_css_scss.html","","<p>header#page_header {\n\n<pre>background-color: #888888;\ncolor: #fff;\nheight: 68px;\nmargin-bottom: 10px;\noverflow: ...</pre>\n"],["syc-link.html","","templates/syc-link_html.html","","<p>&lt;!DOCTYPE html&gt; &lt;html lang=“en-CA”&gt;\n\n<pre>&lt;head&gt;\n  &lt;meta charset=&quot;utf-8&quot;&gt;\n  &lt;title&gt;SYC ...</pre>\n"]]}}