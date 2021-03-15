#Modulos necesarios para trabajar con json
#Rubygems permite que requiera gemas de ruby para poder realizar comandos
require 'rubygems'
#Gema de ruby que analiza gramaticamente los archivos json para convertirlos en hash de forma que ruby los pueda manejar
require 'json'

#Meta individual para el calculo de bono
meta_individual = {
   A:5,
   B:10,
   C:15,
   Cuauh:20
}

#Realiza el cambio de los valores de las metas individuales
#Recibe las metas individuales
def cambio(meta)
   #Para cada nivel pide la nueva meta
   meta.each{|nivel, meta_indi| 
   puts "El nivel #{nivel} tiene la meta de:"
   reemplazar = gets.chomp
   #Reemplaza la nueva meta al correspondiente nivel
   meta[nivel]= reemplazar
}
return meta
end

def convierte_json()
   #Lee el archivo json donde se guardo la informacion de los jugadores
   json_file=File.read("jugadores.json")
   #Convierte el archivo json a hash
   return JSON.parse(json_file)
end

#Funcion que calcula la cantidad de goles realizados por el equipo
def goles_equipo(hash_equipo)
   total_goles = 0
   hash_equipo["jugadores"].each{|key, value|
      total_goles += key["goles"]
   }
   return total_goles
end


# Pregunta al usuario si desea usar las metas individuales del equipo Resuelve FC o cambiarlas

loop do
   puts "Desea usar las metas individuales del equipo Resuelve FC S/N"
   respuesta = gets.chomp
   if respuesta.upcase == "S" 
      puts "\n"
      break 
   elsif respuesta.upcase == "N"  
      cambio(meta_individual)
      break
   else
      puts "Respuesta no valida \n"      
   end

end

hash_file= convierte_json()

puts goles_equipo(hash_file)