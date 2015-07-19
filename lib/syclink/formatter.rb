# Module that creates a link list and generates an html representation
module SycLink

  # Methods to print data in a formatted way
  module Formatter

    # Based on the rows (an array of Links) provided and the header values a 
    # table is printed. If the options :expand and or :width are specified the 
    # rows are scaled accordingly. If :expand is false the rows will be cut so 
    # they fit the :width. Otherwise if the rows are less than :width the rows 
    # are expanded to :width.
    #
    # Example
    # =======
    #   table(rows, header, width: 80, expand: true)
    #
    # Params
    # ======
    # rows::   array of Links with row values
    # header:: array of string with header values
    # width::  width of the table
    # expand:: whether to expand the table to width if rows are less than width
    def table(rows, header, opts = {})
      columns = extract_columns(rows, header)
      widths  = max_column_widths(columns, header, opts)
      formatter = formatter_string(widths, " | ")
      print_header(header, formatter)
      print_horizontal_line("-", "-+-", widths)
      print_table(columns, formatter)
    end

    # Based on the rows (an array of values) provided and the header values a 
    # table is printed. If the options :expand and or :width are specified the 
    # rows are scaled accordingly. If :expand is false the rows will be cut so 
    # they fit the :width. Otherwise if the rows are less than :width the rows 
    # are expanded to :width.
    #
    # Example
    # =======
    #   table(rows, header, width: 80, expand: true)
    #
    # Params
    # ======
    # rows::   array of row values
    # header:: array of string with header values
    # width::  width of the table
    # expand:: whether to expand the table to width if rows are less than width
    def table_of_array(rows, header, opts = {})
      columns = rows.transpose
      widths  = max_column_widths(columns, header, opts)
      formatter = formatter_string(widths, " | ")
      print_header(header, formatter)
      print_horizontal_line("-", "-+-", widths)
      print_table(columns, formatter)
    end

    # Extracts the columns to display in the table based on the header column
    # names
    def extract_columns(rows, header)
      columns = []
      header.each do |h|
        columns << rows.map do |r|
          r.send(h)
        end  
      end
      columns
    end

    # Determines max column widths for each column based on the data and header
    # columns.
    def max_column_widths(columns, header, opts = {})
      row_column_widths = columns.map do |c| 
        c.reduce(0) { |m, v| [m, v.nil? ? 0 : v.length].max }
      end

      header_column_widths = header.map { |h| h.length }

      widths = row_column_widths.zip(header_column_widths).map do |column|
        column.reduce(0) { |m, v| [m, v].max }
      end

      scale_widths(widths, opts)
    end

    # Creates a formatter string based on the widths and the column separator
    def formatter_string(widhts, separator)
      widhts.map do |width|
        "%-#{width}.#{width}s"
      end.join(separator)
    end

    # Prints the table's header
    def print_header(header, formatter)
      puts sprintf(formatter, *header)
    end

    # Prints a horizontal line below the header
    def print_horizontal_line(line, separator, widths)
      puts widths.map { |width| line * width }.join(separator)
    end

    # Prints columns in a table format
    def print_table(columns, formatter)
      columns.transpose.each { |row| puts sprintf(formatter, *row) }
    end

    # Cuts the string down to the specified size
    def cut(string, size)
      string[0..size-1]
    end

    # Scales the widths in regard to opts[:width] and opts[:expand]. If
    # :expand is true and :width is set the rows are expanded to the
    # :width if the rows are shorter than width. If the rows are
    # larger than :width the rows are scaled to not exceed the 
    # :width. If :width is not set the rows are not scaled.
    def scale_widths(widths, opts = {})
      return widths unless opts[:width]

      row_width = widths.inject(:+)

      return widths if !opts[:expand] && row_width <= opts[:width]

      scale = 1.0*opts[:width]/row_width
      widths.map { |width| (scale * width).round }
    end
  end
end
