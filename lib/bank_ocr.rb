# frozen_string_literal: true

require_relative "bank_ocr/version"

module BankOcr
  class Error < StandardError; end

  require_relative 'bank_ocr/account_number'
end
