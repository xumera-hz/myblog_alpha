class Tag
  include Mongoid::Document
  field :name, type: String
  has_and_belongs_to_many :articles, dependent: :destroy
  validates :name, presence: true, length: {maximum: 25, minimum: 1}
end
