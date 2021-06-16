# frozen_string_literal: true

module BankOcr
  # Class for reading a scanned file
  class ScannedFile
    attr_reader :account_numbers

    # @param filename - string path relative to project root
    def initialize(filename)
      @account_numbers = []
      File.readlines(filename).each_slice(4) do |slice|
        @account_numbers << AccountNumber.new(slice).to_s
      end
    end
  end
end
