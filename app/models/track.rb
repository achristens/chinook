class Track < ApplicationRecord
  SHORT = 180000
  LONG  = 360000

  # This scope does the same as self.short method - note a scope will always return an active record response, and a class method will return nil if no results are found:
  scope :short,  -> { shorter_than(SHORT) }
  # def self.short
  #   shorter_than(SHORT)
  # end

  scope :long,   -> { longer_than_or_equal_to(LONG) }
  # def self.long
  #   longer_than_or_equal_to(LONG)
  # end

  scope :medium, -> { longer_than_or_equal_to(SHORT).shorter_than(LONG) }
  # def self.medium
  #   longer_than_or_equal_to(SHORT).shorter_than(LONG)
  # end

  scope :shorter_than, ->  (milliseconds) { where('milliseconds < ?', milliseconds) }
  # def self.shorter_than(milliseconds)
  #   where('milliseconds < ?', milliseconds)
  # end

  def self.shorter_than_method(milliseconds)
    if milliseconds.present? && milliseconds > 0
      where('milliseconds < ?', milliseconds)
    else
      all
    end
  end

  scope :longer_than_or_equal_to, -> (milliseconds) { where('milliseconds >= ?', milliseconds) }
  # def self.longer_than_or_equal_to(milliseconds)
  #   where('milliseconds >= ?', milliseconds)
  # end

  scope :starts_with, -> (char) { where('name ILIKE ?', "#{ char }%") }
  # def self.starts_with(char)
  #   where('name ILIKE ?', "#{ char }%")
  # end
end
