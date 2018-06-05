require_relative 'questions_database'


class QuestionLikes
  attr_accessor :id, :question_id, :user_id
  
  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end
  
  def self.find_by_id(id)
    likes = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_likes
    WHERE
      id = ?
   SQL
   
   # return nil unless question.length > 0
   
   QuestionLikes.new(likes.first)
  end
   
  
end