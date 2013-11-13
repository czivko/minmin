require 'spec_helper'

describe "posts/index" do
  before(:each) do
    assign(:posts, [
      stub_model(Post,
        :title => "Title",
        :body => "MyText",
        :slug => "Slug",
        :post_type => "Post Type",
        :tags => ""
      ),
      stub_model(Post,
        :title => "Title",
        :body => "MyText",
        :slug => "Slug",
        :post_type => "Post Type",
        :tags => ""
      )
    ])
  end

  it "renders a list of posts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    assert_select "tr>td", :text => "Post Type".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end