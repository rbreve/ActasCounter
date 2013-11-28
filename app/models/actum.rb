class Actum < ActiveRecord::Base
  attr_accessible :alianza, :dc, :liberal, :libre, :nacional, :numero, :pac, :pinu, :ud, :nulos, :blancos, :user_id, :ready_for_review,:is_sum_ok

  validates :numero, :uniqueness=>true
  
  validates :alianza, :dc, :liberal, :libre, :nacional, :pac, :pinu, :ud, :nulos, :blancos, :numericality => { :greater_than_or_equal_to=>0, :less_than_or_equal_to => 400 }, :presence => true
  
 
  belongs_to :user #, counter_cache: true
  has_many :verifications, class_name: "Verification",:foreign_key=>"acta_id"
  
  
  after_save :update_counters
  
  private
    def update_counters
      user = User.find self.user_id
      user.acta_count = user.acta.count
      user.save
    end
end
