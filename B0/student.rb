#!/usr/bin/ruby

def newpass( len )          #产生长度为len的随机字符串（小写）的函数
chars = ("a".."z").to_a
newpass = ""
1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
return newpass
end

class Student                                #学生类
   def initialize(id, name, gender, age)
      @stu_id=id
      @stu_name=name
      @stu_gender=gender
      @stu_age=age
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

i = 1
checkFile = File.new("student.yml", "r")
if checkFile
  checkFile.close
  arr = IO.readlines("student.yml")
  students = Array.new
  while i <= 100
    str = arr[i].split
    students[i-1] = Student.new(str[0].to_i, str[1], str[2].to_i, str[3].to_i)
    students[i-1].display_details()
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
    students[i-1].display_details()
    i += 1
  end

  aFile = File.new("student.yml", "w+")                       #将学生信息写入student.yml 文件中
  aFile.syswrite("id   name   gender  age \n")
  j = 1
  while j < 101
    aFile.syswrite(students[j].info())
    j += 1
  end
  aFile.close
end
