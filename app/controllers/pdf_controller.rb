require 'pdf_forms'

class PdfController < ApplicationController

	def create
		field_mapping = {
			"pretax_income"=>:LineA,
			"pretax_coborrow_income"=>:LineB,
			"pretax_income_total"=>"LineC",
			"takehome_income"=>"LineD",
			"takehome_coborrower_income"=>"LineE",
			"takehome_income_total"=>"LineF",
			"rent"=>"LineG",
			"utilities"=>"LineH",
			"debt_payments"=>"LineI",
			"other_expenses"=>"LineJ",
			"savings"=>"LineK",
			"total_spendings"=>"LineL",
		}

		form_vals = Hash.new(0)

		field_mapping.each do |key, field|
			form_vals[field] = params[key];
		end

		source_form = "#{Rails.root}/public/assets/monthly_payment_worksheet_form.pdf"
		tmp_form = Tempfile.new('cfpb_form')

		pdftk = PdfForms.new('/usr/bin/pdftk')

		pdftk.fill_form source_form, tmp_form.path, form_vals, :flatten => true

		send_file(tmp_form.path, filename: "cpfb_monthly_sheet_filled.pdf", type: "application/pdf")
	end

end
