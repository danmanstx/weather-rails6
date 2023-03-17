require 'rails_helper'

RSpec.describe 'places/show', type: :view do
  before(:each) do
    assign(:place, Place.create!(
      name: 'Name',
      latitude: '40.7143528',
      longitude: '-74.0059731',
      address: 'Address'
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/-74.0059731/)
    expect(rendered).to match(/40.7143528/)
    expect(rendered).to match(/Address/)
  end
end
