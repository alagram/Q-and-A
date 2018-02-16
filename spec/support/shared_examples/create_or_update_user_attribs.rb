shared_examples "create_or_update_user_attribs" do
  it "sets the users provider" do
    subject
    expect(object.provider).to eq('google_oauth2')
  end

  it "sets the users first_name" do
    subject
    expect(object.first_name).to eq('Alice')
  end

  it "set's the user's last_name" do
    subject
    expect(object.last_name).to eq('Smith')
  end

  it "set's the user's email" do
    subject
    expect(object.email).to eq('test@example.com')
  end

  it "set's the user's uid" do
    subject
    expect(object.uid).to eq('12345')
  end

  it "set's the user's refresh_token" do
    subject
    expect(object.refresh_token).to eq('12345abcde')
  end

  it "set's the user's oauth_expires_at" do
    subject
    expect(object.oauth_expires_at).to eq(auth[:credentials][:expires_at])
  end
end
