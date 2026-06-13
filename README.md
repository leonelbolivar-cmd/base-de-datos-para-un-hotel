# base-de-datos-para-un-hotel
Integrantes:
-Diego Alonso Meza Perochena (diegomezaperochena)
-Leonel Alessandro Bolivar Domador(leonelbolivar-cmd y Aless014)
-Rodrigo Samuel Lovon Ahumada(rodloucs)
-Matheo Miguel Atencio Zuñiga

En este trabajo hay 16 tablas.

Sobre el docker:
Nota(cada que se realice un cambio y se desee probar se debe de apagar el contendor ya sea por terminal o el app , y debe de aplicarse los pasos dos y uno nuevamente para que el contenedor se actualice y tenga los cambios)
1.-Crear el contenedor
    docker-compose up -d
2.-Dar de bajar contenedor para actualizar volumenes y funciones
    docker-compose down -v 
3.-Verificar logs en el contenedor
    docker-compose logs db
4.-Verificar funcionamiento de las instancias en el docker 
    docker-compose ps

