module SycLink

  module Formatter

    def table(rows, header)
      columns = extract_columns(rows, header)
      widths  = max_column_widths(columns, header)
      formatter = formatter_string(widths, " | ")
      print_header(header, formatter)
      print_horizontal_line("-", "-+-", widths)
      print_table(columns, formatter)
    end

    def extract_columns(rows, header)
      columns = []
      header.each do |h|
        columns << rows.map do |r|
          r.send(h)
        end  
      end
      columns
    end

    def max_column_widths(columns, header)
      row_column_widths = columns.map do |c| 
        c.reduce(0) { |m, v| [m, v.length].max }
      end

      header_column_widths = header.map { |h| h.length }

      row_column_widths.zip(header_column_widths).map do |column|
        column.reduce(0) { |m, v| [m, v].max }
      end
    end

    def formatter_string(widhts, separator)
      widhts.map do |width|
        "%-#{width}s"
      end.join(separator)
    end

    def print_header(header, formatter)
      puts sprintf(formatter, *header)
    end

    def print_horizontal_line(line, separator, widths)
      puts widths.map { |width| line * width }.join(separator)
    end

    def print_table(columns, formatter)
      columns.transpose.each { |row| puts sprintf(formatter, *row) }
    end

  end
end
