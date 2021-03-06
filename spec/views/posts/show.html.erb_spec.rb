require 'spec_helper'

describe "posts/show" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :title => "Title",
      :body => "MyText",
      :slug => "Slug",
      :post_type => "Post Type",
      :tags => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/Slug/)
    rendered.should match(/Post Type/)
    rendered.should match(//)
  end
end
