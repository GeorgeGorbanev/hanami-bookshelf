require_relative '../../../../apps/web/controllers/books/create'

RSpec.describe Web::Controllers::Books::Create do
  let(:action) { Web::Controllers::Books::Create.new }

  after do
    BookRepository.new.clear
  end

  describe 'with valid params' do
    let(:params) { Hash[book: { title: '1984', author: 'George Orwell' }] }

    it 'creates a new book' do
      action.call(params)
      expect(action.book.id).not_to eql nil
    end

    it 'redirects the user to the books listing' do
      response = action.call(params)

      expect(response[0]).to eql 302
      expect(response[1]['Location']).to eql '/books'
    end
  end

  describe 'with invalid params' do
    let(:params) { Hash[book: {}] }

    it 're-renders the books#new view' do
      response = action.call(params)
      expect(response[0]).to eql 422
    end

    it 'sets errors attribute accordingly' do
      response = action.call(params)
      expect(response[0]).to eql 422

      expect(action.params.errors[:book][:title]).to eql  ['is missing']
      expect(action.params.errors[:book][:title]).to eql  ['is missing']
    end
  end
end
