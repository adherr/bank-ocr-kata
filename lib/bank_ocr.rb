# frozen_string_literal: true

require_relative "bank_ocr/version"

module BankOcr
  class Error < StandardError; end

  require_relative 'bank_ocr/account_number'
  require_relative 'bank_ocr/scanned_file'
end
