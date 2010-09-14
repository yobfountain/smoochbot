#Get the code magic to make the encrypted confirmation token
require 'digest/sha1'

class Smoochee < ActiveRecord::Base
  
  # smoochee model constants
  MAX_EMAIL = 40
  EMAIL_REGEX = /\A[A-Z0-9\._%-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}\z/i
  
  
  has_many :mailings
  has_many :articles, :through => :mailings

  after_create :generate_confirmation_code
  
  named_scope :emailable, :conditions => { :active => true, :email_verified => true }
  
  validates_uniqueness_of :email, :on => :create, :message => "must be unique"
  validates_presence_of :email, :on => :create, :message => "please input email"
  validates_length_of :email, :within => 6..MAX_EMAIL, :on => :create, :message => "improper email format"
  validates_format_of :email, :with => EMAIL_REGEX, :message => "improper email format"
  
  
  def generate_confirmation_code
    update_attribute :confirmation_code, Digest::SHA1.hexdigest(email + 1.hour.ago.to_s).to_s.slice(0..6)
    # TODO add uniqueness check?
  end
  
  def last_smooched
    if self.attributes['last_smooched']
      self.attributes['last_smooched'] 
    else 
      1.year.ago
    end
  end
  
  def needs_smooching?
    (is_weekly? and last_smooched < 7.days.ago) ||
    (is_monthly? and last_smooched < 1.month.ago)
  end   
  
  def is_weekly?
    frequency == 0
  end
  
  def is_monthly?
    frequency == 1    
  end
  
  def first_time?
    last_smooched.blank?
  end
  
  def deactivate
    self.active = false
    self.save
  end
  
  def self.deactivate_by_confirmation_code!(confirmation_code)
    smoochee = Smoochee.find_by_confirmation_code(confirmation_code)
    p smoochee
    smoochee.deactivate if smoochee
    p smoochee
  end
  
end