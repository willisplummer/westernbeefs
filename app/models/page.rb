class Page < ActiveRecord::Base
	belongs_to :paginable, polymorphic: true

	def page_prev
		if page_number == 1
			nil
		else
			page_number - 1
		end
	end

	def page_prev_zerod
		if page_prev == nil
			nil
		else
			page_prev.to_s.rjust(2, '0')
		end
	end

	def page_next
		if page_number == paginable.page_count
			'bio'
		else
			page_number + 1
		end
	end

	def page_next_zerod
		page_next.to_s.rjust(2, '0')
	end

	def page_number_zerod
	  page_number.to_s.rjust(2, '0')
	end

	extend FriendlyId
	friendly_id :page_number_zerod, use: [:scoped, :finders], :scope => :paginable
end