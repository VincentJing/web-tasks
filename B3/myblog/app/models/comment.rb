class Comment < ActiveRecord::Base
  belongs_to :post
  validates :content, length: { minimum: 10,
                                maximum: 500,
                                too_short: '内容长度应大于%{count}',
                                too_long: '内容长度应小于%{count}' }
  validates :email, format: { with:  /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/,
                              message: 'email格式不符合规范',
                              multiline: true }
  def self.check(m)
    m.status = true
    m.save
  end
end
