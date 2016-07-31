require 'sinatra'
require File.expand_path('../message', __FILE__)

mess = Array.new
mess << Message.new(0, "Vincent", "很高兴见到你，那家差价按成绩按", Time.new )
mana = Manager.new(mess)

get '/index' do
  erb :index
end

get '/' do
  @mess = mana.message.sort_by { |e| e.craete_at  }
  erb :show
end

post '/' do
  'aa'
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

end
