class Post < TenantRecord
  belongs_to :author, class_name: 'User'
  scope :published, -> { where.not(published_at: nil) }
end
