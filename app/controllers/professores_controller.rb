class ProfessoresController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  def list
    @professores = Professore.paginate :page => params[:page], :per_page => 50, :order => 'nome'
  end

  def show
    @professore = Professore.find(params[:id])
  end

  def new
    @professore = Professore.new
  end

  # GET /professores/1/edit
  def edit
    @professore = Professore.find(params[:id])
  end

  def create
    @professore = Professore.new(params[:professore])
    begin

      @professore.save!
      flash[:notice] =  'Registro de Professor gravado com sucesso.'
      redirect_to :controller=> "disciplina_professores", :action=> "list_profdisciplinas", :id =>@professore
      #
    rescue Exception => e
         flash[:notice] = "Erro: #{e.message}"
         render :action => 'new'
    end
  end
  def update
    @professore = Professore.find(params[:id])

    if @professore.update_attributes(params[:professore])
       flash[:notice] = 'Registro atualizado.'
       redirect_to :action =>'list'
    else
       flash[:notice] = 'Erro atualizando registro.'
       render :action => "edit" 
    end

  end
  def destroy
    begin   
      @professore = Professore.find(params[:id])

      @professore.destroy

      redirect_to :action => 'list'
    rescue Exception => e

      # aqui Implementar rotina para personalizar a mensagem vinda do BD (Criar function no application controller)

      flash[:notice] = "Erro: #{e.message}"

      redirect_to :back
    end

  end

  def destroy_turma

    arrayids = []
    # localiza o id da tabela disciplina_professores

    disciplina_professore_id = DisciplinaProfessore.find(:first,:conditions=>["professore_id = ? and disciplina_id = ?",params[:professore_id],params[:disciplina_id]])

    # localiza os id(s) a ser(em) deletados da tabela aluno_turmas

    arrayids = AlunoTurma.find(:all,:select => ["id"],:conditions=>["disciplina_professore_id = ? and turma_id = ?",disciplina_professore_id,params[:turma_id]]) 

    # chama o método destroy da classe turmas
    
    redirect_to :controller =>'aluno_turmas', :action => 'destroy_fromprofessor', :arrayid=>arrayids,:professore_id => params[:professore_id]
    
  end

  def list_turmas

    @professor = Professore.find(params[:id])

    @turmas = AlunoTurma.searchprofessor(params[:id]) # passa o professor_ID e recebe um array com suas turmas
  end

 end
