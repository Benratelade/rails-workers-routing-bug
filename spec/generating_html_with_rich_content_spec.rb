# frozen_string_literal: true

require "rails_helper"

feature "Generating content with rich content", js: true do
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

    click_button("Create Rich text example")
    expect(page).to have_content("Successfully saved!")
  end

  scenario "generating the html directly in the controller gets the correct URL" do
    When "Someone views content generated inside the controller" do
      visit(direct_rendering_path)
    end

    Then "the URLs have the host set in Rails config" do
      expect(page.find("img")["src"]).to match(
        "#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}/rails/active_storage/representations/redirect/.*/test-image.jpg",
      )

      rich_text_example = RichTextExample.first

      rendered_html = Capybara.string(rich_text_example.generated_content)
      expect(rendered_html.find("img")["src"]).to match(
        "#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}/rails/active_storage/representations/redirect/.*/test-image.jpg",
      )
    end
  end

  scenario "generating the html inside a sidekiq worker uses the default url (and that's WRONG)" do
    When "Someone views content generated inside the controller" do
      visit(async_rendering_path)
    end

    And "Sidekiq is run" do
      Sidekiq::Worker.drain_all
    end

    Then "the content generated inside the sidekiq job has a default host" do
      rich_text_example = RichTextExample.first

      rendered_html = Capybara.string(rich_text_example.content_from_sidekiq)
      expect(rendered_html.find("img")["src"]).to match(
        "http://example.org/rails/active_storage/representations/redirect/.*/test-image.jpg",
      )
    end
  end
end
