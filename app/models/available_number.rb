class AvailableNumber < ActiveRecord::Base
  attr_accessible :numero, :has_valid_image, :already_assigned
  
  def self.generate_all(from_num,to_num)
    (from_num..to_num).each do |i|
       puts "Looking for acta #{i}..."
       if (Actum.exists?(numero: i.to_s))
         puts "Already in... not created..."
       else
         num=AvailableNumber.create(:numero=>i.to_s)
         puts "New slot created for #{i} (with id #{num.id})..."
       end
    end
  end
end
