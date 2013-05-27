require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  def setup
    @admin = users(:admin)
    @luria = users(:luria)
  end

  test 'should require fields' do
    user = User.create(scholarship: nil, active: nil)
    assert user.errors[:name].any?
    assert user.errors[:scholarship].any?
    assert user.errors[:shift_work].any?
    assert user.errors[:active].any?
    assert user.errors[:email].any?
    assert user.errors[:login].any?
    assert user.errors[:role].any?
  end

  test 'should require matriculation if scholarship' do
    user = User.create(scholarship: true, matriculation: '')
    assert user.errors[:matriculation].any?
  end

  test 'should deny fields' do
    user = User.create(name: 'Luria & Jakobson', email: 'luria & jakobson@psi.com', login: 'luria & jakobson')
    assert user.errors[:name].any?
    assert user.errors[:email].any?
    assert user.errors[:login].any?
  end

  test 'should deny length of fields' do
    # On new record
    user = User.create(name: 'l', login: 'l', password: '')
    assert user.errors[:name].any?
    assert user.errors[:login].any?
    assert !user.password.blank?

    # Password
    user = User.create(password: '1234')
    assert user.errors[:password].any?
    user = User.create(password: '12345678901')
    assert user.errors[:password].any?
    # On update record
    @admin.update(scholarship: false, city: 'Taquara, RS, Brasil')
    assert_not_nil @admin.errors[:password].any?
  end

  test 'should deny password confirmation different' do
    user = User.create(password: '123456', password_confirmation: '654321')
    assert user.errors[:password_confirmation].any?

    @admin.update(password: '', password_confirmation: 'admin')
    assert @admin.errors[:password_confirmation].any?, @admin.errors.messages
  end

  test 'should deny invalid value to fields' do
    user = User.create(shift_work: 'night', role: 'teacher')
    assert user.errors[:shift_work].any?
    assert user.errors[:role].any?
  end

  test 'should deny duplicate' do
    user = User.create(role: 'colleger', login: 'brucke', email: 'brucke@psi.com', name: 'Ernst Brücke',
                       scholarship: true, matriculation: '2080891', shift_work: 'morning')
    assert user.errors[:matriculation].any?
    assert user.errors[:email].any?
    assert user.errors[:login].any?

    @luria.update(reset_password_token: '123dd305c3d381265c982dccccc005992192d638',
                  reset_password_sent_at: Time.now.utc)
    assert user.errors[:reset_password_token].any?
  end
end