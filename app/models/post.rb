class Post < ActiveRecord::Base
	belongs_to :user
	has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150#" }, path: ":rails_root/public/system/:attachment/:id/:style/:filename",
      url: "/system/:attachment/:id/:style/:filename"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
	validates :title, presence: true
	validates :body, presence: true
end
