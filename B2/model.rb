require 'active_record'
require 'mysql2'
require 'digest/sha1'

ActiveRecord::Base.establish_connection(
  adapter: 'mysql2',
  host: '127.0.0.1',
  username: 'root',
  password: '123456',
  database: 'MESSAGE'
) # 连接数据库

class User < ActiveRecord::Base
  has_many :messages
  validates_uniqueness_of :username, message: '用户名已存在' # 检验用户名唯一
  validates_format_of :password, # 检验密码
                      with: /\A[a-zA-Z0-9]+\z/,
                      message: '密码由字母加数字组成（区分大小写）'
  validates_length_of :password, minimum: 4, message: '请确认密码长度大于4'
end

class Message < ActiveRecord::Base
  belongs_to :users
  validates_length_of :content, minimum: 10, message: '留言长度至少为10'
end
