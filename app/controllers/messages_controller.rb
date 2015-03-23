class MessagesController < ApplicationController
  before_action :set_convo, only: [:reply, :show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /messages
  # GET /messages.json
  def index
    # if current_user.admin_check == true
    #   @messages = Message.all
    # else
    @mailbox = current_user.office.mailbox
    # end
  end

  def history
    @revisions = Message.find(params[:id]).revisions
  end

  def close
    @message = Mailboxer::Conversation.find(params[:id])
    @message.update_attribute(:status, "CLOSED")
    redirect_to @message
  end

  def unclose
    @message = Mailboxer::Conversation.find(params[:id])
    @message.update_attribute(:status, "OPEN")
    redirect_to @message
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @convo
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  def reply
    if request.get?
      @message = Message.new
      puts "GET"
    else
      @message = Message.new
      puts "REPLY!!", message_params[:notes_attributes]["0"][:content]
      puts "ATTACH!", attachment=message_params[:notes_attributes]["0"][:attachment]
      puts "current office!", current_user.office.name
      current_user.office.reply_to_conversation(@convo,
                          message_params[:notes_attributes]["0"][:content],
                          attachment=message_params[:notes_attributes]["0"][:attachment])
      redirect_to '/'
    end
    #office = Office.find(message_params[:office])
    #@message.updates(message_params)
    # @revision = Revision.new({
    #   message: @message,
    #   received_from: current_user.office.name,
    #   sent_to: Office.find(message_params[:office]).name
    #   })
    # @revision.save!
    # current_user.send_message(@office, "Some content", message_params[:subject])
  end

  # POST /messages
  # POST /messages.json
  def create
    current_user.office.send_message(Office.find(message_params[:office]),
                              message_params[:notes_attributes]["0"][:content],
                              message_params[:subject],
                              sanitize_text=true,
                              attachment=message_params[:notes_attributes]["0"][:attachment])
    # After sending message, track the revision
    @revision = Revision.new({
      mailboxer_conversation_id: Mailboxer::Conversation.find_by_subject(message_params[:subject]),
      received_from: current_user.office.name,
      sent_to: Office.find(message_params[:office]).name,
      attachment: @attachment,
      time_sent: Time.now
      })
    @revision.save!

    redirect_to '/'
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
  def set_convo
    @convo = Mailboxer::Conversation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def message_params
    params.require(:message).permit(:office, :subject, notes_attributes: [:content, :attachment])
  end

  # def note_params
  #   params.require(:message).permit(:attachment)
  # end
end
