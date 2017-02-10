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
    start_date: Date.strptime("21/07/2017", "%d/%m/%Y"),
    end_date: Date.strptime("28/07/2017", "%d/%m/%Y"))}.not_to raise_error
  end
end
