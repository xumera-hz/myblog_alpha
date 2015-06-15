class Article
  include Mongoid::Document
  field :title, :type => String
  field :text, :type => String
  field :count_tags, :type => Integer
  has_many :comments, dependent: :destroy
  has_and_belongs_to_many :tags, dependent: :destroy, inverse_of: :article
  validates :title, presence: true, length: {minimum: 5 , maximum: 150 }
  validates :text, presence: true, length: {minimum: 30}
  validates :count_tags, :numericality => { :greater_than => 0, :less_than => 6  }
end
