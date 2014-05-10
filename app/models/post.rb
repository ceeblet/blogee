class Post < ActiveRecord::Base
  has_many :comments
  has_and_belongs_to_many :tags
  attr_accessor :tag_names
  belongs_to :user

  validates :title, :presence => true
  validates :content, :presence => true
  
  mount_uploader :asset, AssetUploader
  
  before_create :associate_tags
  
  private
  
    def associate_tags
      if tag_names
        tag_names.split(" ").each do |name|
          self.tags << Tag.find_or_create_by(name: name)
        end 
      end
    end
end
