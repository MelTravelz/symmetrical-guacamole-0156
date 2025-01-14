require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe 'relationships' do
    it { should have_many :guest_rooms }
    it { should have_many(:rooms).through(:guest_rooms) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'class methods' do
    before do 
      Guest.create!(name: "Letti")
      Guest.create!(name: "Calum")
      Guest.create!(name: "Nika")
    end

    it "::total_count" do
      expect(Guest.total_count).to eq(3)

      Guest.create!(name: "Melony")

      expect(Guest.total_count).to eq(4)
    end

    it "::uniq_guest_names" do
      expect(Guest.uniq_guest_names).to eq(["Nika", "Letti", "Calum"])

      Guest.create!(name: "Nika")

      expect(Guest.uniq_guest_names).to eq(["Nika", "Letti", "Calum"])

      Guest.create!(name: "Melony")

      expect(Guest.uniq_guest_names).to eq(["Nika", "Letti", "Calum", "Melony"])

    end
  end
end