# frozen_string_literal: true

require 'rails_helper'

feature 'Generating content with rich content', js: true do
  before do
    visit(new_rich_text_example_path)

    attach_file(Rails.root.join("spec/fixtures/test-image.jpg")) do
      page.find("[data-trix-action='attachFiles']").click
    end

    # The Trix editor takes a moment to process images.
    # Waiting here ensures the processing is complete before moving on.
    wait_for do
      find("trix-editor").value
    end.to include("img")

    click_button('Create Rich text example')
    expect(page).to have_content('Successfully saved!')
  end

  scenario 'generating the html directly in the controller gets the correct URL' do
    When 'Someone views content generated inside the controller' do
      visit(direct_rendering_path)
    end

    Then "the URLs have the host set in Rails config" do
      expect(page.find("img")["src"]).to eq(
        "http://custom-host.com/test-image.jpg"
      )
    end
  end

  scenario "generating the html inside a sidekiq worker uses the default url (and that's WRONG)" do
    When 'Someone views content generated inside the controller' do
      visit(async_rendering_path)
    end

    Then "the URLs have the default host (Probably coming from )" do
      expect(page.find("img")["src"]).to eq(
        "http://example.org/test-image.png"
      )
    end
  end
end
