App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    channel: "RoomChannel"

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    
    $('#messages').append "<p>#{data}</p>"

  speak: (message)->
    @perform 'speak',message: message
