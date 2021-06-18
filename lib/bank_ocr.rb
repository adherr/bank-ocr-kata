# frozen_string_literal: true

require_relative 'bank_ocr/version'

# BankOcr namespace for dealing with ocr files
module BankOcr
  class Error < StandardError; end

  require_relative 'bank_ocr/account_number'
  require_relative 'bank_ocr/scanned_file'

  # Read a scanned file and generate a report
  #
  # @param infile [String] filename of scanned file
  # @param outfile [String] filename where report should be created
  def self.ocr(infile, outfile)
    ScannedFile.new(infile).report(outfile)
  end
end
