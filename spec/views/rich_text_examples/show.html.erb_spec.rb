# frozen_string_literal: true

require "rails_helper"

describe "rich_text_examples/show.html.erb" do
  before do
    @rich_text_example = RichTextExample.new(content: "some content")
  end

  it "renders the content for the Rich Text Example" do
    render

    expect(rendered).to include("some content")
  end
end
