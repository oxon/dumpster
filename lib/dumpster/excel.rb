require 'axlsx'

module Dumpster
  module Excel
    class Writer
      def initialize(model)
        @model = model
      end

      def write_to_string(options = {})
        file = Tempfile.new('dumpster_excel_export.xlsx')
        write_to_file(file.path, options)
        File.read(file.path)
      end

      def write_to_file(path, options = {})
        options = { autowidth: true, trust_input: false }.merge(options)
        autowidth = options.delete(:autowidth)
        trust_input = options.delete(:trust_input)
        raise "unexpected options: #{options}" unless options.empty?

        Axlsx::trust_input = trust_input
        package = Axlsx::Package.new
        package.use_autowidth = autowidth
        draw(package)
        package.serialize(path)
      end

      def draw(package)
        package.workbook.add_worksheet(:name => "Worksheet 1") do |sheet|
          @model.each do |row|
            sheet.add_row(row, types: @model.types)
          end
        end
      end
    end

    module AutoFilter
      def draw(*args)
        sheet = super
        sheet.add_table sheet.dimension.sqref
        sheet
      end
    end
  end
end
