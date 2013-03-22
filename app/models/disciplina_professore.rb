class DisciplinaProfessore < ActiveRecord::Base

  belongs_to :disciplina
  belongs_to :professore
  belongs_to :aluno_turma

end
