# frozen_string_literal: true

require "rails_helper"

describe "rich_text_examples/new.html.erb" do
  before do 
    @rich_text_example = RichTextExample.new
  end

  it "renders a field for the content of the rich text example" do
    render

    expect(Capybara.string(rendered)).to have_css("form trix-editor")
  end

  it "renders a submit button" do
    render

    expect(Capybara.string(rendered)).to have_css("form input[type='submit']")
  end
end