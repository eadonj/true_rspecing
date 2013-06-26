require 'spec_helper'

describe 'User' do

  let(:post) {Post.last}
  
  context "on homepage" do

    before(:each) do
      visit root_path
    end

    it "sees a list of recent posts titles" do
      expect(page).to have_content post.title
    end

    it "can not see bodies of the recent posts" do
      expect(page).to_not have_content post.content
    end

    it "can click on titles of recent posts and should be on the post show page" do
      click_link(post.title)
      expect(page).to have_content post.title
    end

    it "can not see the edit link" do
      expect(page).to_not have_link 'edit'
    end

    it "can not see the delete link" do
      expect(page).to_not have_link 'delete'
    end
  end

  context "post show page" do
    
    before(:each) do
      visit post_path(post)
    end

    it "sees title and body of the post" do
      expect(page).to have_content post.title
      expect(page).to have_content post.content
    end
    it "can not see the edit link" do
      expect(page).to_not have_link 'edit'
    end
    it "can not see the published flag" do
      expect(page).to_not have_content "Published"
    end
    it "can not see the Admin homepage link" do
      expect(page).to_not have_link "Admin welcome page"
    end
  end
end
