#!/bin/env ruby
# encoding: utf-8

csv_text = File.read(File.join(Rails.root, "lib", "monitoreo.csv"))
numbers = csv_text.chomp.chomp.split(",")

numbers.each do |numero|
  if(Actum.exists?(numero: numero, actum_type: "p"))
    puts "Already in"
  else
    num = AvailableNumber.create(numero: numero, actum_type: "p", has_valid_image: true)
    puts "New slot created for #{numero}, id: #{num.id}"
  end
end
