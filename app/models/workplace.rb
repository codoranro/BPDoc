class Workplace < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user }

  validates :designation, presence: true,
                          uniqueness: true,
                          length: {minimum: 5, maximum: 50}

  has_many :bproce_workplaces
  has_many :bproces, through: :bproce_workplaces
  has_many :user_workplace    # пользователи рабочего миеста
  has_many :users, through: :user_workplace

  accepts_nested_attributes_for :bproce_workplaces, :allow_destroy => true
  accepts_nested_attributes_for :bproces

  attr_accessible :designation, :name, :switch, :port, :description, :typical, :location
  #has_many :bapps

  def self.search(search)
    if search
      where('designation ILIKE ? or name ILIKE ? or description ILIKE ? or id = ?',
            "%#{search}%", "%#{search}%", "%#{search}%", "#{search.to_i}")
    else
      where(nil)
    end
  end

end
