require 'sinatra'
require 'active_record'
require 'digest/sha1'

ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  host: '127.0.0.1',
  username: 'root',
  password: '123456',
  database: 'MESSAGE'
) # 连接数据库

enable :sessions

class User < ActiveRecord::Base
  has_many :messages
end

class Message < ActiveRecord::Base
  belongs_to :users
  validates_presence_of :content
end

get '/login' do # 渲染登陆界面
  erb :login
end

post '/login' do # 登陆判断
  username = params[:username]
  password = Digest::SHA1.hexdigest(params[:password])
  a = User.find_by_sql("select * from users where username = '#{username}'")
  if a.length == 1 && a[0].password == password.to_s
    session[:id] = a[0].id
    session[:status] = 1
    redirect to '/'
  else
    '<center>用户名或密码错误！请重新登陆<br>两秒后自动返回登陆界面<meta http-equiv="refresh" content="2;url=/login"></center>'
  end
end

get '/signup' do
  erb :signin
end

post '/signup' do # 注册判断
  a = User.find_by_sql("select * from users where username = '#{params[:username]}'")
  if a.length.zero?
    if params[:password].to_s.length >= 4
      user = User.new
      user.username = params[:username]
      user.password = Digest::SHA1.hexdigest(params[:password])
      user.save
      '<center>注册成功！<br>两秒后自动返回登陆界面<meta http-equiv="refresh" content="2;url=/login"></center>'
    else
      '<center>密码太短！<br>两秒后自动返回注册界面请重新注册<meta http-equiv="refresh" content="2;url=/signup"></center>'
    end
  else
    '<center>用户名已存在！<br>两秒后自动返回注册界面请重新注册<meta http-equiv="refresh" content="2;url=/signup"></center>'
  end
end

get '/' do
  check = session[:status].to_i
  if check == 1
    condition = params[:condition].to_s
    info = params[:info].to_s
    @mess = []
    if info == ''
      @mess = Message.find_by_sql 'select * from messages'
    elsif condition == 'id'
      @mess = Message.find_by_sql("select * from messages where id = '#{info.to_i}'")
    else
      a = User.find_by_sql("select * from users where username = '#{info}'")
      @mess = a[0].messages if a.length.nonzero?
    end
    if @mess.length > 1
      @mess = @mess.sort_by(&:created_at)
      erb :show
    elsif @mess.length == 1
      erb :show
    elsif @mess.length.zero?
      '<center>符合条件的留言不存在！<br>两秒后自动返回<meta http-equiv="refresh" content="2;url=/"></center>'
    end
  else
    '<center>您当前未登录！<br>两秒后自动返回登陆界面<meta http-equiv="refresh" content="2;url=/login"></center>'
  end
end

get '/add' do # 新建留言
  check = session[:status].to_i
  if check == 1
    erb :add
  else
    '<center>您当前未登录！<br>两秒后自动返回登陆界面<meta http-equiv="refresh" content="2;url=/login"></center>'
  end
end

post '/add' do # 对新建留言的内容进行判定
  if params[:message].to_s.length >= 10
    message = Message.new
    message.content = params[:message].to_s
    message.user_id = session[:id].to_i
    message.created_at = Time.new
    message.save
    '<center>添加留言成功！<br>两秒后自动返回<meta http-equiv="refresh" content="2;url=/"></center>'
  else
    '<center>添加留言失败，请确认留言字数大于等于10！<br><a href="#" onClick=" javascript :history.back(-1);">重新编辑</a></center>'
  end
end

get '/delete/:id' do # 按照Id删除留言
  check = session[:status].to_i
  if check == 1
    a = Message.find_by_sql("select * from messages where id = '#{params[:id]}'")
    if a.length == 1
      if a[0].user_id == session[:id]
        Message.delete(params[:id].to_i)
        '<center>删除成功！<br>两秒后自动返回<meta http-equiv="refresh" content="2;url=/myaccount"</center>'
      else
        '<center>对不起，您不是该留言的作者，您没有权限删除！<br>两秒后自动返回<meta http-equiv="refresh" content="2;url=/myaccount"</center>'
      end
    else
      '<center>此id不存在！<br>两秒后自动返回<meta http-equiv="refresh" content="2;url=/myaccount"</center>'
    end
  else
    '<center>您当前未登录！<br>两秒后自动返回登陆界面<meta http-equiv="refresh" content="2;url=/login"></center>'
  end
end

post '/edit/:id' do # 对主页编辑按钮的响应    对留言内容进行再次编辑
  @message = Message.find(params[:id])
  erb :edit
end

post '/edit' do # 对再次编辑的内容进行判定
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

get '/myaccount' do
  check = session[:status].to_i
  if check == 1
    a = User.find(session[:id])
    @mess = a.messages
    @mess = @mess.sort_by(&:created_at)
    erb :myaccount
  else
    '<center>您当前未登录！<br>两秒后自动返回登陆界面<meta http-equiv="refresh" content="2;url=/login"></center>'
  end
end

get '/change_password' do
  check = session[:status].to_i
  if check == 1
    erb :change_password
  else
    '<center>您当前未登录！<br>两秒后自动返回登陆界面<meta http-equiv="refresh" content="2;url=/login"></center>'
  end
end

post '/change_password' do
  oldpassword = Digest::SHA1.hexdigest(params[:oldpassword].to_s)
  a = User.find(session[:id])
  if a.password == oldpassword
    a.password = Digest::SHA1.hexdigest(params[:newpassword])
    a.save
    session[:status] = 0
    '<center>修改密码成功！请重新登陆<br>两秒后自动返回登陆界面<meta http-equiv="refresh" content="2;url=/login"></center>'
  else
    '<center>原密码不正确！请重新输入<br>两秒后自动返回<meta http-equiv="refresh" content="2;url=/change_password"></center>'
  end
end

get '/exit' do
  session[:status] = 0
  redirect to '/login'
end

not_found do # 对其他错误访问请求的响应
  '<center>404 您访问的页面不存在！<br>两秒后自动返回主页<meta http-equiv="refresh" content="2;url=/"></center>'
end
