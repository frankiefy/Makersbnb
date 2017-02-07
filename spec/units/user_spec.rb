# require 'pry-byebug'

describe User do
  # subject(:user){described_class.new(email: 'test@examp.le', password: 'secret')}

  context 'defaults' do
    it 'has a password_confirmation argument to validate password' do
      user_count = described_class.count
      obj_wrong = described_class.new(
        email: 'test@examp.le',
        password: 'secret',
        password_confirmation: 'maybenotsecret')
      obj_wrong.save
      expect(described_class.count).to eq(user_count)

      obj = described_class.new(
        email: 'test@examp.le',
        password: 'secret',
        password_confirmation: 'secret')
      obj.save
      expect(described_class.count).to eq(user_count + 1)
    end

    it 'only accepts valid email addresses' do
      obj_wrong = described_class.new(
        email: '',
        password: 'secret',
        password_confirmation: 'secret')
      obj_wrong.save
      expect(obj_wrong.errors[:email]).to eq(["We need your email address."])

      obj_wrong = described_class.new(
        email: 'asda/sa/d-sad.-/asd-/asd.sa.#a][p]',
        password: 'secret',
        password_confirmation: 'secret')
      obj_wrong.save
      expect(obj_wrong.errors[:email]).to eq(["Doesn't look like an email address to me ..."])

      obj = described_class.new(
          email: 'test@example.com',
          password: 'secret',
          password_confirmation: 'secret')
      expect(obj.save).to eq(true)
    end

    it 'cannot register 2 times the same email address' do
      obj1 = described_class.new(
          email: 'test@examp.le',
          password: 'secret',
          password_confirmation: 'secret')
      expect(obj1.save).to eq(true)
      obj2 = described_class.new(
          email: 'test@examp.le',
          password: 'secret',
          password_confirmation: 'secret')
        obj2.save
        expect(obj2.errors[:email]).to eq(["We already have that email."])
    end
  end
end
