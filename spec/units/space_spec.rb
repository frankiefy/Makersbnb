describe Space do
  let(:user){User.create(
    email: 'test@example.com',
    password: 'secret',
    password_confirmation: 'secret'
  )}
  it 'doesn\'t raise an error when a new space is created' do
    expect{described_class.create(
    name: "Flat 1",
    user: user,
    price: 30,
    start_date: described_class.string_to_date_format('21/07/2017'),
    end_date: described_class.string_to_date_format('28/07/2017'))}.not_to raise_error
  end
end
