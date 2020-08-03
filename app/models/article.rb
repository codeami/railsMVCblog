# #
# Basic database BREAD (Browse, Read, Edit, Add, Destroy) operations, 
# data validation, sophisticated search support, 
# aility to relate multiple models to one another.
#
# class ApplicationRecord < ActiveRecord::Base
#     self.abstract_class = true
#   end
##  

class Article < ApplicationRecord
    has_many :comments, dependent: :destroy
    validates :title, presence: true,
                length: { minimum: 5}
end
