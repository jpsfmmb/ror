class Turma < ActiveRecord::Base
  validates_presence_of :nome, :message => "=> Informe o nome da turma!" 
  validates_length_of :nome, :within => 1..50, :message => "=> nome da turma excede 50 caracteres"

  validates_presence_of :codigo, :message => "=> Informe o codigo da turma!" 
  validates_length_of   :codigo, :within => 0..10, :message => "=> o codigo da turma excede 10 caracteres"

  has_many :aluno_turmas
  has_many :alunos, :through => :aluno_turmas
  has_many :disciplina_professores, :through => :aluno_turmas
end
