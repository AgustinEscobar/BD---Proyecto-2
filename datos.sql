# Carga de datos de Prueba

# Ciudad (cod_postal,nombre)
INSERT INTO Ciudad VALUES (6409,"Tres Lomas");
INSERT INTO Ciudad VALUES (8000,"Bahia Blanca");
INSERT INTO Ciudad VALUES (1850,"Dorrego");

# Sucursal (nro_suc,nombre,direccion,telefono,horario,cod_postal)
INSERT INTO Sucursal VALUES (1,"Banco Provincia","Alem 979","239212345","8hs a 15hs",8000);
INSERT INTO Sucursal VALUES (2,"Banco Nacion","Monteverde 105","239200000","8hs a 14hs",6409);

# Empleado (legajo,apellido,nombre,tipo_doc,nro_doc,direccion,telefono,cargo,password,nro_suc)
INSERT INTO Empleado VALUES (119000,"Martinez", "Pity", "DNI Ejemplar A",41123456, "Corrientes 423","29109122018","Jefe",md5('pwpity'),1);
INSERT INTO Empleado VALUES (118000,"Quintero", "Juan Fer", "DNI Ejemplar A",41987654, "Madrid 912","291430001","Cajero",md5('pwjuanfer'),2);

# Cliente (nro_cliente, apellido, nombre, tipo_doc. nro_doc, direccion, telefono, fecha_nac)
INSERT INTO Cliente VALUES (23000,"De Battista","Agustin","DNI","42091234","Casanova 473","2921495069","1999/11/23");
INSERT INTO Cliente VALUES (23001,"Escobar","Agustin","DNI","42091202","Alem 473","2921501020","1999/04/05");
INSERT INTO Cliente VALUES (23002,"Pereyra","Roberto","DNI","38011409","12 de Octubre 1000","2915012389","1990/12/10");
INSERT INTO Cliente VALUES (23003,"De Paul","Rodrigo","DNI","30011900","Salta 200","2921490303","1995/02/25");
INSERT INTO Cliente VALUES (23004,"Ramos","Sergio","DNI","35000900","Estomba 200","2910303456","1985/10/06");

# Plazo_fijo (nro_plazo,capital,fecha_inicio,fecha_fin,tasa_interes,interes,nro_suc)
INSERT INTO Plazo_Fijo VALUES (001,15.345,"2020/06/22","2021/09/18",30,25,1);
INSERT INTO Plazo_fijo VALUES (800,12000,"2012/12/12","2014/01/01",1500,5000,2);

# Tasa_plazo_fijo
INSERT INTO Tasa_plazo_fijo VALUES (100,2300,1000,1500);
INSERT INTO Tasa_plazo_fijo VALUES (102,2350,1020,1510);
INSERT INTO Tasa_plazo_fijo VALUES (400,1000,1500);
INSERT INTO Tasa_plazo_fijo VALUES (100,2300,1000,1500);