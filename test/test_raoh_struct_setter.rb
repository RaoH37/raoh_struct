# frozen_string_literal: true

require_relative 'test_helper'
require 'mocha/minitest'

class TestRaohStructSetter < Minitest::Test
  def test_blank
    maxime = Sample::TestUser.new
    maxime.first_name = 'maxime'
    maxime.last_name = 'Désécot'
    maxime.age = 38

    assert maxime.first_name == 'maxime'
    assert maxime.last_name == 'Désécot'
    assert maxime.age == 38
  end

  def test_blank_loop
    users = Array.new(10, Sample::TestUser.new)

    users.each do |user|
      user.first_name = 'maxime'
      user.last_name = 'Désécot'
      user.age = 38
    end

    users.each do |user|
      assert user.first_name == 'maxime'
      assert user.last_name == 'Désécot'
      assert user.age == 38
    end
  end

  def test_setter
    maxime = Sample.init_maxime_user('maxime', 'Désécot', 38)

    assert maxime.first_name == 'maxime'
    assert maxime.last_name == 'Désécot'
    assert maxime.age == 38
  end

  def test_setter_with_transform
    maxime = Sample.init_maxime_user_with_transform('maxime', 'Désécot', nil)

    assert maxime.first_name == 'Maxime'
    assert maxime.last_name == 'DÉSÉCOT'
    assert maxime.age == 38
  end

  def test_changed
    maxime = Sample.init_maxime_user('maxime', 'Désécot', 38)
    maxime.first_name = 'kenshiro'

    assert maxime.first_name_changed?
    refute maxime.last_name_changed?
  end

  def test_was
    maxime = Sample.init_maxime_user('maxime', 'Désécot', 38)
    maxime.first_name = 'kenshiro'

    assert maxime.first_name == 'kenshiro'
    assert maxime.first_name_was == 'maxime'
  end
end
