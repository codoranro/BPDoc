# Read about factories at http://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :iresource do
    level 'lev'
    sequence(:label) { |n| "RES#{n}" }
    location 	'\\location'
    alocation   '\\alocation'
    volume		10
    note 		'iresource_note'
    access_read	'READ'
    access_write	'WRITE'
    access_other	'OTHER'
    risk_category	'risk 00'
    user_id 0
  end
end
