require 'spec_helper'

describe 'Admin' do

  let(:post) {Post.last}

  context "on admin homepage" do

    it "can see a list of recent posts" do
      visit admin_posts_path
      expect(page).to have_content post.title
    end
    
    it "can edit a post by clicking the edit link next to a post" do
      visit admin_posts_path
      first(:link, "Edit").click

      expect(page).to have_selector('h1', text: 'Edit')
      # page.find(:text => post.title).click_link('Edit')
    end
    
    # it "can delete a post by clicking the delete link next to a post", js: true do
    #   visit admin_posts_path
    #   # driver.switchTo().alert()
    #   first(:link, "Delete").click

    # end

    it "can create a new post and view it" do
       visit new_admin_post_path 
       expect {
         fill_in 'post_title',   with: "Hello world!"
         fill_in 'post_content', with: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat."
         page.check('post_is_published')
         click_button "Save"
       }.to change(Post, :count).by(1)

       page.should have_content "Published: true"
       page.should have_content "Post was successfully saved."
     end
  end

  context "editing post" do
    it "can mark an existing post as unpublished" do
      visit edit_admin_post_path(post)
      page.uncheck('post_is_published')
      click_button "Save"
      page.should have_content "Published: false"
    end
  end

  context "on post show page" do
    it "can visit a post show page by clicking the title" do
      visit admin_posts_path
      click_link(post.title)
      expect(page).to have_content post.title
    end

    it "can see an edit link that takes you to the edit post path" do
      visit admin_post_path(post)
      click_link("Edit post")
      expect(page).to have_content "Edit #{post.title}"
    end

    it "can go to the admin homepage by clicking the Admin welcome page link" do
      visit admin_post_path(post)
      click_link("Admin welcome page")
      expect(page).to have_content "Welcome to the admin panel!"
    end
  end
end
