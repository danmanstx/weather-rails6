require 'rails_helper'

RSpec.describe 'places/index', type: :view do
  before(:each) do
    assign(:places, [
      Place.create!(
        name: 'Name',
        zipcode: 'Zipcode',
        latitude: '40.7143528',
        longitude: '-74.0059731',
        address: 'Address'
      ),
      Place.create!(
        name: 'Name',
        zipcode: 'Zipcode',
        latitude: '40.7143528',
        longitude: '-74.0059731',
        address: 'Address'
      )
    ])
  end

  it 'renders a list of places' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('-74.0059731'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('40.7143528'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Address'.to_s), count: 2
  end
end
