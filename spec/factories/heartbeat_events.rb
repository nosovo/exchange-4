# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :heartbeat_event do
    extend Event::Factory

    y_position 42
  end
end
