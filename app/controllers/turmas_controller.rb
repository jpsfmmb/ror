class TurmasController < ApplicationController

  def index
    list
    render :action => 'list'
  end

  def list
    @turmas = Turma.paginate :page => params[:page], :per_page => 50, :order => 'nome'
  end

  def show
    @turma = Turma.find(params[:id])
  end

  def new
    @turma = Turma.new
  end

  def edit
    @turma = Turma.find(params[:id])
  end

  def create
    @turma = Turma.new(params[:turma])

    begin
      @turma.save!
      flash[:notice] =  'Registro de turma gravado com sucesso.'
      redirect_to :action =>'list'
      #
    rescue Exception => e
         flash[:notice] = "Erro: #{e.message}"
         render :action => 'new'
    end
  end

  def update
    @turma = Turma.find(params[:id])
    if @turma.update_attributes(params[:turma])
       flash[:notice] = 'Registro atualizado.'
       redirect_to :action =>'list'
    else
       flash[:notice] = 'Erro atualizando registro.'
       render :action => "edit" 
    end
  end

  def destroy
    begin
      @turma = Turma.find(params[:id])
      @turma.destroy
      redirect_to :action => 'list'
    rescue Exception => e

      flash[:notice] = "Erro: #{e.message}"
      redirect_to :back
    end
 
 end
end
