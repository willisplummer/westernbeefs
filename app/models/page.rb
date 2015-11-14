class Page < ActiveRecord::Base
	belongs_to :paginable, polymorphic: true

	validates_numericality_of :page_number, greater_than: 0

	def page_number_zerod
		page_number.to_s.rjust(2, '0')
	end
	
	extend FriendlyId
	friendly_id :page_number_zerod, use: [:scoped, :finders], :scope => [:paginable, :paginable_type]
end