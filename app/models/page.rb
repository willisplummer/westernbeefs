class Page < ActiveRecord::Base
	belongs_to :article

	def page_prev
		if page_number == 1
			nil
		else
			page_number - 1
		end
	end

	def page_next
		if page_number == article.page_count
			'bio'
		else
			page_number + 1
		end
	end

	extend FriendlyId
	friendly_id :page_number, use: [:scoped, :finders], :scope => :article
end