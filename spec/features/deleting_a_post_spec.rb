require 'spec_helper'

feature 'Deleting a post' do
  let!(:post) { create(:post) }

  scenario do
    visit post_path(post)
    click_link 'Delete Post'
    expect(Post.count).to eq 0
    expect(current_path).to eq posts_path
    expect(page).to have_css('.alert.alert-success')
  end
end
