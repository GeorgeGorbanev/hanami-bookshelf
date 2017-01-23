require 'features_helper'

describe 'Home page' do
  it 'contents "Bookshelf" header' do
    visit '/'
    within 'h1' do
        expect(page).to have_content 'Bookshelf'
      end
  end
end
