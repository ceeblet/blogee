require 'spec_helper'

feature "Editing comments" do
  let!(:post) { FactoryGirl.create(:post) }
  let!(:comment) { FactoryGirl.create(:comment, post: post) }

  before do
    visit posts_path
    click_link post.title
    click_link comment.author
    click_link "Edit Comment"
  end

  scenario "with valid attributes" do
    fill_in "Author", with: "Bugs Bunny"
    fill_in "Content", with: "That's all folks!"
    click_button "Update Comment"

    expect(page).to have_content "Comment has been updated."
    within("#comment p") do
      expect(page).to have_content("That's all folks!")
    end
    expect(page).to_not have_content comment.content
  end

  scenario "with invalid attributes" do
    fill_in "Author", with: ""
    fill_in "Content", with: ""
    click_button "Update Comment"
    expect(page).to have_content("Comment has not been updated.")
  end
end
