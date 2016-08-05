require 'sinatra'
require 'active_record'

ActiveRecord::Base.establish_connection( :adapter => "mysql2", :host => "127.0.0.1",
:username => "root", :password => "123456", :database => "MESSAGE")    #连接数据库

class User < ActiveRecord::Base
  has_many :messages
end

class Message < ActiveRecord::Base
  belongs_to :users
end

get '/login' do        #渲染登陆界面
  erb :login
end

enable :sessions

post '/login' do                                       #登陆判断
  username = params[:username]
  password = params[:password]
  a = User.find_by_sql("select * from users where username = '#{username}'")
  if a.length == 1 && a[0].password == password.to_s
    session['id'] = a[0].id
    session['username'] = a[0].username
    redirect to ('/')
  else
    redirect to ('/login')
  end
end

get '/signup' do
  erb :signin
end

post '/signup' do                                       #注册判断
  a = User.find_by_sql("select * from users where username = '#{params[:username]}'")
  if a.length == 0
    user = User.new
    user.username = params[:username]
    user.password = params[:password]
    user.save
    '<center>注册成功！<br>两秒后自动返回登陆界面<meta http-equiv="refresh" content="2;url=/login"></center>'
  else
    '<center>用户名已存在！<br>两秒后自动返回注册界面请重新注册<meta http-equiv="refresh" content="2;url=/signup"></center>'
  end

end

get '/' do
  condition = params[:condition].to_s
  info = params[:info].to_s
  @mess = []
  if info == ''
    @mess = Message.find_by_sql ("select * from messages")
    erb :show
  elsif condition == "id"
    @mess << Message.find(info.to_i)
    erb :show
  else
    a = User.find_by_username(info.to_s)
    @mess = a.messages
    erb :show
  end

end

get '/add' do                        #新建留言
  erb :add
end

post '/add' do                                                   #对新建留言的内容进行判定
  if params[:message].to_s.length >= 10
    message = Message.new
    message.content = params[:message].to_s
    message.user_id = session['id'].to_i
    message.created_at = Time.new
    message.save
    '<center>添加留言成功！<br>两秒后自动返回<meta http-equiv="refresh" content="2;url=/"></center>'
  else
    '<center>添加留言失败，请确认留言字数大于等于10！<br><a href="#" onClick=" javascript :history.back(-1);">重新编辑</a></center>'
  end
end

get '/delete/:id' do                          #按照Id删除留言
  if Message.find(params[:id])
    Message.delete(params[:id].to_i)
    '<center>删除成功！<br>两秒后自动返回<meta http-equiv="refresh" content="2;url=/"</center>'
  else
    '<center>此id不存在！<br>两秒后自动返回<meta http-equiv="refresh" content="2;url=/"</center>'
  end
end

post '/edit/:id' do                    #对主页编辑按钮的响应    对留言内容进行再次编辑
  @message = Message.find(params[:id])
  erb :edit
end

post '/edit' do                               #对再次编辑的内容进行判定
  if params[:message].to_s.length >= 10
    a = Message.find(params[:id])
    a.content = params[:message]
    a.created_at = Time.new
    a.save
    '<center>编辑成功！<br>两秒后自动返回<meta http-equiv="refresh" content="2;url=/">'
  else
    '<center>编辑留言失败，请确认留言字数大于等于10！<br><a href="#" onClick=" javascript :history.back(-1);">重新编辑</a></center>'
  end

end

get '/a' do                               #测试表与表之间的关联
  user = User.find_by_username("aa")
  "#{user.id}"
end
