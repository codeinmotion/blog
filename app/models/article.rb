class Article < ActiveRecord::Base
	belongs_to :category
	has_many :comments, dependent: :destroy
	validates :title, presence: true, length: { minimum:1 }
	validates :thumbnail, presence: true
	has_attached_file :thumbnail,
                    path:  "#{Rails.env}/:class/:attachment/:id/:style.:extension",
                    storage: :s3,
                    s3_credentials: File.join(Rails.root, 'config', 'application.yml'),
                    :styles => { :thumb => "200x200#" },
                    :default_url => "/images/:style/missing.png"
	self.per_page = 12
  validates_attachment_content_type :thumbnail, :content_type => /\Aimage\/.*\Z/
end
