#encoding: utf-8
class Comment < ActiveRecord::Base
  validates_length_of  :info, in: 5..500, message: '长度不正确！'
  belongs_to :user
  belongs_to :article
  belongs_to :home
end
