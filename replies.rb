require_relative 'questions_database'


class Reply
  attr_accessor :id, :question_id, :parent_reply_id, :user_id, :body
  
  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @parent_reply_id = options['parent_reply_id']
    @user_id = options['user_id']
    @body = options['body']
  end
  
  def self.find_by_id(id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      id = ?
   SQL
   
   # return nil unless question.length > 0
   
   Reply.new(reply.first)
  end
  
  def self.find_by_user_id(user_id)
    reply = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      replies
    WHERE
      user_id = ?
   SQL
   
   Reply.new(reply.first)
  end
  
  
  def self.find_by_question_id(question_id)
    returned_replies = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      replies
    WHERE
      question_id = ?
   SQL
  
   returned_replies.map { |reply| Reply.new(reply) }
   return nil unless returned_replies.length > 0
  end
  
  def author
    author = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
    users
    WHERE
      id = ?
    SQL
    User.new(author.first)
  end
  
  def question
    question = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    
    SELECT 
      *
    FROM
      questions
    WHERE
      id = ?
      
    SQL
    Question.new(question.first)
  end
  
  def parent_reply
    parent_reply = QuestionsDatabase.instance.execute(<<-SQL, parent_reply_id)
    
    SELECT
      *
    FROM 
      replies
    WHERE
      id = ?
      
    SQL
    
    Reply.new(parent_reply.first)
  end
  
  def child_replies
    reply = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
    replies
    WHERE
    parent_reply_id = ?
    SQL
    Reply.new(reply.first)
  end
  
end