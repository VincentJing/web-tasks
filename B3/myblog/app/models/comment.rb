class Comment < ActiveRecord::Base
  belongs_to :post
  def self.check(m)
    m.status = true
    m.save
  end
end
