class Nota < ActiveRecord::Base

   validates_presence_of :periodo, :message => "=> Informe o periodo da nota!" 
   validates_presence_of :seqnota, :message => "=> Informe a sequencia da nota no periodo" 
   validates_presence_of :nota,    :message => "=> Informe a Nota" 

   validates_numericality_of :periodo,:seqnota, :nota


   belongs_to :aluno_turma

end
