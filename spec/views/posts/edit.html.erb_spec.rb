require 'spec_helper'

describe "posts/edit" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :title => "MyString",
      :body => "MyText",
      :slug => "MyString",
      :post_type => "MyString",
      :tags => ""
    ))
  end

  it "renders the edit post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", post_path(@post), "post" do
      assert_select "input#post_title[name=?]", "post[title]"
      assert_select "textarea#post_body[name=?]", "post[body]"
      assert_select "input#post_slug[name=?]", "post[slug]"
      assert_select "input#post_post_type[name=?]", "post[post_type]"
      assert_select "input#post_tags[name=?]", "post[tags]"
    end
  end
end
