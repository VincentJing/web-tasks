class Admin < ActiveRecord::Base
  def self.check_login(m) # 登陆验证函数
    a = Admin.find_by(name: m.name)
    if a.nil?
      return false
    else
      if a.password == m.password
        return true
      else
        return false
      end
    end
  end
end
