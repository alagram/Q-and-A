$(document).on 'turbolinks:load', ->
  if App.questions
    App.questions.followVisibleQuestions()
App.questions = App.cable.subscriptions.create "QuestionsChannel",
  collection: -> $('.question-box')

  connected: ->
    setTimeout =>
      @followVisibleQuestions()
    , 1000

  followVisibleQuestions: ->
    questions = @collection().map(-> $(@).attr('data-question')).get()
    if questions.length > 0
      for question in questions
        @perform 'follow', question_id: question
    else
      @perform 'unfollow'

  disconnected: ->
    @perform 'unfollow'

  received: (data) ->
    console.log "[ActionCable] [Question] [#{data.id}] [#{data.action}]", data
    box = $(".question-box[data-question='#{data.id}']")
    if box
      box.find('.box-body').first().replaceWith(data.html)
