CREATE DATABASE escola_development
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'pt_BR.UTF-8'
       LC_CTYPE = 'pt_BR.UTF-8'
       CONNECTION LIMIT = -1;

CREATE TABLE alunos
(
  id serial NOT NULL,
  nome character varying(50) NOT NULL,
  dtnascimento date NOT NULL,
  serie character varying(10),
  dtmatricula date,
  mae character varying(50) NOT NULL,
  created_on timestamp with time zone,
  updated_on timestamp with time zone,
  CONSTRAINT pk_alunos PRIMARY KEY (id ),
  CONSTRAINT uk_Alunos UNIQUE (nome , dtnascimento , mae )
)
WITH (
  OIDS=FALSE
);
--drop table professores cascade;
CREATE TABLE professores
(
  id serial NOT NULL,
  nome character varying(50) NOT NULL,
  titulo character varying(50),
  dtadmissao date NOT NULL,
  cpf character varying(11) NOT NULL,
  created_on timestamp with time zone,
  updated_on timestamp with time zone,
  CONSTRAINT pk_professores PRIMARY KEY (id ),
  CONSTRAINT uk_Professores UNIQUE (cpf )
)
WITH (
  OIDS=FALSE
);

CREATE TABLE turmas
(
  id serial NOT NULL,
  nome character varying(50) NOT NULL,
  codigo character varying(10),
  created_on timestamp with time zone,
  updated_on timestamp with time zone,
  CONSTRAINT pk_turmas PRIMARY KEY (id ),
  CONSTRAINT uk_turmas UNIQUE (codigo )
)
WITH (
  OIDS=FALSE
);

CREATE TABLE disciplinas
(
  id serial NOT NULL,
  nome character varying(50) NOT NULL,
  cargahoraria numeric(6,2) NOT NULL DEFAULT 0,
  created_on timestamp with time zone,
  updated_on timestamp with time zone,
  CONSTRAINT pk_materias PRIMARY KEY (id ),
  CONSTRAINT uk_disciplinas UNIQUE (nome )
)
WITH (
  OIDS=FALSE
);

CREATE TABLE disciplina_professores
(
  id serial NOT NULL,
  disciplina_id integer NOT NULL,
  professore_id integer NOT NULL,
  created_on timestamp with time zone,
  updated_on timestamp with time zone,
  CONSTRAINT pk_disciplina_professores PRIMARY KEY (id ),
  CONSTRAINT fk_disciplinaProf_professor FOREIGN KEY (professore_id)
      REFERENCES professores (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_disciplinaprof_discplina FOREIGN KEY (disciplina_id)
      REFERENCES disciplinas (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT uk_disciplinaProf UNIQUE (disciplina_id , professore_id )
)
WITH (
  OIDS=FALSE
);


CREATE TABLE aluno_turmas
(
  id serial NOT NULL,
  aluno_id integer NOT NULL,
  turma_id integer NOT NULL,
  disciplina_professore_id integer NOT NULL,
  created_on timestamp with time zone,
  updated_on timestamp with time zone,
  CONSTRAINT pk_aluno_turmas PRIMARY KEY (id ),
  CONSTRAINT fn_alunoTurmas_DiscpProf FOREIGN KEY (disciplina_professore_id)
      REFERENCES disciplina_professores (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_alunoTurmas_Turmas FOREIGN KEY (turma_id)
      REFERENCES turmas (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fm_alunosTurma_Alunos FOREIGN KEY (aluno_id)
      REFERENCES alunos (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT uk_alunoTurmas UNIQUE (aluno_id , turma_id , disciplina_professore_id )
)
WITH (
  OIDS=FALSE
);

CREATE TABLE notas
(
  id serial NOT NULL,
  aluno_turma_id integer NOT NULL,
  periodo integer NOT NULL DEFAULT 0,
  seqnota integer NOT NULL DEFAULT 0,
  nota numeric(6,2) NOT NULL DEFAULT 0,
  created_on timestamp with time zone,
  updated_on timestamp with time zone,
  lock_version integer,
  CONSTRAINT pk_notas PRIMARY KEY (id ),
  CONSTRAINT fk_notas FOREIGN KEY (aluno_turma_id)
      REFERENCES aluno_turmas (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT uk_notas UNIQUE (aluno_turma_id , periodo , seqnota ),
  CONSTRAINT valida_nota CHECK (nota >= 0::numeric AND nota <= 10::numeric),
  CONSTRAINT valida_periodo CHECK (periodo > 0),
  CONSTRAINT valida_seqnota CHECK (seqnota > 0)
)
WITH (
  OIDS=FALSE
);


