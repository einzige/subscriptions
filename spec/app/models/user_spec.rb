describe User do
  subject { User.new }

  it { subject.new_record?.must_equal true }
end
