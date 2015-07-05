# Module that creates a link list and generates an html representation
module SycLink

  # Methods to print data in a formatted way
  module Formatter

    # Based on the rows provided and the header values a table is printed. If
    # the options :expand and or :max_row_width are specified the rows are 
    # scaled accordingly. If :expand is false the rows will be cut so they fit 
    # the :max_row_width. Otherwise if the rows are less than :max_row_width 
    # the rows are expanded to :max_row_width.
    def table(rows, header, opts = {})
      columns = extract_columns(rows, header)
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
        "%-#{width}s"
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

    # Scales the widths in regard to opts[:max_row_width] and opts[:expand]. If
    # :expand is true and :max_row_width is set the rows are expanded to the
    # :max_row_width if the rows are shorter than max_row_width. If the rows are
    # larger than :max_row_width the rows are scaled to not exceed the 
    # :max_row_width. If :max_row_width is not set the rows are not scaled.
    def scale_widths(widths, opts = {})
      return widths unless opts[:max_row_width]

      row_width = widths.inject(:+)

      return widths if !opts[:expand] && row_width <= opts[:max_row_width]

      scale = 1.0*opts[:max_row_width]/row_width
      widths.map { |width| (scale * width).round }
    end
  end
end
