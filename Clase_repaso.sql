DROP DATABASE IF EXISTS repaso_bd;
CREATE DATABASE IF NOT EXISTS repaso_bd;
Use repaso_bd;

CREATE TABLE Aerolinea (
    Id_aerolinea INT NOT NULL,
    nombre VARCHAR(255),
    descripcion VARCHAR(255),
    CONSTRAINT Pk_aerolinea primary key (Id_aerolinea)
);

CREATE TABLE Vuelo (
    Id_vuelo INT NOT NULL,
    NumVuelo VARCHAR(255),
    NumAvion VARCHAR(255),
    origen VARCHAR(255),
    destino VARCHAR(255),
    Id_aerolinea INT NOT NULL,
    CONSTRAINT Pk_vuelo primary key (Id_vuelo),
    CONSTRAINT Fk_aerolinea FOREIGN KEY (Id_aerolinea) REFERENCES Aerolinea(Id_aerolinea)
);

CREATE TABLE Pasajero (
    Id_pasajero INT NOT NULL,
    nombre VARCHAR(255),
    apellido VARCHAR(255),
    telefono VARCHAR(20),
    email VARCHAR(255),
    pasaporte VARCHAR(255),
    CONSTRAINT Pk_pasajero primary key (Id_pasajero)
);

CREATE TABLE HistorialEstado (
    Id_HistorialEstado INT NOT NULL,
    estado VARCHAR(255),
    descripcion VARCHAR(255),
    CONSTRAINT Pk_HistorialEstado primary key (Id_HistorialEstado)
);

CREATE TABLE DetalleReserva (
    Id_DetalleReserva INT NOT NULL,
    estado VARCHAR(255),
    descripcion VARCHAR(255),
    CONSTRAINT Pk_DetalleReserva primary key (Id_DetalleReserva)
);

CREATE TABLE Reserva (
    Id_reserva INT NOT NULL,
    codigo VARCHAR(255),
    fecha DATE,
    hora INT,
    Id_vuelo INT NOT NULL,
    Id_pasajero INT NOT NULL,
    Id_DetalleReserva INT NOT NULL,
    CONSTRAINT Pk_Reserva primary key (Id_reserva),
    CONSTRAINT Fk_Vuelo FOREIGN KEY (Id_vuelo) REFERENCES Vuelo(Id_vuelo),
    CONSTRAINT Fk_Pasajero FOREIGN KEY (Id_pasajero) REFERENCES Pasajero(Id_pasajero),
    CONSTRAINT Fk_DetalleReserva FOREIGN KEY (Id_DetalleReserva) REFERENCES DetalleReserva(Id_DetalleReserva)
);

CREATE TABLE Asiento (
    Id_asiento INT NOT NULL,
    numero INT,
    Id_HistorialEstado INT NOT NULL,
    Id_reserva INT NOT NULL,
    CONSTRAINT Pk_Asiento primary key (Id_asiento),
    CONSTRAINT Fk_HistorialEstado FOREIGN KEY (Id_HistorialEstado) REFERENCES HistorialEstado(Id_HistorialEstado),
    CONSTRAINT Fk_Reserva FOREIGN KEY (Id_reserva) REFERENCES Reserva(Id_reserva)
);

CREATE TABLE Destino (
    Id_destino INT NOT NULL,
    descripcion VARCHAR(255),
    Id_vuelo INT NOT NULL,
    CONSTRAINT Pk_destino primary key (Id_destino),
    CONSTRAINT FK_Vueloo FOREIGN KEY (Id_vuelo) REFERENCES Vuelo(Id_vuelo)
);
