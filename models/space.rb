require 'date'

class Space
  include DataMapper::Resource

  belongs_to :user

  property :id, Serial
  property :name, String, required: true
  property :description,  Text, length: 500
  property :price, Integer, required: true
  property :start_date, Date, required: true
  property :end_date, Date, required: true

  # def self.string_to_date_format(date_string, date_format = '%d/%m/%Y')
  #   Date.strptime(date_string, date_format)
  # end

end
