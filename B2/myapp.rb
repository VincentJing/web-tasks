require 'sinatra'
require 'active_record'
require 'digest/sha1'
require './model'

use Rack::Session::Pool, expire_after: 3600

before /^(?!\/(login|signup))/ do # 判断用户是否登陆未登录直接跳转到登录界面
  redirect to('/login') if session[:id].nil?
end

get '/login' do # 渲染登陆界面
  erb :login
end

post '/login' do # 登陆判断
  username = params[:username]
  password = Digest::SHA1.hexdigest(params[:password])
  a = User.find_by(username: username)
  if a.nil?
    @login_errors = '用户名不存在！'
    erb :error
  else
    if a.password == password.to_s
      session[:id] = a.id
      redirect to '/'
    else
      @login_errors = '密码错误！'
      erb :error
    end
  end
end

get '/signup' do
  erb :signin
end

post '/signup' do # 注册判断
  @signup_errors = []
  if params[:password] == params[:check_password]
    user = User.create(username: params[:username], password: params[:password])
    if user.errors.any?
      @signup_errors = user.errors.full_messages
      erb :error
    else
      user.password = Digest::SHA1.hexdigest(params[:password])
      user.save
      @signup_success = '注册成功!请登录,两秒后返回登录界面<meta http-equiv="refresh" content="2;url=/">'
      erb :success
    end
  else
    @signup_errors[0] = '两次输入密码不一致，请重新注册'
    erb :error
  end
end

get '/' do
  condition = params[:condition].to_s
  info = params[:info].to_s
  @mess = []
  if info == ''
    @mess = Message.all
  elsif condition == 'id'
    @mess << Message.find_by(id: info.to_i)
  else
    a = User.find_by(username: info.to_s)
    @mess = a.messages unless a.nil?
  end
  if @mess.length > 1
    @mess = @mess.sort_by(&:created_at)
    erb :show
  elsif @mess.length == 1 && !@mess[0].nil?
    erb :show
  else
    @search_errors = '符合条件的留言不存在！'
    erb :error
  end
end

get '/add' do # 新建留言
  erb :add
end

post '/add' do # 对新建留言的内容进行判定
  message = Message.create(content: params[:message].to_s, user_id: session[:id].to_i, created_at: Time.new)
  if message.errors.any?
    @add_errors = message.errors.full_messages[0]
    erb :error
  else
    @add_success = '添加留言成功！<br>两秒后自动返回<meta http-equiv="refresh" content="2;url=/">'
    erb :success
  end
end

get '/delete/:id' do # 按照Id删除留言
  a = Message.find_by(id: params[:id])
  if !a.nil?
    if a.user_id == session[:id]
      Message.delete(params[:id].to_i)
      @delete_success = '删除成功！<br>两秒后自动返回<meta http-equiv="refresh" content="2;url=/myaccount"</center>'
    else
      @delete_errors = '对不起，您不是该留言的作者，您没有权限删除！'
    end
  else
    @delete_errors = '此id不存在！'
  end
end

post '/edit/:id' do # 对主页编辑按钮的响应    对留言内容进行再次编辑
  @message = Message.find(params[:id])
  erb :edit
end

post '/edit' do # 对再次编辑的内容进行判定
  a = Message.find(params[:id])
  a.content = params[:message]
  a.created_at = Time.new
  a.save
  if !a.errors.any?
    @edit_success = '编辑成功！<br>两秒后自动返回<meta http-equiv="refresh" content="2;url=/myaccount">'
    erb :success
  else
    @edit_errors = a.errors.full_messages
    erb :error
  end
end

get '/myaccount' do
  a = User.find(session[:id])
  @mess = a.messages
  @mess = @mess.sort_by(&:created_at)
  erb :myaccount
end

get '/change_password' do
  erb :change_password
end

post '/change_password' do
  @change_password_success = []
  if params[:newpassword] == params[:check_newpassword]
    oldpassword = Digest::SHA1.hexdigest(params[:oldpassword].to_s)
    a = User.find(session[:id])
    if a.password == oldpassword
      a.password = params[:newpassword] # 多此一举后续可以在model中添加对密码的各种验证
      a.save
      if a.errors.any?
        @change_password_errors = a.errors.full_messages
        erb :error
      else
        a.password = Digest::SHA1.hexdigest(params[:newpassword])
        a.save
        session[:id] = nil
        @change_password_success = '修改密码成功！请重新登陆<br>两秒后自动返回登陆界面<meta http-equiv="refresh" content="2;url=/login">'
      end
    else
      @change_password_errors[0] = '原密码不正确！请重新输入'
      erb :error
    end
  end
end

get '/exit' do
  session[:id] = nil
  redirect to '/login'
end

not_found do # 对其他错误访问请求的响应
  '<center>404 您访问的页面不存在！<br>两秒后自动返回主页<meta http-equiv="refresh" content="2;url=/"></center>'
end

after do
  ActiveRecord::Base.connection.close
end
