require 'sinatra'
require File.expand_path('../message', __FILE__)

mess = Array.new
mess << Message.new(0, "很高兴见到你，那家差价按成绩按", "Vincent", Time.new )
mana = Manager.new(mess)

get '/index' do
  erb :index
end

get '/' do
  @mess = mana.message.sort_by { |e| e.craete_at  }
  erb :show
end

post '/' do
  id = params[:id].to_s
  author = params[:author].to_s
  @mess = Array.new
  if id == '' && author == ''
    redirect to ('/')
  elsif id == '' && author != ''
    @mess = mana.search(author)
    erb :show
  else
    mana.message.length.times do |i|
      if mana.message[i].id == id.to_i
        @mess << mana.message[i]
      end
    end
    erb :show
  end

end

get '/add' do
  erb :add
end

post '/add' do
  if params[:message].to_s.length >= 10 && params[:author].to_s != nil
    m = Message.new( 0, params[:message].to_s, params[:author].to_s, Time.new)
    mana.add( m )
    '添加留言成功！<br><a href = "/index">返回</a>'
  else
    '添加留言失败！请确认留言至少包含十个字并且作者名不能为空！<br><a href = "/index">返回</a>'
  end
end

get '/delete/:id' do
  j = -1
  mana.message.length.times do |i|
    mana.message.delete_at(i) if mana.message[i].id == params[:id].to_i
    j = i
  end
  if j == -1
    '此id不存在！<br><a href = "/index">返回</a>'
  else
    '删除成功！<br><a href = "/index">返回</a>'
  end
end

post '/delete/:id' do
  mana.message.length.times do |i|
    if mana.message[i].id == params[:id].to_i
      mana.message.delete_at(i)
    end
  end
  redirect to ('/')
end
