class MessagesController < ApplicationController
  before_action :logged_in_user
  before_action :get_messages

  def index
  end

  def create
    message = current_user.messages.build(message_params)
    if message.save
      ActionCable.server.broadcast 'room_channel', krazy_message: render_message(message)

      message.mentions.each do |mention|
        ActionCable.server.broadcast "room_channel_user_#{mention[:mentionee].id}",
                                     mention: true, mentioner: mention[:mentioner].username
      end
    end
  end

  private

  def get_messages
    @messages = Message.for_display
    @message  = current_user.messages.build
  end

  def message_params
    params.require(:message).permit(:content)
  end

  def render_message(message)
    render(partial: 'message', locals: { message: message })
  end
end
