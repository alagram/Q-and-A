# Database Stucture

1. User  - Devise
    * email: string
    * password: string

    has_many: questions
    has_many: answers

  2. Question
    * user_id: interger
    * title: string
    * body:text
    belongs_to :user
    has_many: answers

  3. Answer
    * body: text
    * user_id: interger
    * question_id: interger

    belongs_to :question
    belongs_to :user
