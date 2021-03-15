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


#Crea una funcion que pregunta si desea usar las metas individuales del equipo Resuelve FC o cambiarlas


loop do
   puts "Desea usar las metas individuales del equipo Resuelve FC S/N"
   respuesta = gets.chomp
   if respuesta.upcase == "S" 
      break 
   elsif respuesta.upcase == "N"  
      cambio(meta_individual)
      break
   else
      puts "Respuesta no valida"
      puts
      
   end

end



p "Los bonos de los jugadores son los siguientes"

#Lee el archivo json donde se guardo la informacion de los jugadores
json_file=File.read("jugadores.json")
#Convierte el archivo json a hash
hash_file=JSON.parse(json_file)

#p hash_file