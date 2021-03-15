#Modulos necesarios para trabajar con json
#Rubygems permite que requiera gemas de ruby para poder realizar comandos
require 'rubygems'
#Gema de ruby que analiza gramaticamente los archivos json para convertirlos en hash de forma que ruby los pueda manejar
require 'json'

#Lee el archivo json donde se guardo la informacion de los jugadores
json_file=File.read("jugadores.json")
hash_file=JSON.parse(json_file)

p hash_file