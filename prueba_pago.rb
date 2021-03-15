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
   goles_de_equipo = goles_equipo(hash)
   goles_equipo_esperados = goles_esperados(hash,meta)
   goles_esperados_jugador = 0;
   hash["jugadores"].each {|key,value|
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
      #Calcula el bono del equipo
      porcentaje_bono_equipo = (goles_de_equipo/goles_equipo_esperados)
      #Si el porcentaje de bono supera el 100% total del bono lo convierte al 100%
      porcentaje_bono_equipo= 1 if porcentaje_bono_equipo>1
      #Calcula el bono individual
      porcentaje_bono_individual = (key["goles"]/goles_esperados_jugador)
       #Si el porcentaje de bono supera el 100% total del bono lo convierte al 100%
      porcentaje_bono_individual= 1 if porcentaje_bono_individual>1
      #Calcula el bono total ambos valen el 50%
      porcentaje_bono_total = (porcentaje_bono_equipo+porcentaje_bono_individual)/2
      key["sueldo_completo"]= key["sueldo"]+ (key["bono"]*porcentaje_bono_total)
   }

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

bono_jugador(hash_file, meta_individual)


