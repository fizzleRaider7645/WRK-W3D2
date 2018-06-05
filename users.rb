require_relative 'questions_database'


class User
  attr_accessor :id, :fname, :lname
  
  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

   
  def self.find_by_name(fname, lname)
    person = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND lname = ?
    
      SQL
      return nil unless person.length > 0
    User.new(person.first)
  end
  
  
  def self.find_by_id(id)
    person = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
   SQL
   
   User.new(person.first)
  end
  
  def self.find_by_name(fname, lname)
    person = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND lname = ?
   SQL
   
   person.map{ |person| User.new(person) }
   return nil unless person.length > 0
  end
  
  def authored_questions
    Question.find_by_author_id(@id)
  end
  
  def authored_replies
    Reply.find_by_user_id(@id)
  end
end