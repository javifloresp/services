
# Servicios 

Aqui se indican los pasos a seguir para el funcionamiento del proyecto **Crowdfunding**

## Comenzando 🚀

_Estas instrucciones te permitirán obtener una copia del proyecto en funcionamiento en tu máquina local para propósitos de desarrollo y pruebas en **Crowdfunding**._



### Pre-requisitos 📋

Es requerido contar con **docker** ,**docker-compose** y **make**.

### Instalación 🔧


Primero es necesario descargar nuestro repositorio de la siguente manera

```
git clone git@github.com:AgileSoftMX/infrastructure.git
```

## Entorno Local ⚙️

Un vez que tengamos todo lo necesario para la instalación vamos a configurar el entorno de desarrollo local
ejecutando dentro de la carpeta de nuestro repositorio.
```
make configure
```
El sistema nos hara una serie de preguntas para configurar el entorno.

La primera pregunta sera si deseamos configurar el SSL, esto a menos que cuentes con un dominio apuntando a tu servidor o a tu ip publica indicamos que no, y debe mostrarnos un resulado como el siguiente.
```
Add SSL certificate? ( yes or no ) ? : no
```
La siguiente pregunta sera cual es el nombre del entorno , indicamos **local** :
```
What is the name of the environment? : local
```
La siguiente pregunta sera acerca de nuestro directorio raiz , es importante mencionar que este folder es donde se encuentran nuestro codigo , en mi local se encuentra en **~/Sites** :
```
What is the root path? : ~/Sites
```
En esta pregunta para el entorno local solo colocamos *.test :
```
What domains do you want to add? (ex: domain.com , sub.domain.com) : *.test
```
Y por ultimo indicamos el dominio que tendra nuestro dashboard de gestion en este caso sera **dashboard.test** :
```
What is the name of the dashboard? (ex: dashboard.domain.com ) : dashboard.test
```

Finalizando este proceso ya estaria listo nuestro entorono local.

### Levantando el entorno 🔩

Un vez ya configurado solo resta ejecutar el comando **install** de la siguiente manera :
``` 
make install
```
Esto debe levantarnos los siguientes servicios que son:

- **dbserver**
- **php**
- **nginx**
- **nginx-proxy**
- **dashboard**
- **nginx-proxy-certificates**

## Entorno Servidor ⚙️

Levantar el entorno en un servidor es exactamente igual salvo unas cuantas variaciones de configuración.

Al igual que en el entorno local ejecutaremos el comando **configure**:
```
make configure
```
Al igual que en el caso anterior nos realizara el mismo "cuestionario" s.
La primera pregunta sera si deseamos configurar el SSL, esto a menos que cuentes con un dominio apuntando a tu servidor o a tu ip publica indicamos que si, y debe mostrarnos un resulado como el siguiente.
```
Add SSL certificate? ( yes or no ) ? : si
```
La siguiente pregunta sera cual es el nombre del entorno , indicamos **beta** :
```
What is the name of the environment? : beta
```
La siguiente pregunta sera acerca de nuestro directorio raiz , es importante mencionar que este folder es donde se encuentran nuestro codigo , en mi local se encuentra en **/var/www** :
```
What is the root path? : /var/ww
```
En esta pregunta indicaremos los dominios alojados en nuestro entorno para beta indicamos **web.cf.agilesoft.mx,manager.cf.agilesoft.mx,dashboard.cf.agilesoft.mx** , es importante mencionar que los dominios debe ir separados por **,** :
```
What domains do you want to add? (ex: domain.com , sub.domain.com) : web.cf.agilesoft.mx,manager.cf.agilesoft.mx,dashboard.cf.agilesoft.mx
```
Y por ultimo indicamos el dominio que tendra nuestro dashboard de gestion en este caso sera **dashboard.cf.agilesoft.mx** :
```
What is the name of the dashboard? (ex: dashboard.domain.com ) : dashboard.cf.agilesoft.mx
```

Finalizando este proceso ya estaria listo nuestro entorono.

Una vez hecho esto solo restaría ejecutar el comando **install** : 

```
make install
```

Esto nos debería levantar los siguientes servicios :

- **dbserver**
- **php**
- **nginx**
- **nginx-proxy**
- **dashboard**
- **nginx-proxy-certificates**

## Comandos adicionales ⏰
El paquete cuenta con comandos adiciones los cuales son los siguientes:

* **status**
* **logs**
* **rebuild-start**
* **stop**
* **start**
* **down**
* **prune**
* **clear**
* **helps**

## Targets 🛠️

#### logs
Muestra los logs en pantalla ejecutando siendo un alias de **docker-compose logs -f**

#### status
Muestra la configuración actual en pantalla siendo un alias de **docker-compose config**

#### rebuild-start
Reconstruye los servicios siendo un alias de **docker-compose up -d --force-recreate**.

#### down
Destruye los servicios siendo un alias de **docker-compose down**.

#### help
Muestra en pantalla la información de ayuda.

#### prune
Purga todo el sistema de archivos de docker , muy importante recordar que esto implica imagenes , volumenes y contenedores.

#### stop
Detiene un servicio , este comando al ejecutarse preguntara cual servicio detener, siendo un alias de **docker-compose stop [service]**.

#### start
Inicia un servicio , este comando al ejecutarse preguntara cual servicio iniciar, siendo un alias de **docker-compose start [service]**.