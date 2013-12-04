# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#---- Ejemplo de lo que tiene que generar el script:

departamento = Departamento.create(:name=>"Atlantida",:num=>1)
 Municipio.create(:name=>"La Ceiba",:num=>1,:departamento_id=>departamento.id)
 Municipio.create(:name=>"Tela",:num=>2,:departamento_id=>departamento.id)

departamento = Departamento.create(:name=>"Otro",:num=>2)
 Municipio.create(:name=>"Otro 1",:num=>1,:departamento_id=>departamento.id)
 Municipio.create(:name=>"Otro 2",:num=>2,:departamento_id=>departamento.id)
 
#--- Y así para los 18 departamentos y todos los municipios... copy pastiate el output aquí para poder correr el rake db:seed en heroku y alimentar de un solo esas tablas
