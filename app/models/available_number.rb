class AvailableNumber < ActiveRecord::Base
  attr_accessible :numero, :has_valid_image, :already_assigned, :actum_type
  
  def self.generate_all(from_num,to_num,actum_type)
    (from_num..to_num).each do |i|
       puts "Looking for acta #{i} for #{actum_type}..."
       if (Actum.exists?(numero: i.to_s,actum_type: actum_type))
         puts "Already in... not created..."
       else
         num=AvailableNumber.create(:numero=>i.to_s,:actum_type=>actum_type,:has_valid_image=>true)
         puts "New slot created for #{i} for #{actum_type} ... (with id #{num.id})..."
       end
    end
  end
end
