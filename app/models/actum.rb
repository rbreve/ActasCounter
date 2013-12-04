class Actum < ActiveRecord::Base
  attr_accessible :alianza, :dc, :liberal, :libre, :nacional, :numero, :pac, :pinu, :ud, :nulos, :blancos, :user_id, :ready_for_review,:is_sum_ok, :actum_type,:image_changed

  validates :numero, :uniqueness=> {:scope => :actum_type}
  belongs_to :municipio 
  
  validates :alianza, :dc, :liberal, :libre, :nacional, :pac, :pinu, :ud, :nulos, :blancos, :numericality => { :greater_than_or_equal_to=>0, :less_than_or_equal_to => 400 }, :presence => true

  belongs_to :user #, counter_cache: true
  has_many :verifications, class_name: "Verification",:foreign_key=>"acta_id"
  has_many :reportes, class_name: "Reporte",:foreign_key=>"acta_id"
  after_save :update_counters
  
  ACTUM_TYPE_FULL = {
    "p" => "presidente",
    "a" => "alcalde",
    "d" => "diputados"
  }

  ACTUM_TYPE_SHORT = {
    "presidente" => "p",
    "alcalde" => "a",
    "diputados" => "d"
  }
  
  def total_votes
 self.nacional.to_i+self.liberal.to_i+self.libre.to_i+self.ud.to_i+self.alianza.to_i+self.pinu.to_i+self.blancos.to_i+self.pac.to_i+self.nulos.to_i+self.dc.to_i
  end

  def percentage(party)
    Actum.sum(party)/total_votes*100
  end
  
  def to_param  # overridden
    numero
  end
  
  def image
    versioned_image(4)
  end
  
  def versioned_image(v)
    "http://s3-us-west-2.amazonaws.com/actashn/presidente/#{v}/%05d.jpg" % self.numero
  end

  def self.count_all_votes
    Actum.all.map{|a| a.total_votes }.inject(:+)
  end

  def self.results
    return {
      total: Actum.count_all_votes,
      alianza: Actum.sum("alianza"),
      dc: Actum.sum("dc"),
      liberal: Actum.sum("liberal"),
      libre: Actum.sum("libre"),
      nacional: Actum.sum("nacional"),
      pac: Actum.sum("pac"),
      pinu: Actum.sum("pinu"),
      ud: Actum.sum("ud"),
      nulos: Actum.sum("nulos"),
      blancos: Actum.sum("blancos")
    }
  end

  def self.random(current_user)
    Actum.where(["user_id<>? AND ready_for_review=? AND id NOT IN (?) and verified_count<?",current_user.id,true,current_user.verifications.map{ |x| x.acta_id },VERIFICATIONS]).order("RANDOM()").first
  end

  def self.short_type(type)
    ACTUM_TYPE_SHORT[type]
  end
  
  def self.full_type(type)
    ACTUM_TYPE_FULL[type]
  end

  def full_type
    ACTUM_TYPE_FULL[self.actum_type]
  end

  def folder_number
    case self.actum_type
    when "p"
      return 3
    when "a"
      return 1
    when "d"
      return 1
    end
  end

  def image
    "http://s3-us-west-2.amazonaws.com/actashn/#{self.full_type}/#{self.folder_number}/%05d.jpg" % self.numero
  end
  
  private
    def update_counters
      user = User.find self.user_id
      user.acta_count = user.acta.count
      user.save
    end
end
