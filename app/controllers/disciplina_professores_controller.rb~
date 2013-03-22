class DisciplinaProfessoresController < ApplicationController

  def index
    list_profdisciplinas
    render :action => 'list_profdisciplinas',:id => 1 # Defaults 
  end

  def list_profdisciplinas # Recebe o Id do Professor e devolve a lista de Disciplinas ministradas pelo mesmo.

    @professore  = Professore.find(params[:id])

    @disciplina_professores = DisciplinaProfessore.paginate :page => params[:page], :per_page => 50,:order => "disciplina_id",  :include=> [:disciplina], :conditions => ["professore_id in (select professore_id from disciplina_professores where professore_id = ? ) and professore_id = ? ",params[:id],params[:id]]

  end
 
  def list_discprofessores # Recebe o Id da Disciplina e devolve a lista de Professores da mesma.

      @disciplina  = Disciplina.find(params[:id])

      @disciplina_pages, @disciplinas = paginate :disciplinas, :select => ["id,nome,titulo"],:conditions => ["id in (select professor_id from disciplina_professore)"],:per_page => 40

  end

  def show
    @disciplina_professore = DisciplinaProfessore.find(params[:id])
  end

  def new
    # Nova Disciplina ministrada pelo Professor
    @disciplinas = Disciplina.paginate :page => params[:page], :per_page => 50,:order => "nome",:select => ["id,nome,cargahoraria"], :conditions => ["id not in (select disciplina_id from disciplina_professores where professore_id = ? )",params[:id]]

    @professore  = Professore.find(params[:id])
    
    @disciplina_professore = DisciplinaProfessore.new

    @empty= "Todas as 'Disciplinas' <br/> já estão habilitadas para o professor: #{@professore.nome}<br/>" if @disciplinas== []

  end

  def edit
    @disciplina_professore = DisciplinaProfessore.find(params[:id])
  end

  def create
    # receber as disciplinas selecionadas como um array no parametro [:disciplina_professore][:disciplina_id]
    #
    bdeuerro = false
    mens     = ''
    #
    if params.include?("disciplina_professore") then 

       params[:disciplina_professore][:disciplina_id].each do |item|

         prof_disciplina =  DisciplinaProfessore.new
         prof_disciplina.professore_id = params[:professore_id]
         prof_disciplina.disciplina_id = item.to_i # disciplina_id
         begin
           prof_disciplina.save!
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
       flash[:notice] = 'Disciplinas vinculados ao professor com sucesso!'
       redirect_to :action => 'list_profdisciplinas', :id => params[:professore_id]
    else
       flash[:notice] = "Erro ao tentar gravar registro. Erro: #{mens}"
       redirect_to :back
    end
  end # create

  def destroy

    begin

      prof_id = DisciplinaProfessore.find(params[:id]).professore_id # Professor_id 

      DisciplinaProfessore.find(params[:id]).destroy

      redirect_to :action => 'list_profdisciplinas', :id => prof_id # renderiza a lista de disciplinas do professor atualizada.

    rescue Exception => e

      # aqui Implementar rotina para personalizar a mensagem vinda do BD (Criar function no application controller)

      flash[:notice] = "Erro: #{e.message}"

      redirect_to :back
    end

  end

end
