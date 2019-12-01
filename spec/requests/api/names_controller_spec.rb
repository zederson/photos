describe Api::NamesController, type: :request do
  describe 'GET api/names' do
    context 'when list all names in photos' do
      let(:names) { %w[ze taisa felipe edinho gildo].sort }

      before { allow(Person).to receive(:all).and_return(names) }

      it 'shoul be list all names' do
        get '/api/names'

        content = JSON.parse(response.body)

        expect(response).to be_ok
        expect(content).to contain_exactly(*names)
      end
    end
  end
end
