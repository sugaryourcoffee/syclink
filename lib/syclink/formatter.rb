# Module that creates a link list and generates an html representation
module SycLink

  # Methods to print data in a formatted way
  module Formatter

    # Based on the rows provided and the header values a table is printed
    def table(rows, header)
      columns = extract_columns(rows, header)
      widths  = max_column_widths(columns, header)
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
    # columns
    def max_column_widths(columns, header)
      row_column_widths = columns.map do |c| 
        c.reduce(0) { |m, v| [m, v.length].max }
      end

      header_column_widths = header.map { |h| h.length }

      row_column_widths.zip(header_column_widths).map do |column|
        column.reduce(0) { |m, v| [m, v].max }
      end
    end

    # Creates a formatter string based on the widths and the column separator
    def formatter_string(widhts, separator)
      widhts.map do |width|
        "%-#{width}s"
      end.join(separator)
    end

    # Prints the table's header
    def print_header(header, formatter)
      puts cut(sprintf(formatter, *header), 80)
    end

    # Prints a horizontal line below the header
    def print_horizontal_line(line, separator, widths)
      puts cut(widths.map { |width| line * width }.join(separator), 80)
    end

    # Prints columns in a table format
    def print_table(columns, formatter)
      columns.transpose.each { |row| puts cut(sprintf(formatter, *row), 80) }
    end

    # Cuts the string down to the specified size
    def cut(string, size)
      string[0..size-1]
    end
  end
end
