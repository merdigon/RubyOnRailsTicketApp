class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = current_user.tickets
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    @ticketsToGenerate = 1
    @events = Event.all
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    ticket_params = params.require(:ticket).permit(:name, :address,
    :price, :email_address, :phone, :event_id, :places_limit, :seat_id_seq, :user_id, :ticketsToGenerate)
    event = Event.find(ticket_params[:event_id])
    user = User.find(ticket_params[:user_id])
    respond_to do |format|
      numberOfTickets = ticket_params[:ticketsToGenerate]
      logger.debug "Ilość biletów: " + numberOfTickets
      ticketsToUse = numberOfTickets.to_f + event.tickets.count  
      if ticketsToUse <= event.places_limit
        for i in 1..(numberOfTickets.to_f)
          @ticket = Ticket.new(ticket_params.except(:ticketsToGenerate))
          @ticket.price = event.price_low
          @ticket.seat_id_seq = event.tickets.count + 1
          if !@ticket.save
            format.html { render :new }
            format.json { render json: @ticket.errors, status: :unprocessable_entity }
          end
        end
        format.html { redirect_to event, notice: 'Tickets were successfully created.' }
        format.json { render :show, status: :created, location: event }
      end      
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:name, :seat_id_seq, :address, :price, :email_address, :phone)
    end

    def correct_user
      @ticket = current_user.tickets.find_by(id: params[:id])
      redirect_to tickets_path, notice: "Nie jesteś uprawniony do edycji tego biletu" if @ticket.nil?
    end
end
