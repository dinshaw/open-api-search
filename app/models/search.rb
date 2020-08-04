class Search < ApplicationRecord
  validates :subject, presence: true, uniqueness: { scope: [:author, :sort_order] }
end
