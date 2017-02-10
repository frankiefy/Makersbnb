class Request
  include DataMapper::Resource

  belongs_to :space, :required => true
  belongs_to :requester, 'User', :required => true

  property :id, Serial
  property :date, Date, required: true

  def request_date=(date)
    if self.space
      if is_within_space_date_availability?(date)
        self.date = date
      else
        raise('Cannot create request: requested date outside available range')
      end
    else
      raise('Cannot create request: need a space reference to create a request')
    end
  end

  private

  def is_within_space_date_availability?(date)
    (self.space.start_date <= date) && (date <= self.space.end_date)
  end
end
