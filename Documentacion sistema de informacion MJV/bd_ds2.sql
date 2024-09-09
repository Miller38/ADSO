

-- Tabla de odontólogos, que registra la información personal y profesional de los odontólogos
CREATE TABLE tb_odontologos (
  id int(11)PRIMARY KEY NOT NULL AUTO_INCREMENT, -- ID principal, clave primaria auto-incremental
  nombre_odontologo varchar(100) NOT NULL, -- Nombre del odontólogo
  apellido varchar(100) NOT NULL, -- Apellido del odontólogo
  direccion varchar(100) NOT NULL, -- Dirección del odontólogo
  ciudad varchar(20) DEFAULT NULL, -- Ciudad donde reside
  pais varchar(20) DEFAULT NULL, -- País de residencia
  especialidad_id int(11) NOT NULL, -- Relación con la tabla de especialidades
  telefono varchar(20) DEFAULT NULL, -- Teléfono de contacto
  email varchar(45) DEFAULT NULL, -- Correo electrónico
  identificacion varchar(50) NOT NULL, -- Identificación del odontólogo
  imagen mediumblob DEFAULT NULL, -- Imagen del odontólogo (foto)
  tipo_identificacion varchar(20) NOT NULL, -- Tipo de identificación (DNI, pasaporte, etc.)
  fecha_nacimiento date DEFAULT NULL, -- Fecha de nacimiento
  genero varchar(15) DEFAULT NULL, -- Género del odontólogo
  numero_licencia varchar(50) DEFAULT NULL, -- Número de licencia profesional
  fecha_contratacion date DEFAULT NULL, -- Fecha de contratación
  fecha_registro timestamp NOT NULL DEFAULT current_timestamp(), -- Fecha de registro del odontólogo
  CONSTRAINT tb_odontologos_especialidad_fk FOREIGN KEY (especialidad_id) REFERENCES tb_especialidades (id) -- Relación con la tabla de especialidades
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tabla de especialidades, que almacena las distintas especialidades de odontólogos
CREATE TABLE tb_especialidades (
  id int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT, -- ID principal, clave primaria auto-incremental
  nombre_especialidad varchar(100) NOT NULL, -- Nombre de la especialidad
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tabla de pacientes, que registra la información personal y médica de los pacientes
CREATE TABLE tb_pacientes (
  id int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT, -- ID principal, clave primaria auto-incremental
  nombre varchar(100) NOT NULL, -- Nombre del paciente
  apellido varchar(100) DEFAULT NULL, -- Apellido del paciente
  direccion varchar(100) NOT NULL, -- Dirección del paciente
  ciudad varchar(20) DEFAULT NULL, -- Ciudad de residencia
  pais varchar(20) DEFAULT NULL, -- País de residencia
  telefono varchar(15) DEFAULT NULL, -- Teléfono de contacto
  email varchar(50) DEFAULT NULL, -- Correo electrónico
  fecha_nacimiento date DEFAULT NULL, -- Fecha de nacimiento
  genero varchar(15) DEFAULT NULL, -- Género del paciente
  identificacion varchar(50) DEFAULT NULL, -- Identificación del paciente
  tipo_identificacion varchar(20) DEFAULT NULL, -- Tipo de identificación
  tipo_sangre varchar(5) DEFAULT NULL, -- Tipo de sangre del paciente
  alergias varchar(255) DEFAULT NULL, -- Alergias del paciente
  imagen mediumblob DEFAULT NULL, -- Imagen del paciente
  ruta varchar(50) DEFAULT NULL, -- Ruta del archivo de imagen
  historial_medico text DEFAULT NULL, -- Historial médico del paciente
  estado_civil varchar(20) DEFAULT NULL, -- Estado civil del paciente
  ocupacion varchar(50) DEFAULT NULL, -- Ocupación del paciente
  fecha_registro timestamp NOT NULL DEFAULT current_timestamp() -- Fecha de registro
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tabla auxiliar que almacena información de los auxiliares de los odontólogos
CREATE TABLE tb_auxiliar (
  id int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT, -- ID principal, clave primaria auto-incremental
  nombre varchar(100) NOT NULL, -- Nombre del auxiliar
  apellido varchar(100) DEFAULT NULL, -- Apellido del auxiliar
  direccion varchar(100) DEFAULT NULL, -- Dirección del auxiliar
  ciudad varchar(20) DEFAULT NULL, -- Ciudad donde reside
  pais varchar(20) DEFAULT NULL, -- País de residencia
  telefono varchar(15) DEFAULT NULL, -- Teléfono de contacto
  correo_electronico varchar(45) DEFAULT NULL, -- Correo electrónico
  fecha_nacimiento date DEFAULT NULL, -- Fecha de nacimiento
  genero varchar(15) DEFAULT NULL, -- Género del auxiliar
  fecha_contratacion date DEFAULT NULL, -- Fecha en que fue contratado
  cargo varchar(50) DEFAULT NULL, -- Cargo desempeñado
  id_odontologo int(11) DEFAULT NULL, -- Relación con el odontólogo al que asiste
  KEY id_odontologo (id_odontologo), -- Índice en la columna id_odontologo
  CONSTRAINT tb_auxiliar_odontologo_fk FOREIGN KEY (id_odontologo) REFERENCES tb_odontologos (id) -- Relación con la tabla de odontólogos
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tabla de citas, que registra las citas programadas para pacientes con odontólogos
CREATE TABLE tb_citas (
  id int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT, -- ID principal, clave primaria auto-incremental
  fecha datetime NOT NULL, -- Fecha y hora de la cita
  paciente_id int(11) NOT NULL, -- Relación con la tabla de pacientes
  odontologo_id int(11) NOT NULL, -- Relación con la tabla de odontólogos
  estado varchar(20) DEFAULT 'Pendiente', -- Estado de la cita
  KEY paciente_id (paciente_id), -- Índice en la columna paciente_id
  KEY odontologo_id (odontologo_id), -- Índice en la columna odontologo_id
  CONSTRAINT tb_citas_paciente_fk FOREIGN KEY (paciente_id) REFERENCES tb_pacientes (id), -- Relación con la tabla de pacientes
  CONSTRAINT tb_citas_odontologo_fk FOREIGN KEY (odontologo_id) REFERENCES tb_odontologos (id) -- Relación con la tabla de odontólogos
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Tabla de agenda, que maneja los horarios y disponibilidad de los odontólogos
CREATE TABLE tb_agenda (
  id int(11) PRIMARY KEY NOT NULL AUTO_INCREMENT, -- ID principal, clave primaria auto-incremental
  fecha date NOT NULL, -- Fecha de la disponibilidad
  hora_inicio time NOT NULL, -- Hora de inicio
  hora_fin time NOT NULL, -- Hora de fin
  id_odontologo int(11) NOT NULL, -- Relación con la tabla de odontólogos
  KEY id_odontologo (id_odontologo), -- Índice en la columna id_odontologo
  CONSTRAINT tb_agenda_odontologo_fk FOREIGN KEY (id_odontologo) REFERENCES tb_odontologos (id) -- Relación con la tabla de odontólogos
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


