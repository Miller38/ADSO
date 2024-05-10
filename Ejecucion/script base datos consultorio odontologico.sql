
-- Crear base de datos selecionamos el tipo de caracteres especiales 
CREATE DATABASE consultorio_odontologico CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci;

--  Advertencia este comando borra toda la base de datos
--  DROP DATABASE consultorio_odontologico;

USE consultorio_odontologico;  -- Seleccionar la base de datos

SELECT DATABASE(); -- Nos muestra cual base de datos tenemos seleccionada

# Algunos comandos utilizados en esta base de datos 
SHOW TABLES; -- Muestra todas las tablas creadas 
DESCRIBE Usuarios; -- Muestra la tabla con sus tipos de datos
SHOW COLUMNS FROM Pacientes; -- Muestra las columnas de la tabla
RENAME TABLE Usuarios to Usuario; -- Renombrar una tabla


# ----------------------------------------------------------------------------------
-- Crear tabla Usuarios
CREATE TABLE Usuarios (
    userID INT PRIMARY KEY  AUTO_INCREMENT, -- Identificador único de usuario, auto incremental
    username VARCHAR(50), -- Nombre de usuario
    password VARCHAR(255) -- Contraseña 
);

-- Ejemplo para Insertar registros en la tabla Usuarios
INSERT INTO `Usuarios` (username,password) VALUES ('Yuliet','123456'),('Fabian','789654');

# ----------------------------------------------------------------------------------
-- Crear tabla TiposUsuario
CREATE TABLE TiposUsuario (
    tipoID INT PRIMARY KEY AUTO_INCREMENT, -- Identificador único de tipo de usuario
    userID INT, -- Clave foránea que referencia la tabla Usuarios
    userType ENUM('auxiliar', 'odontologo'), -- Tipo de usuario (paciente u odontólogo)
    FOREIGN KEY (userID) REFERENCES Usuarios(userID) -- Clave foránea que referencia la tabla Usuarios
);

# ----------------------------------------------------------------------------------
-- Crear tabla Auxiliar
CREATE TABLE Auxiliar (
    auxiliarID INT PRIMARY KEY AUTO_INCREMENT, -- Identificador único de auxiliar
    userID INT, -- Clave foránea que referencia la tabla Usuarios
    nombre VARCHAR(50), -- Nombre del auxiliar
    apellido VARCHAR(50), -- Apellido del auxiliar
    direccion VARCHAR(100), -- Dirección del auxiliar
    telefono VARCHAR(15), -- Número de teléfono del auxiliar
    ciudad VARCHAR(20), -- Ciudad de residencia 
    correo_electronico VARCHAR(100), -- Correo electrónico del auxiliar
    FOREIGN KEY (userID) REFERENCES Usuarios(userID) -- Clave foránea que referencia la tabla Usuarios
);

# ----------------------------------------------------------------------------------
-- Crear tabla Pacientes
CREATE TABLE Pacientes (
    pacienteID INT PRIMARY KEY AUTO_INCREMENT, -- Identificador único de paciente
    userID INT, -- Clave foránea que referencia la tabla Usuarios
    auxiliarID INT, -- Clave foránea que referencia la tabla Auxiliar
    nombre VARCHAR(50), -- Nombre del paciente
    apellido VARCHAR(50), -- Apellido del paciente
    fecha_nacimiento DATE, -- Fecha de nacimiento del paciente
    direccion VARCHAR(100), -- Dirección del paciente
    telefono VARCHAR(15), -- Número de teléfono del paciente
    ciudad VARCHAR(20),
    correo_electronico VARCHAR(100), -- Correo electrónico del paciente
    FOREIGN KEY (userID) REFERENCES Usuarios(userID), -- Clave foránea que referencia la tabla Usuarios
    FOREIGN KEY (auxiliarID) REFERENCES Auxiliar(auxiliarID) ON DELETE RESTRICT -- Clave foránea que referencia la tabla Auxiliar con restricción restrictiva de borrado
);



-- Agregamos la columna auxiliarID en la tabla pacientes y le decimos que la cree despues de auxiliarID
ALTER TABLE Pacientes ADD COLUMN odontologoID INT AFTER auxiliarID;
-- Borramos la columna odontologoID
ALTER TABLE Pacientes DROP COLUMN odontologoID;     
-- Agregamos una restriccion de uno a muchos en la tabla pacientes donde un odontologo tiene muchos pacientes
ALTER TABLE Pacientes ADD CONSTRAINT fk_odontologoID FOREIGN KEY (odontologoID) REFERENCES Odontologos(odontologoID) ON DELETE RESTRICT;
-- Eliminar la restricción de clave externa de la tabla TiposUsuario
ALTER TABLE Pacientes DROP FOREIGN KEY fk_odontologoID;
-- Advertencia Elimina la tabla Pacientes
-- DROP TABLE Pacientes;

# ----------------------------------------------------------------------------------
-- Crear tabla Odontologos
CREATE TABLE Odontologos (
    odontologoID INT PRIMARY KEY AUTO_INCREMENT, -- Identificador único de odontólogo
    userID INT, -- Clave foránea que referencia la tabla Usuarios
    nombre VARCHAR(50), -- Nombre del odontólogo
    apellido VARCHAR(50), -- Apellido del odontólogo
    especialidad VARCHAR(100), -- Especialidad del odontólogo
    direccion VARCHAR(100), -- Dirección del odontólogo
    telefono VARCHAR(15), -- Número de teléfono del odontólogo
    ciudad VARCHAR(20), -- Ciudad de residencia del odontologo
    correo_electronico VARCHAR(100), -- Correo electrónico del odontólogo
    FOREIGN KEY (userID) REFERENCES Usuarios(userID) -- Clave foránea que referencia la tabla Usuarios
);

SHOW CREATE TABLE Odontologos; -- Muestra el codigo SQL como se creo la tabla
-- Agregamos la columna pais en la tabla odontologos 
ALTER TABLE Odontologos ADD COLUMN pais VARCHAR(15) NULL;
-- Podemos borrar la columna pais
ALTER TABLE Odontologos DROP COLUMN pais;

# ----------------------------------------------------------------------------------
-- Crear tabla Consultas
CREATE TABLE Consultas (
    consultaID INT PRIMARY KEY AUTO_INCREMENT, -- Identificador único de consulta
    pacienteID INT, -- Clave foránea que referencia la tabla Pacientes
    odontologoID INT, -- Clave foránea que referencia la tabla Odontólogos
    fecha DATE, -- Fecha de la consulta
    motivo VARCHAR(255), -- Motivo de la consulta
    diagnostico TEXT, -- Diagnóstico de la consulta
    tratamiento TEXT, -- Tratamiento de la consulta
    FOREIGN KEY (pacienteID) REFERENCES Pacientes(pacienteID), -- Clave foránea que referencia la tabla Pacientes
    FOREIGN KEY (odontologoID) REFERENCES Odontologos(odontologoID) -- Clave foránea que referencia la tabla Odontólogos
);

# ----------------------------------------------------------------------------------
-- Crear tabla Citas
CREATE TABLE Citas (
    citaID INT PRIMARY KEY AUTO_INCREMENT, -- Identificador único de cita
    pacienteID INT, -- Clave foránea que referencia la tabla Pacientes
    odontologoID INT, -- Clave foránea que referencia la tabla Odontólogos
    fecha DATE, -- Fecha de la cita
    hora TIME, -- Hora de la cita
    motivo VARCHAR(255), -- Motivo de la cita
    FOREIGN KEY (pacienteID) REFERENCES Pacientes(pacienteID), -- Clave foránea que referencia la tabla Pacientes
    FOREIGN KEY (odontologoID) REFERENCES Odontologos(odontologoID) -- Clave foránea que referencia la tabla Odontólogos
);

# ----------------------------------------------------------------------------------
-- Crear tabla Agenda
CREATE TABLE Agenda (
    agendaID INT PRIMARY KEY AUTO_INCREMENT, -- Identificador único de agenda
    odontologoID INT, -- Clave foránea que referencia la tabla Odontólogos
    fecha DATE, -- Fecha de la agenda
    hora_inicio TIME, -- Hora de inicio de la agenda
    hora_fin TIME, -- Hora de finalización de la agenda
    FOREIGN KEY (odontologoID) REFERENCES Odontologos(odontologoID) -- Clave foránea que referencia la tabla Odontólogos
);

# ----------------------------------------------------------------------------------
-- Crear tabla Historial
CREATE TABLE Historial (
    historialID INT PRIMARY KEY AUTO_INCREMENT, -- Identificador único de historial
    pacienteID INT, -- Clave foránea que referencia la tabla Pacientes
    fecha DATE, -- Fecha del historial
    descripcion TEXT, -- Descripción del historial
    FOREIGN KEY (pacienteID) REFERENCES Pacientes(pacienteID) -- Clave foránea que referencia la tabla Pacientes
);

# ----------------------------------------------------------------------------------
-- Crear tabla Configuración
CREATE TABLE Configuracion (
    configID INT PRIMARY KEY AUTO_INCREMENT, -- Identificador único de configuración
    nombre_clinica VARCHAR(100), -- Nombre de la clínica
    direccion VARCHAR(100), -- Dirección de la clínica
    telefono VARCHAR(15), -- Número de teléfono de la clínica
    ciudad VARCHAR(20),
    correo_electronico VARCHAR(100), -- Correo electrónico de la clínica
    horario_atencion VARCHAR(100) -- Horario de atención de la clínica
);

# ----------------------------------------------------------------------------------
-- Crear tabla Facturas
CREATE TABLE Facturas (
    facturaID INT PRIMARY KEY AUTO_INCREMENT, -- Identificador único de factura
    consultaID INT, -- Clave foránea que referencia la tabla Consultas
    fecha DATE, -- Fecha de la factura
    total DECIMAL(10, 2), -- Total de la factura
    FOREIGN KEY (consultaID) REFERENCES Consultas(consultaID) -- Clave foránea que referencia la tabla Consultas
);
