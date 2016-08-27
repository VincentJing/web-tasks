# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(name: 'admin', password: 'admin')
p '管理员生成完毕'

Category.create(title: '编程')
Category.create(title: '经济')
Category.create(title: '哲学')
Category.create(title: '人生')
p '分类生成完毕'

def newpass(len) # 产生长度为len的随机字符串（小写）的函数
  chars = ('a'..'z').to_a
  newpass = ''
  1.upto(len) { |_i| newpass << chars[rand(chars.size - 1)] }
  newpass
end

Category.all.each do |i|
  20.times do
    i.posts.create(title: newpass(10), content: newpass(200))
  end
end
p '文章生成完毕'

Post.all.each do |i|
  10.times do
    i.comments.create(email: 'jingzf0214@gamil.com', content: newpass(30), status: false)
  end
end
p '评论生成完毕'
