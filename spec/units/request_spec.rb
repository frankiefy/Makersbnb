describe Request do
  let(:rentee){User.create(
    email: 'test@example.com',
    password: 'secret',
    password_confirmation: 'secret'
  )}
  let(:renter){User.create(
    email: 'test2@example.com',
    password: 'secret',
    password_confirmation: 'secret'
  )}
  let(:space){Space.create(
    name: "Flat 1",
    user: renter,
    price: 30,
    start_date: described_class.string_to_date_format('21/07/2017'),
    end_date: described_class.string_to_date_format('28/07/2017')
  )}
  let(:booking_date){Date.strptime("21/02/2017", "%d/%m/%Y")}

  it 'doesn\'t raise an error when a new request is created' do
    expect{described_class.create(
    requester: rentee,
    space: space,
    date: Date.strptime("21/07/2017", "%d/%m/%Y"))}.not_to raise_error
  end

  it 'raises an error when a new request is created with a date outside of the available range' do
    expect{described_class.create(
    requester: rentee,
    space: space,
    date: Date.strptime("29/07/2017", "%d/%m/%Y"))}.to raise_error
  end

  it 'stores date, requester and space' do
    new_request = described_class.create(
    requester: rentee,
    space: space,
    date: Date.strptime("21/07/2017", "%d/%m/%Y"))
    expect(new_request.requester.email).to eq(rentee.email)
    expect(new_request.date).to eq(Date.strptime("21/07/2017", "%d/%m/%Y"))
    expect(new_request.space.name).to eq(space.name)
  end

  xit 'raises an error when a new request is created and it is already booked for that date' do

  end

end
