class Message         #留言类

  attr_accessor :id, :message, :author, :created_at

  def initialize(id, message, author)
     @id = id
     @message = message
     @author = author
     @created_at = Time.new
  end

end

class Manager                   #留言管理类

  attr_accessor :message

  def initialize (message)
    @message = message
  end

  def add (mes)              #增加留言，返回留言的id
    if @message.length == 0
      @message << mes
    else
      id = @message[@message.length-1].id
      mes.id = id + 1
      @message << mes
    end
    mes.id
  end

  def search_id (id)
    arr = []
    @message.each do |i|
      if i.id == id.to_i
        arr << i
      end
    end
    arr
  end

  def search_author (author)
    arr = []
    @message.each do |i|
      if i.author == author
        arr << i
      end
    end
    arr
  end
end
