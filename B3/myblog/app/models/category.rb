class Category < ActiveRecord::Base
  has_and_belongs_to_many :posts, dependent: :destroy
  validates :title, presence: { message: '标题不能为空' },
                    uniqueness: { message: '该分类已存在' },
                    length: { maximum: 5,
                              too_long: '标题长度应小于5' }
end
