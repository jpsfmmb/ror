class Professore < ActiveRecord::Base
   validates_presence_of :nome, :message => "=> Informe o nome do professor!" 
   validates_length_of :nome, :within => 1..50, :message => "=> nome excede 50 caracteres"

   validates_presence_of :dtadmissao, :message => "=> Informe a data de admissao do professor!" 

   validates_presence_of :cpf, :message => "=> Informe o CPF do Professor!" 
   validates_length_of :cpf, :within => 1..11, :message => "=> CPF excede 11 caracteres"

   has_many :disciplina_professores
 
   has_many :disciplinas, :through => :disciplina_professores
  
   has_many :aluno_turmas
   has_many :alunos, :through => :aluno_turmas
   has_many :turmas, :through => :aluno_turmas



end
