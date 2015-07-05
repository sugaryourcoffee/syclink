require 'syclink/formatter'

module SycLink

  describe Formatter do

    include Formatter

    Row = Struct.new(:col1, :col2, :col3, :col4)

    before do
      @header = [:col1, :col2, :col3, :col4]
      row_values = [ [ "col11",    nil,       "col1333", "col14444" ],
                     [ nil,         nil,      "col2333",  nil       ],
                     [ "col31111", "col3222", "col333",   nil       ],
                     [ "col41",    "col422",  nil,       "col44444" ] ]
      @rows = row_values.map { |row| Row.new(*row) }
      @cols = [ [ "col11",    nil,       "col31111", "col41"    ],
                [ nil,        nil,       "col3222",  "col422"   ],
                [ "col1333",  "col2333", "col333",   nil        ],
                [ "col14444", nil,       nil,        "col44444" ] ]
      @formatter = "%-8s | %-7s | %-7s | %-8s"
      @widths = [ 8, 7, 7, 8 ]
    end

    it "should transform the rows to columns" do
      expect(extract_columns(@rows, @header)).to eq @cols
    end
    it "should determine the max column widhts" do
      expect(max_column_widths(@cols, @header)).to eq @widths
    end

    it "should create a formatter string" do
      expect(formatter_string(@widths, " | ")).to eq @formatter
    end
  end
end
