class AlunoTurmasController < ApplicationController

  def index
    list
    render :action => 'list',:id => 1 # Defaults 
  end

  def list # Recebe o Id da Turma e devolve a lista de alunos da mesma.
    @turma  = Turma.find(params[:id])

    @aluno_turmas = AlunoTurma.paginate :page => params[:page], :per_page => 50,:order => "turma_id",  :include=> [:disciplina_professore,:aluno], :conditions => ["aluno_id in (select aluno_id from aluno_turmas where turma_id = ? ) and turma_id = ? ",params[:id],params[:id]]

  end

  def new

    @turma  = Turma.find(params[:aluno_turma][:turma_id]) 
    @aluno  = Aluno.find(params[:aluno_turma][:aluno_id])

    @disciplina_professores = DisciplinaProfessore.paginate :page => params[:page], :per_page => 50,:include => [:disciplina, :professore], :conditions => [" id not in (select disciplina_professore_id from aluno_turmas where turma_id = ? and aluno_id= ? )",params[:aluno_turma][:turma_id],params[:aluno_turma][:aluno_id]]

    @aluno_turmas = AlunoTurma.new
    @empty= "Todas as 'Disciplinas' <br/> já estão vinculados ao aluno: #{@aluno.nome << ' na Turma ' << @turma.nome}<br/>" if @disciplina_professores == []
  end

  def newfromaluno

    @aluno  = Aluno.find(params[:aluno_id])

    @disciplina_professores = DisciplinaProfessore.paginate :page => params[:page], :per_page => 50,:include => [:disciplina, :professore], :conditions => [" id not in (select disciplina_professore_id from aluno_turmas where aluno_id= ? )",params[:aluno_id]]

    @turmas = Turma.find(:all,:select => ["id,nome"],:order =>'nome')
    @aluno_turmas = AlunoTurma.new
    @empty= "Todas as 'Disciplinas' <br/> já estão vinculados a(o) aluno(a): #{@aluno.nome}<br/>" if @disciplina_professores == []
  end


  def edit
    @aluno_turma = AlunoTurma.find(params[:id])
  end

  def create
    #
    # recebe as disciplinas/professor como um array no parametro disciplina_professore[disciplina_id]
    #
    bdeuerro = false
    mens     = ''
    #
    if params.include?("disciplina_professore") then 
       params[:disciplina_professore][:disciplina_id].each do |item|

         aluno_turma = AlunoTurma.new
 
         aluno_turma.turma_id = params[:aluno_turma][:turma_id]
         aluno_turma.aluno_id = params[:aluno_id] #
         aluno_turma.disciplina_professore_id = item.to_i # disciplina_professore_id
         begin
           aluno_turma.save!
         rescue Exception => exc
           bdeuerro = true
           mens << exc
         end
      end # params
    else
      bdeuerro = true
      mens = 'Selecione uma disciplina'
    end # if
    if not bdeuerro then
       flash[:notice] = 'Aluno/Disciplinas vinculados a turma com sucesso!'
       redirect_to :action => 'list', :id => params[:aluno_turma][:turma_id]
    else
       flash[:notice] = "Erro ao tentar gravar registro. Erro: #{mens}"
       redirect_to :back
    end
  end

  def update
    @aluno_turma = AlunoTurma.find(params[:id])
  end

  def destroy

    begin

      turma_id = AlunoTurma.find(params[:id]).turma_id

      AlunoTurma.find(params[:id]).destroy

      redirect_to :action => 'list', :id => turma_id # renderiza a lista de alunos da turma, atualizada.

    rescue Exception => e

      # aqui Implementar rotina para personalizar a mensagem vinda do BD (Criar function no application controller)

     #   rescue ActiveRecord::RecordNotSaved
         flash[:notice] = "Erro: #{e.message}"
         redirect_to :back
    end

  end

  def destroy_fromprofessor

     #recebe no param[:arrayid] a lista do(s) id(s) a ser(em) deletado(s)

     params[:arrayid].each do |item|

        AlunoTurma.find(item).destroy

     end

     redirect_to :controller => 'professores',:action => 'list_turmas', :id => params[:professore_id] # exibe a lista de turmas do professor, atualizada.
 
 
  end

  def pedeturma

    if params[:turma_id]

       @turmas   = Turma.find(params[:turma_id]).to_a

    else
       @turmas  = Turma.find(:all,:order => 'nome')
    end

    @alunos = Aluno.find(:all,:order => 'nome')

  end 
end
