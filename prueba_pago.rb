#Modulos necesarios para trabajar con json
#Rubygems permite que requiera gemas de ruby para poder realizar comandos
require 'rubygems'
#Gema de ruby que analiza gramaticamente los archivos json para convertirlos en hash de forma que ruby los pueda manejar
require 'json'

#Meta individual para el calculo de bono
meta_individual = {
   "A" =>5,
   "B"=>10,
   "C" => 15,
   "Cuauh" => 20
}

#Realiza el cambio de los valores de las metas individuales
def cambio
   p "entro" 
end

#Crea una funcion que pregunta si desea usar las metas individuales del equipo Resulve FC o cambiarlas
def cambiar_datos 
   loop do
      puts "Desea usar las metas individuales del equipo Resuelve FC S/N"
      respuesta = gets.chomp.downcase
      if respuesta == "s" then break else cambio() end

   end

end

cambiar_datos()
p "Los bonos de los jugadores son los siguientes"

#Lee el archivo json donde se guardo la informacion de los jugadores
json_file=File.read("jugadores.json")
#Convierte el archivo json a hash
hash_file=JSON.parse(json_file)

#p hash_file