require_relative 'questions_database'


class Question
  attr_accessor :id, :title, :body, :author_id
  
  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end
  
  def self.find_by_id(id)
    question = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
   SQL
   
   return nil unless question.length > 0
   
   Question.new(question.first)
  end
  
  def self.find_by_author_id(author_id)
    question = QuestionsDatabase.instance.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      questions
    WHERE
      author_id = ?
   SQL
   
   
   question.map { |question| Question.new(question) }
   return nil unless question.length > 0
   
  end
  
  def author
    user = QuestionsDatabase.instance.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
      
    SQL
    
    return nil if user.empty?
    User.new(user.first)
  
  end
  
  def replies
    Reply.find_by_question_id(@id)
  end
   
  
end