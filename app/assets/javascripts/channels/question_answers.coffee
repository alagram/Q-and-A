$(document).on 'turbolinks:load', ->
  if App.questionAnswers
    App.questionAnswers.followQuestionAnswers()
App.questionAnswers = App.cable.subscriptions.create "QuestionAnswersChannel",
  box: -> $('#answers-container')

  connected: ->
    setTimeout =>
      @followQuestionAnswers()
    , 1000

  followQuestionAnswers: ->
    if @box().length > 0
      @perform 'follow', question_id: window.location.pathname.split("/")[2]
    else
      @perform 'unfollow'

  disconnected: ->
    @perform 'unfollow'

  received: (data) ->
    @box().replaceWith(data.html)
