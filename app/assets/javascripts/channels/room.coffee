App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    unless data.krazy_message.blank?
      $('#messages-table').append data.krazy_message
      scroll_bottom()

# On-load function:
$(document).on 'turbolinks:load', ->
  submit_message()
  scroll_bottom()

# Supporting Functions:
submit_message = () ->
  $('#message_content').on 'keydown', (event) ->
    if event.keyCode is 13
      # Select the form and click the submit button
      $('input').click()
      # Clear the message content field
      event.target.value = ''
      # Prevent the default action
      event.preventDefault()

scroll_bottom = () ->
  $('#messages').scrollTop( $('#messages')[0].scrollHeight )
