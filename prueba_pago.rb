############################################### Modulos necesarios ########################################################
#Modulos necesarios para trabajar con json
#Rubygems permite que requiera gemas de ruby para poder realizar comandos
require 'rubygems'
#Gema de ruby que analiza gramaticamente los archivos json para convertirlos en hash de forma que ruby los pueda manejar
require 'json'

############################################### Metas individuales default ########################################################
#Meta individual para el calculo de bono
meta_individual = {
   A:5,
   B:10,
   C:15,
   Cuauh:20
}

############################################### Funciones ########################################################
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

#Funcion convierte el JSON a Hash
def convierte_json()
   #Lee el archivo json donde se guardo la informacion de los jugadores
   json_file=File.read("jugadores.json")
   #Convierte el archivo json a hash
   return JSON.parse(json_file)
end

#Funcion convierte el Hash a JSON
def convierte_hash(hash)
   json_converted = hash.to_json
   return json_converted
end

#Funcion que calcula la cantidad de goles realizados por el equipo
def goles_equipo(hash_equipo)
   total_goles = 0
   hash_equipo["jugadores"].each{|key, value|
      total_goles += key["goles"]
   }
   return total_goles
end

#Funcion que calcula la cantidad de goles esperados por el nivel de cada jugador
def goles_esperados(hash_equipo, meta_equipo)
   goles = 0
   hash_equipo["jugadores"].each {|key,value|
      case key["nivel"]
      when "A"
         goles += meta_equipo[:A]
      when "B"
         goles += meta_equipo[:B]
      when "C"
         goles += meta_equipo[:C]
      when "Cuauh"
         goles += meta_equipo[:Cuauh]
      end

}
   return goles
end

#Calcula el bono de este jugador
def bono_jugador (hash, meta)
   goles_de_equipo = goles_equipo(hash).to_f

   goles_equipo_esperados = goles_esperados(hash,meta).to_f

   #Calcula el bono del equipo
   porcentaje_bono_equipo = (goles_de_equipo/goles_equipo_esperados)
   #Si el porcentaje de bono supera el 100% total del bono lo convierte al 100%
   porcentaje_bono_equipo= 1 if porcentaje_bono_equipo>1

   hash["jugadores"].each {|key,value|
      #Dependiendo del nivel del jugador se buscan los valores esperados para ese jugador
      case key["nivel"]
      when "A"
         goles_esperados_jugador = meta[:A]
      when "B"
         goles_esperados_jugador = meta[:B]
      when "C"
         goles_esperados_jugador = meta[:C]
      when "Cuauh"
         goles_esperados_jugador = meta[:Cuauh]
      end 
      #Calcula el porcentaje de bono individual que es goles generados entre los goles esperados
      porcentaje_bono_individual = ((key["goles"].to_f)/goles_esperados_jugador)
       #Si el porcentaje de bono supera el 100% total del bono lo convierte al 100%
      porcentaje_bono_individual= 1 if porcentaje_bono_individual>1
      #Calcula el bono total ambos diviendo entre 2 la suma de los dos porcentajes
      porcentaje_bono_total = (porcentaje_bono_equipo+porcentaje_bono_individual)/2
      #Calcula el sueldo completo sumando el sueldo mas el bono por el porcentaje de bono recibido y lo guarda en el hash
      key["sueldo_completo"]= key["sueldo"]+ (key["bono"]*porcentaje_bono_total)
   }

end


############################################### Ejecucion del codigo ########################################################
# Pregunta al usuario si desea usar las metas individuales del equipo Resuelve FC o cambiarlas

loop do
   puts "Desea usar las metas individuales del equipo Resuelve FC S/N?"
   #Espera la respuesta del usuario
   respuesta = gets.chomp
   #Espera la respuesta del usuario para continuar
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

#Corre la funcion de convertir JSON
hash_file= convierte_json()

#Corre la funcion de calcula bono de los jugadores
bono_jugador(hash_file, meta_individual)

#Corre la converion del Hash a JSON y lo muestra
puts convierte_hash(hash_file)

#Escribe en el JSON original desactivado
#File.open("jugadores.json", 'w') { |file| file.write(hash_file) }