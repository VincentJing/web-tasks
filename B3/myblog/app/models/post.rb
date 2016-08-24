class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :categories
  validates :content, length: { minimum: 10,
                                maximum: 5000,
                                too_short: '内容长度应大于%{count}',
                                too_long: '内容长度应小于%{count}' }
  validates :title, presence: { message: '标题不能为空' },
                    length: { maximum: 100,
                              too_long: '标题长度应小于%{count}' }
end
