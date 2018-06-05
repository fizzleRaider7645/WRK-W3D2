require_relative 'questions_database'


class QuestionFollows
  attr_accessor :id, :user_id, :question_id
  
  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @question_id = options['question_id']
  end
  
  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      question_follows
    WHERE
      id = ?
   SQL
   
   return nil unless question.length > 0
   
   QuestionFollows.new(question.first)
  end
end