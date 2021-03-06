class User < ActiveRecord::Base
  authenticates
  has_many :interviews, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :candidates, :through => :interviews
  has_many :schedules, :foreign_key => "scheduler_id", :class_name => "Interview"
  has_many :interviewers, :class_name => "OtherInterviewer", :dependent => :destroy

  has_many :requests

  attr_accessible :name, :username, :type, :email, :password, :password_confirmation

  validates :name, :email, :presence => true
  validates :email, :username, :uniqueness => true
  validates :password, :password_confirmation, :presence => true, :on => :create
  validates :password, :confirmation => true
  validates :password, :length => { :minimum => 6 }, :allow_blank => true

  scope :interview_panel, where(:type => INTERVIEW_PANEL_USER_TYPES)
  scope :current_user, lambda { |user_id| where("id = ?", user_id) }

  acts_as_follower

  after_create do |user|
    Notifier.delay.user_welcome_mail(user, user.password)
  end

  def admin?
    false
  end
  
  def role
    USER_ROLES.key(self.type)
  end

  def self.inherited(child)
    child.instance_eval do
      def model_name
        User.model_name
      end
    end
    super
  end

end
