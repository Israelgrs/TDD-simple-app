describe 'HTTParty' do
  # it 'Content-Type', vcr: { cassette_name: 'jsonplaceholder/posts', match_requests_on: [:body] } do
  it 'Content-Type', vcr: { cassette_name: 'jsonplaceholder/posts', record: :new_episodes } do
    # stub_request is from webmock
    # stub_request(:get, 'https://jsonplaceholder.typicode.com/posts/2').
    # to_return(status: 200, body: '', headers: { 'Content-Type': 'application/json' })

    response = HTTParty.get('https://jsonplaceholder.typicode.com/posts/4')
    content_type = response.headers['Content-Type']
    expect(content_type).to match(/application\/json/)
  end
end