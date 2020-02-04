#!/bin/sh

##############################################################################
# ARCHIVO             : automataActualizaSucursales.sh
# AUTOR/ES            : Norman ruiz
# VERSION             : 0.01 beta.
# FECHA DE CREACION   : 20/08/2019.
# ULTIMA ACTUALIZACION: 26/08/2019.
# LICENCIA            : GPL (General Public License) - Version 3.
#
#  **************************************************************************
#  * El software libre no es una cuestion economica sino una cuestion etica *
#  **************************************************************************
#
# Este programa es software libre;  puede redistribuirlo  o  modificarlo bajo
# los terminos de la Licencia Publica General de GNU  tal como se publica por
# la  Free Software Foundation;  ya sea la version 3 de la Licencia,  o (a su
# eleccion) cualquier version posterior.
#
# Este programa se distribuye con la esperanza  de que le sea util,  pero SIN
# NINGUNA  GARANTIA;  sin  incluso  la garantia implicita de MERCANTILIDAD  o
# IDONEIDAD PARA UN PROPOSITO PARTICULAR.
#
# Vea la Licencia Publica General GNU para mas detalles.
#
# Deberia haber recibido una copia de la Licencia Publica General de GNU junto
# con este proyecto, si no es asi, escriba a la Free Software Foundation, Inc,
# 59 Temple Place - Suite 330, Boston, MA 02111-1307, EE.UU.

#=============================================================================
# SISTEMA OPERATIVO   : Debian 4.9.144-3.1 (2019-02-19) x86_64 GNU/Linux
# IDE                 : Visual Studio Code Version: 1.37.1
# COMPILADOR          : gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1)  
# LICENCIA            : GPL (General Public License) - Version 3.
#=============================================================================
# DESCRIPCION:
#              Este script automatiza la instalacion de el servidor de 
#              sucursal.
#
##############################################################################

#*****************************************************************************
#                             INCLUSIONES ESTANDAR
#=============================================================================

#*****************************************************************************
#                             INCLUSIONES PERSONALES
#=============================================================================

#*****************************************************************************
# DEFINICION DE LAS FUNCIONES
#=============================================================================

#=============================================================================
# FUNCION : CreaBackups().
# ACCION : Esta funcion deja limpia y organizada la estructura de directorios.
# PARAMETROS: void, no devuelve nada.
# DEVUELVE : void, no devuelve nada.
#-----------------------------------------------------------------------------
CreaBackups(){
    FECHA=$(date +"%d%m%Y")
	echo ""
	echo  "\tValidando directorio backup..."
	if [ -d backup ];
	then
		echo ""
		echo  "\tEl directorio existe..."
		echo ""
		echo  "\tCreando directorio backup-$FECHA"
		if [ -d ./backup/backup-$FECHA ];
		then
			echo ""
			echo  "\tEl directorio ya existe..."
            echo ""
			echo  "\tCopiando carpeta config ..."
            if [ -f ./backup/backup-$FECHA/config/posGateway.properties ];
		    then
                echo ""
		        echo  "\tEl archivo posGateway.properties ya existe..."
            else
			    cp -iav config ./backup/backup-$FECHA >> log-$FECHA.txt
			    if [ $? -eq 0 ]; then
			    	echo ""
			    	echo  "\tTerminado Ok..."
			    else
			    	echo ""
			    	echo  "\tTerminado con observaciones: $?"
			    fi
            fi
            echo ""
			echo  "\tCopiando docker-compose.yml..."
            if [ -f ./backup/backup-$FECHA/docker-compose.yml ];
		    then
                echo ""
		        echo  "\tEl archivo docker-compose.yml ya existe..."
            else
			    cp -iav docker-compose.yml ./backup/backup-$FECHA >> log-$FECHA.txt
			    if [ $? -eq 0 ]; then
			    	echo ""
			    	echo  "\tTerminado Ok..."
                    echo ""
			    	echo  "\tBackups creados correctamente..."
			    else
			    	echo ""
			    	echo  "\tTerminado con observaciones: $?"
			    fi
            fi
		else
			mkdir -v ./backup/backup-$FECHA  >> log-$FECHA.txt
			if [ $? -eq 0 ]; then
				echo ""
				echo  "\tTerminado Ok..."
                echo ""
                echo  "\tCopiando carpeta config ..."
			    cp -iav config ./backup/backup-$FECHA >> log-$FECHA.txt
			    if [ $? -eq 0 ]; then
			    	echo ""
			    	echo  "\tTerminado Ok..."
			    else
			    	echo ""
			    	echo  "\tTerminado con observaciones: $?"
			    fi
                echo ""
			    echo  "\tCopiando docker-compose.yml..."
			    cp -iav docker-compose.yml ./backup/backup-$FECHA >> log-$FECHA.txt
			    if [ $? -eq 0 ]; then
			    	echo ""
			    	echo  "\tTerminado Ok..."
                    echo ""
			    	echo  "\tBackups creados correctamente..."
			    else
			    	echo ""
			    	echo  "\tTerminado con observaciones: $?"
			    fi
			else
				echo ""
				echo  "\tTerminado con observaciones: $?"
			fi
			echo ""
		fi
	else
		mkdir -v backup >> log-$FECHA.txt
		if [ $? -eq 0 ]; then
			echo ""
			echo  "\tTerminado Ok..."
            echo ""
		    echo  "\tCreando directorio backup-$FECHA"
		    mkdir -v ./backup/backup-$FECHA >> log-$FECHA.txt
		    if [ $? -eq 0 ]; then
			    echo ""
			    echo  "\tTerminado Ok..."
                echo ""
			    echo  "\tCopiando carpeta config ..."
			    cp -iav config ./backup/backup-$FECHA >> log-$FECHA.txt
			    if [ $? -eq 0 ]; then
			    	echo ""
			    	echo  "\tTerminado Ok..."
			    else
			    	echo ""
			    	echo  "\tTerminado con observaciones: $?"
			    fi
                echo ""
			    echo  "\tCopiando docker-compose.yml..."
			    cp -iav docker-compose.yml ./backup/backup-$FECHA >> log-$FECHA.txt
			    if [ $? -eq 0 ]; then
			    	echo ""
			    	echo  "\tTerminado Ok."
                    echo ""
                    echo  "\tBackups creados correctamente..."
			    else
			    	echo ""
			    	echo  "\tTerminado con observaciones: $?"
			    fi
		    else
			    echo ""
			    echo  "\tTerminado con observaciones: $?"
                echo ""
			    echo  "\tNo se pudo realizar los backups."
		    fi
		else
			echo ""
			echo  "\tTerminado con observaciones: $?"
            echo ""
			echo  "\tNo se pudo realizar los backups."
		fi
 	fi
}

#=============================================================================
# FUNCION : DownSucursal().
# ACCION : Esta funcion baja el compose de sucursal.
# PARAMETROS: void, no devuelve nada.
# DEVUELVE : void, no devuelve nada.
#-----------------------------------------------------------------------------
DownSucursal(){
	echo ""
	echo "\tBajando sucursal..."
	echo ""
	FECHA=$(date +"%d%m%Y")
	docker-compose down >> log-$FECHA.txt
  	if [ $? -eq 0 ]; then
    	echo ""
    	echo "\tTerminado Ok."
    	echo ""
  	else
    	echo ""
    	echo "\tTerminado con observaciones: $?"
    	echo ""
  	fi
}

#=============================================================================
# FUNCION : ActualizaCompose().
# ACCION : Esta funcion modifica el docker-compose.yml con la nueva version.
# PARAMETROS: void, no devuelve nada.
# DEVUELVE : void, no devuelve nada.
#-----------------------------------------------------------------------------
ActualizaCompose(){
	version=$1
	FECHA=$(date +"%d%m%Y")
	busqueda="facturacion_electronica/pos-gateway:"
	echo ""
	echo  "\tActualizando docker-compose..."
	mv docker-compose.yml docker-compose.yml.aux >> log-$FECHA.txt
	if [ -f docker-compose.yml.aux ];
	then
		touch docker-compose.yml >> log-$FECHA.txt
		while IFS= read -r line
		do
			aux=`echo $line | grep $busqueda | wc -l`
			if [ $aux -eq 1 ];
			then
				line="        image:  10.0.11.50:8085/docker-releases/facturacion_electronica/pos-gateway:$version"
			fi
			echo "$line" >> docker-compose.yml
		done < docker-compose.yml.aux
		rm docker-compose.yml.aux
	else
		echo ""
		echo "\tFallo la creacion de docker-compose.yml.aux..."
		return
	fi
}

#=============================================================================
# FUNCION : ActualizaProperties().
# ACCION : Esta funcion actualiza las posgateway.properties con los nuevos parametros.
# PARAMETROS: void, no devuelve nada.
# DEVUELVE : void, no devuelve nada.
#-----------------------------------------------------------------------------
ActualizaProperties(){
	echo ""
	echo  "\tActualizando properties..."
	FECHA=$(date +"%d%m%Y")
	busqueda="posGateway.ws.timeOut="
	mv ./config/posGateway.properties ./config/posGateway.properties.aux >> log-$FECHA.txt
	if [ -f ./config/posGateway.properties.aux ];
	then
		touch ./config/posGateway.properties >> log-$FECHA.txt
		while IFS= read -r line
		do
			aux=`echo $line | grep $busqueda | wc -l`
			if [ $aux -eq 1 ];
			then
				line="posGateway.ws.timeOut=9800"
			fi
			echo "$line" >> ./config/posGateway.properties
		done < ./config/posGateway.properties.aux
		rm ./config/posGateway.properties.aux
	else
		echo ""
		echo "\tFallo la creacion de posGateway.properties.aux..."
		return
	fi
}

#=============================================================================
# FUNCION : CargaNuevaImagen().
# ACCION : Esta funcion Carga las imagenes especidicadas .
# PARAMETROS: void, no devuelve nada.
# DEVUELVE : void, no devuelve nada.
#-----------------------------------------------------------------------------
CargaNuevaImagen(){
	echo ""
	echo "\tCargando la nueva imagen de posgateway..."
	echo ""
	version=$1
	docker load -i Sucursal-$version.tar
  	if [ $? -eq 0 ]; then
    	echo ""
    	echo "\tTerminado Ok."
    	echo ""
  	else
    	echo ""
    	echo "\tTerminado con observaciones: $?"
    	echo ""
  	fi
}

#=============================================================================
# FUNCION : LevantaSucursal().
# ACCION : Esta funcion inicia el servidor de sucursal.
# PARAMETROS: void, no devuelve nada.
# DEVUELVE : void, no devuelve nada.
#-----------------------------------------------------------------------------
LevantaSucursal(){
	echo ""
	echo "\tIniciando sucursal..."
	echo ""
	docker-compose up -d
  	if [ $? -eq 0 ]; then
    	echo ""
    	echo "\tTerminado Ok."
    	echo ""
  	else
    	echo ""
    	echo "\tTerminado con observaciones: $?"
    	echo ""
  	fi
}

#=============================================================================
# FUNCION : Main().
# ACCION : Esta es la funcion principal que realiza todas las tareas que 
#          requiere la actualizacion.
# PARAMETROS: void, no devuelve nada.
# DEVUELVE : void, no devuelve nada.
#-----------------------------------------------------------------------------
Main(){
	    echo ""
	    echo "# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #"
	    echo "\tActualizacion de sucursal en progreso..."
	    echo "# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #"
        
        # Almaceno la version pasada por parametros en una variable
        version=$1
		echo ""
		echo  "\tActualizando a la version $version..."

	    # Llamo a la funcion
	    CreaBackups

	    # Llamo a la funcion DownSucursal
	    DownSucursal

        # Llamo a la funcion ActualizaCompose
        ActualizaCompose $version

        # Llamo a la funcion ActualizaProperties
        ActualizaProperties

	    # Llamo a la funcion
	    CargaNuevaImagen $version

	    # Llamo a la funcion
	    LevantaSucursal
        echo ""
	    echo "# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #"
	    echo  "\tProceso finalizado."
	    echo "# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #"
	    echo ""
}

# Llamo a la funcion Main que depliega el script
clear
if [ $# -eq 1 ]; 
then
	Main $1
else
    echo ""
    echo "Parametros incorrectos, proceso cancelado."
    echo ""
    echo "Uso: ./actualizaSucursales-v0.1.sh <version>"
    echo "ejemplo: ./actualizaSucursales-v0.1.sh 0.1.3"
    echo ""
fi

#=============================================================================
#                            FIN DE ARCHIVO
##############################################################################