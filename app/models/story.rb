class Story < ActiveRecord::Base
  belongs_to :article
  has_many :pages, as: :paginable, dependent: :destroy

  validates :slug, uniqueness: { case_sensitive: false }
  
  validates_presence_of :slug, :title

  def page_count
    pages.count
  end

  extend FriendlyId
  friendly_id :slug, use: [:slugged, :finders]
end