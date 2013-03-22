class AlunosController < ApplicationController

  auto_complete_for :aluno, :nome,    :limit=> 50

  def index
    list
    render :action => 'list'
  end

  def list
    @alunos = Aluno.paginate :page => params[:page], :per_page => 50, :order => 'nome'
  end

  def show

    @aluno = Aluno.find(params[:id])

  end

  def new
    @aluno = Aluno.new
  end

  def edit
    @aluno = Aluno.find(params[:id])
  end

  def create
    @aluno = Aluno.new(params[:aluno])
    begin
      @aluno.save!
      flash[:notice] =  'Registro de aluno gravado com sucesso.'
      redirect_to :action =>'list'
      #
    rescue Exception => e
         flash[:notice] = "Erro: #{e.message}"
         render :action => 'new'
    end
  end

  def update
    @aluno = Aluno.find(params[:id])

    if @aluno.update_attributes(params[:aluno])
       flash[:notice] = 'Registro atualizado.'
       redirect_to :action =>'list'
    else
       flash[:notice] = 'Erro atualizando registro.'
       render :action => "edit" 
    end
  end

  def destroy
    begin
      @aluno = Aluno.find(params[:id])
      @aluno.destroy
      redirect_to :action => 'list'
    rescue Exception => e
      # aqui Implementar rotina para personalizar a mensagem vinda do BD
      flash[:notice] = "Erro: #{e.message}"
      redirect_to :back
    end

  end


  def list_disciplinas
    @aluno = Aluno.find(params[:aluno_id])
    @disciplinas = AlunoTurma.searchdisciplinas(params[:aluno_id])

  end

  def list_turmas
    @aluno_nome = Aluno.find(params[:aluno_id]).nome
    @turmas = AlunoTurma.searchturmas(params[:aluno_id])
  end

  def search
    pnome = params[:aluno][:nome]
    @alunos = Aluno.paginate :page => params[:page], :per_page => 50,:conditions => ["nome ilike ?","%#{pnome}%"] ,:order => 'nome'

    render :action => 'list'

  end
end
