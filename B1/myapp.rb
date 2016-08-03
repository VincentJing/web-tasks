require 'sinatra'
require File.expand_path('../message', __FILE__)

def newpass( len )          #产生长度为len的随机字符串（小写）的函数
  chars = ("a".."z").to_a
  newpass = ""
  1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
  return newpass
end


mess = []
12.times do |i|                                          #随机产生12个留言类对象
  m = newpass(6).capitalize
  mess << Message.new(i, newpass(12), m)
end

mana = Manager.new(mess)

get '/' do
  condition = params[:condition].to_s
  info = params[:info].to_s
  @mess = mana.message.sort_by { |e| e.created_at  }
  if info == ''
    erb :show
  elsif condition == "id"
    @mess = mana.search_id(info.to_i)
    erb :show
  else
    @mess = mana.search_author(info)
    erb :show
  end                                           #主页  按照创建时间倒序输出留言

end

enable :sessions

get '/add' do                        #新建留言
  @message = ''
  @author = ''
  erb :add
end

post '/add' do                                                   #对新建留言的内容进行判定
  if params[:message].to_s.length >= 10 && params[:author].to_s != ''
    m = Message.new( 0, params[:message].to_s, params[:author].to_s)
    mana.add( m )
    '<center>添加留言成功！<br>两秒后自动返回<meta http-equiv="refresh" content="2;url=/"></center>'

  else
    session['message'] = params[:message].to_s
    session['author'] = params[:author].to_s
    '<center>添加留言失败，请确认留言字数大于等于10且作者不为空！<br>两秒后自动返回编辑页面，请重新编辑<meta http-equiv="refresh" content="2;url=/fail_to_add">
    </center>'
  end
end

get '/fail_to_add' do                            #对于不符合条件的留言进行重新编辑
  @message = session['message']
  @author = session['author']
  erb :add
end

get '/delete/:id' do                          #按照Id删除留言
  j = -1
  mana.message.each do |i|
    if i.id == params[:id].to_i
      j = i.id
      mana.message.delete(i)
    end
  end
  if j == -1
    '<center>此id不存在！<br>两秒后自动返回<meta http-equiv="refresh" content="2;url=/"</center>'
  else
    '<center>删除成功！<br>两秒后自动返回<meta http-equiv="refresh" content="2;url=/"</center>'
  end
end


post '/edit/:id' do                    #对主页编辑按钮的响应    对留言内容进行再次编辑
  @message = ''
  @author =  ''
  @id = 0
  mana.message.each do |i|
    if i.id == params[:id].to_i
      @message = i.message
      @author = i.author
      @id = i.id
    end
  end
  erb :edit
end

post '/edit' do                               #对再次编辑的内容进行判定
  if params[:message].to_s.length >= 10 && params[:author].to_s != ''
    mana.message.each do |i|
      if i.id == params[:id].to_i
        i.author = params[:author].to_s
        i.message = params[:message].to_s
        i.craeted_at = Time.new
      end
    end
  '<center>编辑成功！<br>两秒后自动返回<meta http-equiv="refresh" content="2;url=/">'
  else
    session['message'] = params[:message].to_s
    session['author'] = params[:author].to_s
    session['id'] = params[:id]
    '<center>添加留言失败，请确认留言字数大于等于10且作者不为空！<br>两秒后自动返回请重新编辑<meta http-equiv="refresh" content="2;url=/fail_to_edit"></center>'
  end

end

get '/fail_to_edit' do                       #判定不通过时重新编辑
  @message = session['message']
  @author = session['author']
  @id = session['id'].to_i
  erb :edit
end

not_found do              #对其他错误访问请求的响应
  '<center>404 您访问的页面不存在！<br>两秒后自动返回主页<meta http-equiv="refresh" content="2;url=/"></center>'
end
