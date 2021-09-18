CREATE DATABASE banco;
USE banco;

# --------------------------------------------------------------------------
# Creacion Tablas para las entidades

CREATE TABLE Ciudad (
    cod_postal SMALLINT UNSIGNED NOT NULL,
    nombre VARCHAR(25) NOT NULL,

    CONSTRAINT pk_ciudad
    PRIMARY KEY (cod_postal)
) ENGINE=InnoDB;

CREATE TABLE Sucursal (
    nro_suc SMALLINT UNSIGNED NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    direccion VARCHAR(25) NOT NULL, 
    telefono VARCHAR(25) NOT NULL,
    horario VARCHAR(25) NOT NULL,
    cod_postal SMALLINT UNSIGNED NOT NULL,

    CONSTRAINT pk_sucursal
    PRIMARY KEY (nro_suc),

    CONSTRAINT FK_sucursal_ciudad
    FOREING KEY (cod_postal) REFERENCES Ciudad (cod_postal)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE= InnoDB;

CREATE TABLE Empleado (
    legajo SMALLINT UNSIGNED NOT NULL,
    apellido VARCHAR (25) NOT NULL,
    nombre VARCHAR (25) NOT NULL,
    tipo_doc VARCHAR (25) NOT NULL,
    nro_doc INT UNSIGNED NOT NULL,
    direccion VARCHAR (25) NOT NULL,
    telefono VARCHAR (25) NOT NULL, 
    cargo VARCHAR (25) NOT NULL,
    password VARCHAR (25) NOT NULL,
    nro_suc SMALLINT UNSIGNED NOT NULL,

    CONSTRAINT pk_empleado
    PRIMARY KEY (legajo),

    CONSTRAINT FK_empleado_sucursal
    FOREIGN KEY (nro_suc) REFERENCES Sucursal (nro_suc)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE= InnoDB;

CREATE TABLE Cliente (
    nro_cliente INT UNSIGNED NOT NULL,
    apellido VARCHAR (25) NOT NULL,
    nombre VARCHAR (25) NOT NULL, 
    tipo_doc VARCHAR (25) NOT NULL,
    nro_doc INT UNSIGNED NOT NULL,
    direccion VARCHAR (25) NOT NULL,
    telefono VARCHAR (25) NOT NULL,
    fecha_nac DATE NOT NULL,

    CONSTRAINT pk_cliente
    PRIMARY KEY (nro_cliente)
) ENGINE= InnoDB;

CREATE TABLE Plazo_Fijo (
    nro_plazo SMALLINT UNSIGNED NOT NULL,
    capital REAL UNSIGNED NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    tasa_interes REAL UNSIGNED NOT NULL,
    interes REAL UNSIGNED NOT NULL,
    nro_suc SMALLINT UNSIGNED NOT NULL,

    CONSTRAINT pk_plazo_fijo
    PRIMARY KEY (nro_plazo),

    CONSTRAINT FK_plazo_fijo_sucursal
    FOREIGN KEY (nro_suc) REFERENCES Sucursal (nro_suc)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE= InnoDB;

CREATE TABLE Tasa_plazo_fijo {
	periodo SMALLINT UNSIGNED NOT NULL,
	monto_inf FLOAT UNSIGNED NOT NULL,
	monto_sup FLOAT UNSIGNED NOT NULL,
	tasa FLOAT UNSIGNED NOT NULL,
	
	CONSTRAINT pk_tasa_plaza_fijo
	PRIMARY KEY(periodo, monto_inf, monto_sup)
} ENGINE = InnoDB;

CREATE TABLE Prestamo {
	nro_prestamo INT NOT NULL,
	fecha DATE NOT NULL,
	cant_meses SMALLINT NOT NULL,
	monto FLOAT UNSIGNED NOT NULL,
	tasa_interes FLOAT UNSIGNED NOT NULL,
	interes FLOAT UNSIGNED NOT NULL,
	valor_cuota FLOAT UNSIGNED NOT NULL,
	legajo SMALLINT UNSIGNED NOT NULL,
	nro_cliente INT UNSIGNED NOT NULL,
	
	CONSTRAINT pk_prestamo
	PRIMARY KEY (nro_prestamo),
	
	CONSTRAINT FK_prestamo_empleado
	FOREIGN KEY (legajo) REFERENCES Empleado (legajo)
		ON DELETE RESTRICT ON UPDATE CASCADE,
	
	CONSTRAINT FK_prestamo_cliente
	FOREIGN KEY (nro_cliente) REFERENCES Cliente (nro_cliente)
		ON DELETE RESTRICT ON UPDATE CASCADE
} ENGINE = InnoDB;

CREATE TABLE Pago { #ENTIDAD DEBIL
	nro_prestamo INT NOT NULL,
	nro_pago SMALLINT NOT NULL,
	fecha_venc DATE NOT NULL,
	fecha_pago DATE NOT NULL,
	
	CONSTRAINT pk_pago 
	PRIMARY KEY(nro_prestamo,nro_pago),
	
	CONSTRAINT FK_pago_prestamo
	FOREIGN KEY (nro_prestamo) REFERENCES Prestamo (nro_prestamo)
		ON DELETE RESTRICT ON UPDATE CASCADE
} ENGINE = InnoDB;

CREATE TABLE Tasa_prestamo {
	periodo SMALLINT UNSIGNED NOT NULL,
	monto_inf FLOAT UNSIGNED NOT NULL,
	monto_sup FLOAT UNSIGNED NOT NULL,
	tasa DECIMAL 6,2 UNSIGNED NOT NULL,
	
	CONSTRAINT pk_tasa_prestamo
	PRIMARY KEY (periodo,monto_inf,monto_sup)
} ENGINE = InnoDB;

CREATE TABLE Caja_ahorro {
	nro_ca INT NOT NULL,
	CBU INT NOT NULL,
	saldo FLOAT UNSIGNED NOT NULL,
	
	CONSTRAINT pk_caja_ahorro
	PRIMARY KEY(nro_ca)
} ENGINE = InnoDB;

CREATE TABLE Tarjeta {
	nro_tarjeta INT NOT NULL,
	PIN VARCHAR(32) NOT NULL,
	CVT VARCHAR(32) NOT NULL,
	fecha_venc DATE NOT NULL,
	nro_cliente INT UNSIGNED NOT NULL,
	nro_ca INT NOT NULL,
	
	CONSTRAINT pk_tarjeta
	PRIMARY KEY (nro_tarjeta),
	
	CONSTRAINT FK_tarjeta_cliente
	FOREIGN KEY (nro_cliente) REFERENCES Cliente (nro_cliente)
		ON DELETE RESTRICT ON UPDATE CASCADE,
		
	CONSTRAINT FK_tarjeta_cliente_ca
	FOREIGN KEY (nro_ca) REFERENCES Cliente_CA (nro_ca)
		ON DELETE RESTRICT ON UPDATE CASCADE
} ENGINE = InnoDB;

CREATE TABLE Caja {
	cod_caja INT NOT NULL,
	
	CONSTRAINT pk_caja
	PRIMARY KEY (cod_caja)
} ENGINE = InnoDB;

CREATE TABLE Ventanilla {
	cod_caja INT NOT NULL,
	nro_suc SMALLINT UNSIGNED NOT NULL,
	
	CONSTRAINT pk_ventanilla 
	PRIMARY KEY (cod_caja),
	
	CONSTRAINT FK_ventanilla_caja
	FOREIGN KEY (cod_caja) REFERENCES Caja (cod_caja)
		ON DELETE RESTRICT ON UPDATE CASCADE,
		
	CONSTRAINT FK_ventanilla_sucursal
	FOREIGN KEY (nro_suc) REFERENCES Sucursal (nro_suc)
		ON DELETE RESTRICT ON UPDATE CASCADE,
} ENGINE = InnoDB;

CREATE TABLE ATM {
	cod_caja INT NOT NULL,
	cod_postal SMALLINT UNSIGNED NOT NULL,
	direccion VARCHAR(25) NOT NULL,
	
	CONSTRAINT pk_ATM
	PRIMARY KEY (cod_caja)
	
	CONSTRAINT FK_ATM_caja
	FOREIGN KEY (cod_caja) REFERENCES Caja (cod_caja)
		ON DELETE RESTRICT ON UPDATE CASCADE,
		
	CONSTRAINT FK_ATM_ciudad
	FOREIGN KEY (cod_postal) REFERENCES Ciudad (cod_postal)
		ON DELETE RESTRICT ON UPDATE CASCADE
} ENGINE = InnoDB;

CREATE TABLE Transaccion (
    nro_trans BIGINT UNSIGNED NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    monto REAL UNSIGNED NOT NULL,

    CONSTRAINT pk_transaccion
    PRIMARY KEY (nro_trans)
) ENGINE= InnoDB;

CREATE TABLE Debito (
    nro_trans BIGINT UNSIGNED NOT NULL,
    descripcion VARCHAR (50) NOT NULL,
    nro_cliente INT UNSIGNED NOT NULL,
    nro_caja INT NOT NULL,

    CONSTRAINT pk_debito
    PRIMARY KEY (nro_trans),

    CONSTRAINT FK_debito_cliente_ca
    FOREIGN KEY (nro_cliente,nro_caja) REFERENCES Cliente_CA (nro_cliente,nro_caja)
) ENGINE= InnoDB;

CREATE TABLE Transaccion_por_caja(
    nro_trans BIGINT UNSIGNED NOT NULL,
    cod_caja INT NOT NULL,
    
    CONSTRAINT pk_transaccion_por_caja
    PRIMARY KEY (nro_trans)
) ENGINE= InnoDB;

CREATE TABLE Deposito (
    nro_trans BIGINT UNSIGNED NOT NULL,
    nro_ca INT NOT NULL,

    CONSTRAINT pk_deposito
    PRIMARY KEY (nro_trans),

    CONSTRAINT FK_deposito_transaccion_por_caja
    FOREIGN KEY (nro_trans) REFERENCES Transaccion_por_caja (nro_trans)
        ON DELETE RESTRICT ON UPDATE CASCADE,

    CONSTRAINT FK_deposito_caja_de_ahorro
    FOREIGN KEY (nro_ca) REFERENCES Transaccion_por_caja Caja_Ahorro (nro_ca)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE= InnoDB;

CREATE TABLE Extraccion (
    nro_trans BIGINT UNSIGNED NOT NULL,
    nro_cliente INT UNSIGNED NOT NULL,
    nro_ca INT UNSIGNED NOT NULL,

    CONSTRAINT pk_extraccion
    PRIMARY KEY (nro_trans),

    CONSTRAINT FK_extraccion_transaccion_por_caja
    FOREIGN KEY (nro_trans) REFERENCES Transaccion_por_caja (nro_trans)
        ON DELETE RESTRICT ON UPDATE CASCADE,

    CONSTRAINT FK_extraccion_cliente_CA
    FOREIGN KEY (nro_cliente, nro_ca) REFERENCES Cliente_CA (nro_cliente,nro_ca)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE= InnoDB;

CREATE TABLE Transferencia (
    nro_trans BIGINT UNSIGNED NOT NULL,
    nro_cliente INT UNSIGNED NOT NULL,
    origen 
    destino 
) ENGINE= InnoDB;

#-------------------------------------------------------------------------
#---  Creacion Tablas para las relaciones   ------------------------------

CREATE TABLE Plazo_cliente {
	nro_plazo SMALLINT unsigned NOT NULL,
	nro_cliente INT UNSIGNED NOT NULL,
	
	CONSTRAINT pk_plazo_cliente
	PRIMARY KEY(nro_plazo,nro_cliente),
	
	CONSTRAINT FK_plazo_cliente_plazo_fijo
	FOREIGN KEY (nro_plazo) REFERENCES Plazo_fijo (nro_plazo)
		ON DELETE RESTRICT ON UPDATE CASCADE,
		
	CONSTRAINT FK_plazo_cliente_cliente
	FOREIGN KEY (nro_cliente) REFERENCES Cliente (nro_cliente)
		ON DELETE RESTRICT ON UPDATE CASCADE
} ENGINE = InnoDB;

CREATE TABLE  Cliente_CA{
	nro_cliente INT UNSIGNED NOT NULL,
	nro_ca INT NOT NULL,
	
	CONSTRAINT pk_cliente_ca
	PRIMARY KEY (nro_cliente,nro_ca),
	
	CONSTRAINT FK_plazo_cliente_ca_cliente
	FOREIGN KEY (nro_cliente) REFERENCES Cliente (nro_cliente)
		ON DELETE RESTRICT ON UPDATE CASCADE,
		
	CONSTRAINT FK_plazo_cliente_ca_caja_ahorro
	FOREIGN KEY (nro_ca) REFERENCES Caja_ahorro (nro_ca)
		ON DELETE RESTRICT ON UPDATE CASCADE
} ENGINE = InnoDB;

#-------------------------------------------------------------------------
# Creacion de usuarios y otorgamiento de privilegios
#-------------------------------------------------------------------------

# Usuario admin
CREATE USER 'admin'@'localhost'  IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON banco.* TO 'admin'@'localhost' WITH GRANT OPTION;

# Usuario empleado
CREATE USER 'empleado'@'%'  IDENTIFIED BY 'empleado';
GRANT SELECT ON banco.Empleado, banco.Sucursal, banco.Tasa_plazo_fijo, banco.Tasa_prestamo, banco.Prestamo TO 'empleado'@'%';
GRANT SELECT,INSERT ON banco.Prestamo, banco.Plazo_fijo, banco.Plazo_cliente, banco.Caja_ahorro, banco.Tarjeta TO 'empleado'@'%';
GRANT SELECT,INSERT,UPDATE ON banco.Cliente_CA, banco.Cliente, banco.Pago TO 'empleado'@'%';
    


