#!/usr/bin/ruby

class Student                                #学生类
   def initialize(id, name, gender, age)
      @stu_id=id
      @stu_name=name
      @stu_gender=gender
      @stu_age=age
   end

   def getStu_id
     return @stu_id
   end

   def display_details()
      print "Student id #@stu_id  "
      print "name #@stu_name  "
      print "gender #@stu_gender  "
      puts "age #@stu_age"
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

 def add_stu
   puts "请输入学生信息（格式为 id name gender age 中间以空格隔开）："
   ar = gets.split
   st = Student.new(ar[0].to_i, ar[1], ar[2].to_i, ar[3].to_i)
   return st
 end

 def store_stu (students)                           #存储学生信息函数
   aFile = File.new("student.yml", "w+")
   aFile.syswrite("id   name   gender  age \n")
   j = 1
   while j <= students.length
     aFile.syswrite(students[j-1].info())
     j += 1
   end
   aFile.close
 end
i = 1
if File::exists?( "student.yml" )                                          #若student.yml存在，则将按照文件信息来创建学生对象
  arr = IO.readlines("student.yml")
  students = Array.new
  while i < arr.length
    str = arr[i].split
    students[i-1] = Student.new(str[0].to_i, str[1], str[2].to_i, str[3].to_i)
    i += 1
  end

else                                        #用循环创建随机学生对象
  students = Array.new
  while i <= 100
    s_name = newpass(6)
    s_name = s_name.capitalize
    s_age = rand(15..20)
    s_gender = 2031 - s_age
    students[i-1] = Student.new(i, s_name, s_gender, s_age)
    i += 1
  end
  puts students.length
  store_stu(students)                                      #存储学生信息
end

puts "                      学生管理"
puts "1.添加学生  2.删除学生  3.修改学生   4.查询学生  5.学生排序"
puts "请输入操作前面的编号："
num = gets

case num.to_i
when 1
  students.push( add_stu)
  store_stu(students)
when 2
  i = 0
  puts "请输入要删除学生的id"
  n = gets
  while i < students.length
    if students[i].getStu_id == n.to_i
      students.delete_at(i)
      break
    end
    i += 1
  end
  store_stu(students)

when 3
  i = 0
  puts "请输入要修改学生的id"
  n = gets
  stu = add_stu
  while i < students.length
    if students[i].getStu_id == n.to_i
      students.delete_at(i)
      students[i] = stu
      break
    end
    i += 1
  end
  store_stu(students)

when 4
  i = 0
  puts "请输入要查询学生的id"
  n = gets
  while i < students.length
    if students[i].getStu_id == n.to_i
      puts "id   name   gender  age "
      puts students[i].info()
      break
    end
    i += 1
  end
when 5

else
  puts "请输入正确的编号"
end