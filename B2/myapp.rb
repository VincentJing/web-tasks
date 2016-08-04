require 'sinatra'
require 'active_record'

ActiveRecord::Base.establish_connection( :adapter => "mysql2", :host => "127.0.0.1",
:username => "root", :password => "123456", :database => "MESSAGE")    #连接数据库

class User < ActiveRecord::Base
end

class Message < ActiveRecord::Base
end

get '/login' do        #渲染登陆界面
  erb :login
end

enable :sessions

post '/login' do
  username = params[:username]
  password = params[:password]
  a = User.find_by_sql("select * from users where username = '#{username}'")
  if a.length == 1 && a[0].password == password.to_s
    session['id'] = a[0].id
    redirect to ('/')
  else
    redirect to ('/login')
  end
end

get '/signup' do
  erb :signin
end

post '/signup' do
  user = User.new
  user.username = params[:username]
  user.password = params[:password]
  user.save
  '<center>注册成功！<br>两秒后自动返回登陆界面<meta http-equiv="refresh" content="2;url=/login"></center>'
end

get '/' do
  'aaaaaaaaaaaaaaaaaaaaaa'
end
