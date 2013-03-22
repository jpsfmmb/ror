class DisciplinasController < ApplicationController

  def index
    list
    render :action => 'list'
  end

  def list
    @disciplinas = Disciplina.paginate :page => params[:page], :per_page => 50, :order => 'nome'
  end

  def show
    @disciplina = Disciplina.find(params[:id])
  end

  def new
    @disciplina = Disciplina.new
  end

  # GET /disciplinas/1/edit
  def edit
    @disciplina = Disciplina.find(params[:id])
  end

  def create
    @disciplina = Disciplina.new(params[:disciplina])
    begin
      @disciplina.save!
      flash[:notice] =  'Registro de disciplina gravado com sucesso.'
      redirect_to :action =>'list'
      #
    rescue Exception => e
         flash[:notice] = "Erro: #{e.message}"
         render :action => 'new'
    end

  end

  def update
    @disciplina = Disciplina.find(params[:id])

    if @disciplina.update_attributes(params[:disciplina])
       flash[:notice] = 'Registro atualizado.'
       redirect_to :action =>'list'
    else
       flash[:notice] = 'Erro atualizando registro.'
       render :action => "edit" 
    end
  end

  def destroy
    begin
      @disciplina = Disciplina.find(params[:id])
      @disciplina.destroy
      redirect_to :action => 'list'
    rescue Exception => e

      # aqui Implementar rotina para personalizar a mensagem vinda do BD (Criar function no application controller)

      flash[:notice] = "Erro: #{e.message}"

      redirect_to :back
    end

  end
end
