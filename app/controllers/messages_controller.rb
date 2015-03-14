class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /messages
  # GET /messages.json
  def index
    if current_user.admin_check == true
      @messages = Message.all
    else
      @messages = current_user.mailbox.inbox
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = Message.find(params[:id])
    puts @message, @message.notes
    @message
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  def forward
    @message = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.json
  def create
    # puts "MEssage PArams:", message_params
    # office = Office.find_by_name(params[:office])
    # puts "Office:", office
    puts message_params
    puts "WHAT IS WRONG WITCHU", message_params[:attachment]

    @message = Message.new({
      received_from: current_user.office.name,
      office: Office.find(message_params[:office]), 
      subject: message_params[:subject]
    })

    # uploader = AttacherUploader.new
    # uploader.store!(message_params[:attachment])

    @note = Note.new(
      {
        user: current_user,
        message: @message,
        content: message_params[:notes_attributes]["0"][:content]
      }
    )
    @note.save

    message_params[:notes_attributes]["0"][:attachment].each do |raw|
      @attachment = Attachment.new({note: @note})
      @attachment.file = raw
      @attachment.save!
    end

    current_user.send_message(current_user, "Some content", message_params[:subject])
    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_message
    @message = Message.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:office, :subject, notes_attributes: [:content, :attachment=>[]])
  end

  # def note_params
  #   params.require(:message).permit(:attachment)
  # end
end
