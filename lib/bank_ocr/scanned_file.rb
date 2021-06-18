# frozen_string_literal: true

module BankOcr
  # Class for reading a scanned file
  class ScannedFile
    # @param filename - string path relative to project root
    def initialize(filename)
      @account_numbers = []
      File.readlines(filename).each_slice(4) do |slice|
        @account_numbers << AccountNumber.new(slice)
      end
    end

    # Generate a report file with the given name
    #
    # @param out_filename [String] where to put the report
    def report(out_filename)
      File.open(out_filename, 'w') do |out|
        account_numbers.each do |acct|
          out.write("#{acct.to_file}\n")
        end
      end
    end

    private

    attr_reader :account_numbers
  end
end
