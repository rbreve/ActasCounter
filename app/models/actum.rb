class Actum < ActiveRecord::Base
  attr_accessible :alianza_patriotica,
                  :dc,
                  :liberal,
                  :libre_pinu,
                  :nacional,
                  :pac,
                  :ud,
                  :frente_amplio,
                  :vamos,
                  :numero,:nulos,:blancos,:user_id,:ready_for_review,:is_sum_ok,:actum_type,:image_changed,:recibidas,:sobrantes,:ciudadanos,:miembros_mer

  validates :numero, :uniqueness=> {:scope => :actum_type}
  belongs_to :municipio 
  
  validates :alianza_patriotica,
            :dc,
            :liberal,
            :libre_pinu,
            :nacional,
            :pac,
            :vamos,
            :ud,
            :frente_amplio,
            :nulos, :blancos, :numericality => { :greater_than_or_equal_to=>0, :less_than_or_equal_to => 400 }, :presence => true

  belongs_to :user #, counter_cache: true
  has_many :verifications, class_name: "Verification",:foreign_key=>"acta_id"
  has_many :reportes, class_name: "Reporte",:foreign_key=>"acta_id"
  after_save :update_counters
  before_validation :set_defaults
  
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
  
  def get_municipio_id
    if self.actum_type=="a"
      begin
        Municipio.where(["from_actum<=? AND from_actum>=?",self.numero.to_i,self.numero.to_i]).first.id
      rescue
        nil
      end
    else
      nil
    end
  end
  
  def total_votes
    self.nacional.to_i+
      self.liberal.to_i+
      self.libre_pinu.to_i+
      self.ud.to_i+
      self.alianza_patriotica.to_i+
      self.vamos.to_i+
      self.frente_amplio.to_i+
      self.blancos.to_i+
      self.pac.to_i+
      self.nulos.to_i+
      self.dc.to_i
  end

  def percentage(party)
    Actum.sum(party)/total_votes*100
  end
  
  def to_param  # overridden
    numero
  end
  
  def image
    if self.actum_type=="p"
      versioned_image(4)
    else
      versioned_image(3)
    end
  end
  
  def versioned_image(v)
    if Rails.env.production?
      "http://s3-us-west-2.amazonaws.com/actashn/#{self.full_type}/#{v}/%05d104.jpg" % self.numero
    else
      "/actas/p/%05d104.jpg" % self.numero
    end
  end

  def self.count_all_votes
    Actum.where(:actum_type=>'p').map{|a| a.total_votes }.inject(:+)
  end

  def self.results
    return {
      total: Actum.count_all_votes,
      alianza_patriotica: Actum.where(:actum_type=>'p').sum("alianza_patriotica"),
      dc: Actum.where(:actum_type=>'p').sum("dc"),
      liberal: Actum.where(:actum_type=>'p').sum("liberal"),
      libre_pinu: Actum.where(:actum_type=>'p').sum("libre_pinu"),
      nacional: Actum.where(:actum_type=>'p').sum("nacional"),
      pac: Actum.where(:actum_type=>'p').where(:actum_type=>'p').sum("pac"),
      vamos: Actum.sum("vamos"),
      frente_amplio: Actum.where(:actum_type=>'p').sum("frente_amplio"),
      ud: Actum.where(:actum_type=>'p').sum("ud"),
      nulos: Actum.where(:actum_type=>'p').sum("nulos"),
      blancos: Actum.where(:actum_type=>'p').sum("blancos")
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

  
  private
  def set_defaults
    self.liberal ||= 0
    self.nacional ||= 0
    self.ud ||= 0
    self.dc ||= 0
    self.vamos ||= 0
    self.alianza_patriotica ||= 0
    self.libre_pinu ||= 0
    self.pac ||= 0
    self.frente_amplio ||= 0
    self.blancos ||= 0
    self.nulos ||= 0
  end
    def update_counters
      user = User.find self.user_id
      user.acta_count = user.acta.count
      user.save
    end
end
