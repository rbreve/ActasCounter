class Verification < ActiveRecord::Base
 
  attr_accessible :liberal,
                  :nacional,
                  :libre_pinu,
                  :pac,
                  :ud,
                  :dc,
                  :alianza_patriotica,
                  :vamos,
                  :frente_amplio,
                  :blancos,
                  :nulos,
                  :is_valid,:is_sum_ok,:acta_id,:image_changed,:user_id,
                  :recibidas,:sobrantes,:ciudadanos,:miembros_mer,:firmas
  belongs_to :user #, counter_cache: true
  belongs_to :actum, class_name: "Actum",:foreign_key=>"acta_id"
   
  #validates :user_id, :uniqueness => {:scope => :acta_id}
  
  validates :alianza_patriotica,
            :dc,
            :liberal,
            :libre_pinu,
            :nacional,
            :pac,
            :vamos,
            :ud,
            :frente_amplio,
            :nulos,
            :blancos,
            :numericality => { :greater_than_or_equal_to=>0, :less_than_or_equal_to => 400 }, :presence => true
    
  after_save :update_counters
  
  private
    def update_counters
      user = User.find self.user_id
      user.verifications_count = user.verifications.count
      user.save
    end
    
end
