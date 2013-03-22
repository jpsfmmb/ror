class Disciplina < ActiveRecord::Base
  validates_presence_of :nome, :message => "=> Informe o nome da disciplina!" 
  validates_length_of :nome, :within => 1..50, :message => "=> o nome excede 50 caracteres"

  validates_numericality_of  :cargahoraria, :message => "=> Informe um numero valido !" 
 
  has_many :disciplina_professores
  has_many :professores, :through => :disciplina_professores

end
