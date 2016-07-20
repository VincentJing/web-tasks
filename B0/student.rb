#!/usr/bin/ruby
require 'yaml'
class Student                #学生类
  attr_accessor :stu_id, :stu_age, :stu_name, :stu_gender        #attr_accessor 自动创建get set方法

   def initialize(id, name, gender, age)
      @stu_id = id
      @stu_name = name
      @stu_gender = gender
      @stu_age = age
   end

   def info()                         #返回学生信息的字符串
     s = format("%03d", @stu_id)
     return s + "  " + @stu_name + "  " + @stu_gender.to_s + "   " + @stu_age.to_s + "\n"
   end

 end


 def newpass( len )          #产生长度为len的随机字符串（小写）的函数
   chars = ("a".."z").to_a
   newpass = ""
   1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
   return newpass
 end

 def add_stu (i)
   puts "请输入学生信息（格式为 name gender age 中间以空格隔开）："
   ar = gets.split
   Student.new(i, ar[0], ar[1].to_i, ar[2].to_i)
 end

 def store_stu (students)                           #存储学生信息函数
   File.open("student.yaml","w") do |io|
   YAML.dump(students,io)
   end
 end

def shoeInfo (students)
  puts "id   name   gender  age "
  students.length.times do |i|
    print students[i].info
  end
end

if File::exists?( "student.yaml" )                                          #若student.yml存在，则将按照文件信息来创建学生对象
  students = YAML.load_file("student.yaml")
else                                        #用循环创建随机学生对象
  students = Array.new
  100.times do |i|
    s_name = newpass(6)
    s_name = s_name.capitalize
    s_age = rand(15..20)
    s_gender = 2031 - s_age
    students[i] = Student.new(i+1, s_name, s_gender, s_age)
  end
  store_stu(students)
end

while 1
  puts "                      学生管理"
  puts "1.添加学生  2.删除学生  3.修改学生   4.查询学生  5.学生排序 0.退出程序"
  puts "请输入操作前面的编号："
  num = gets

  case num.to_i
  when 0
    exit(0)
  when 1

    students.push( add_stu (students[students.length-1].stu_id+1))
    store_stu(students)
  when 2
    j = 0
    puts "请输入要删除学生的id"
    n = gets
    students.length.times do |i|
      if students[i].stu_id == n.to_i
        students.delete_at(i)
        break
      end
      j = i
    end
    if j == students.length-1
      puts "此学生不存在！"
    end
    store_stu(students)

  when 3
    puts "请输入要修改学生的id"
    n = gets
    stu = add_stu(n.to_i)
    students.length.times do |i|
      if students[i].stu_id == n.to_i
        students.delete_at(i)
        students[i] = stu
        break
      end
    end
    store_stu(students)

  when 4
    j = 0
    puts "请输入要查询学生的id"
    n = gets
    students.length.times do |i|
      if students[i].stu_id == n.to_i
        puts "id   name   gender  age "
        puts students[i].info()
        break
      end
      j = i
    end
    if j == students.length-1
      puts "此学生不存在！"
    end
  when 5
    puts "1.Id排序 2.Name排序 3.Age排序（请输入操作前的数字）"
    n = gets
    case n.to_i
    when 1
      students = students.sort_by {|u| u.stu_id}
      shoeInfo(students)
    when 2
      students = students.sort_by {|u| u.stu_name}
      shoeInfo(students)
    when 3
      students = students.sort_by {|u| u.stu_age}
      shoeInfo(students)
    else
      puts "请输入正确的编号"
    end

  else
    puts "请输入正确的编号"
  end
end
