class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :limit, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  scope :title_search,  -> (title) { where("title LIKE ?", "%#{title}%") }
  scope :status_search,  -> (status) { where(status: status)}

  enum priority: { 高: 0, 中: 1, 低: 2 }
end
