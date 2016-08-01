class Message

  attr_accessor :id, :message, :author, :craete_at

  def initialize(id, message, author, craete_at)
     @id = id
     @message = message
     @author = author
     @craete_at = craete_at
  end

end

class Manager

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

  def delete (id)     #删除id数组的留言，返回成功删除的留言条数
    count = 0
    id.length.times do |i|
      @message.length.times do |j|
        if @message[j].id == id[i]
          @message.delete_at(j)
          count += 1
        end
      end
    end
    count
  end

  def searchId (id)
    arr = Array.new
    @message.length.times do |i|
      if @message[i].id == id.to_i
        arr << @message[i]
      end
    end
    arr
  end

  def search (author)
    arr = Array.new
    @message.each do |i|
      if i.author == author
        arr << i
      end
    end
    arr
  end

end
