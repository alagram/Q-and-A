class QuestionsChannel < ApplicationCable::Channel
  def follow(data)
    stream_from "questions:#{data['question_id']}"
  end

  def unfollow
    stop_all_streams
  end
end
