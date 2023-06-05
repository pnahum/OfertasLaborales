class OffersController < ApplicationController
  before_action :set_offer, only: %i[ show edit update destroy ]
  before_action :set_post, only: %i[ show index create]
  before_action :authenticate_user!, except: [:welcome]
  before_action only: [:new, :edit, :destroy] do	# create debe permitirse a los ergistrados para poder postular.
        authorize_request(["admin"])			# Se filtra a la entrada de save para los offers si no es admin
  end							# Se permite a los registrados solo save de posts


  def welcome
    if user_signed_in?		# Para forzar que si hay usuario que haya quedado conectado
      sign_out(current_user)	# de la ultima conexion, se desconecte
    end
  end
  # GET /offers or /offers.json
  def index
    @offers = Offer.all
    if user_signed_in?
      @post.user_id = current_user.id
    end
    post_offer_id = ""
#    @post.offer_id = offer.id
#    puts "el usuario tiene rol: #{current_user.role}"
  end

  # GET /offers/1 or /offers/1.json
  def show
  end

  # GET /offers/new
  def new
    @offer = Offer.new
  end

  # GET /offers/1/edit
  def edit
  end

  # POST /offers or /offers.json
  def create
     @offer = Offer.new(offer_params)
     respond_to do |format|
     # Proceso de save para los ofertas laborales (offers)
     if (!@offer.name.blank? and !@offer.description.blank?) and (current_user.role == "admin")	# Solo crea en DB si ambos existen y si es el admin
      if @offer.save
        format.html { redirect_to offer_url(@offer), notice: "Offer was successfully created." }
        format.json { render :show, status: :created, location: @offer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
     else
        format.html { redirect_to root_path, notice: "", status: :unprocessable_entity }
     end 

     # Proceso de offers para las postulacaiones (Posts)
     @post.user_id = current_user.id
     @post.offer_id = params[:offer][:id]	#params[:offer][:id] trae el offer.id desde vista
     if (!@post.user_id.blank? and !@post.offer_id.blank?)	# Solo crea en DB si ambos existen
      if @post.save
	UserMailer.notification_email.deliver_now!	# Envio de correo a Esteban con destinatario fake
        format.html { redirect_to offer_url(@offer), notice: "Post was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity, notice: "Tu Postulacion no pudo ser procesada. Talvez ya estas inscrito" }
      end
     else
        format.html { redirect_to root_path, notice: "", status: :unprocessable_entity }
#        format.html { status: :unprocessable_entity }
     end        #fin verificacion nil o blank de variable post

    end		#fin format
  end		#fin method create

  # PATCH/PUT /offers/1 or /offers/1.json
  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to offer_url(@offer), notice: "Offer was successfully updated." }
        format.json { render :show, status: :ok, location: @offer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1 or /offers/1.json
  def destroy
    @offer.destroy

    respond_to do |format|
      format.html { redirect_to offers_url, notice: "Offer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
      @offer_new = Offer.new
    end

    def set_post
      @post = Post.new
    end

    # Only allow a list of trusted parameters through.
    def offer_params
      params.require(:offer).permit(:id, :name, :description, posts_attributes: [:id, :user_id, :offer_id,])
    end
end
