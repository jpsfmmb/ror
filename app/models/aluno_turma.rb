class AlunoTurma < ActiveRecord::Base
    validates_presence_of :turma_id, :message => "=> Informe a Turma!" 
    validates_presence_of :aluno_id, :message => "=> Informe o Aluno!" 
    validates_presence_of :disciplina_professore_id, :message => "=> Informe a disciplina!" 

    belongs_to :aluno
    belongs_to :turma
    belongs_to :disciplina_professore
    has_many   :notas

    def self.searchdisciplinas(pfaluno_id)
        # Recebe o Id do Aluno e devolve a lista de turmas_disciplinas do mesmo
        find(:all,
                :include => [:turma,:disciplina_professore],
                :conditions => ["aluno_id = :paluno_id"  ,{:paluno_id => pfaluno_id}],
                :order => 'turma_id')
    end
    def self.searchturmas(pfaluno_id)
        # Recebe o Id do Aluno e devolve a lista de turmas do mesmo
        find(:all,
                :include => [:turma],
                :conditions => ["aluno_id = :paluno_id"  ,{:paluno_id => pfaluno_id}],
                :order => 'turma_id')
    end

    def self.searchprofessor(pfprofessore_id)
        # Recebe o Id do Professor e devolve a lista de turmas do mesmo
        find(:all,
                :include => [:disciplina_professore,:turma],:select => ["select distinct turma_id,disciplina_professores.professore_id"],
                :conditions => ["disciplina_professores.professore_id = :pprofessore_id"  ,{:pprofessore_id => pfprofessore_id}],
                :order => 'turma_id').map {|p|[p.turma_id,p.turma.nome,p.disciplina_professore.disciplina.id,p.disciplina_professore.disciplina.nome]}.uniq

    end

end
