# frozen_string_literal: true

require "rails_helper"

describe RichTextExamplesController, type: :controller do
  describe "create" do
    before do
      @rich_text_example = RichTextExample.new
      allow(RichTextExample).to receive(:new).and_return(@rich_text_example)
    end

    it "redirects to show and sets a success message in the flash" do
      post(
        :create,
        params: {
          rich_text_example: {
            content: "some content",
          },
        },
      )

      expect(response).to redirect_to(rich_text_example_path(@rich_text_example))
      expect(flash["message"]).to eq("Successfully saved!")
    end
  end

  describe "show" do
    it "assigns the rich_text_example" do
      rich_text_example = double("rich text example")
      expect(RichTextExample).to receive(:find).with("the-rich-text-example-id").and_return(rich_text_example)

      get(
        :show,
        params: {
          id: "the-rich-text-example-id",
        },
      )

      expect(assigns(:rich_text_example)).to eq(rich_text_example)
    end
  end
end
