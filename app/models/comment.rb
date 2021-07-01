class Comment < ApplicationRecord
  belongs_to :pin

  validates :body, presence: true

  after_create_commit { broadcast_append_to pin }
  after_update_commit { broadcast_replace_to pin }
  after_destroy_commit { broadcast_remove_to pin }

  after_create_commit do
    broadcast_prepend_to 'make'
  end
end