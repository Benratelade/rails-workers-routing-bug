# frozen_string_literal: true

require 'rails_helper'

describe RenderingController, type: :controller do
  describe "direct" do
    before do
      @rich_text_example = double("rich text example", content: "the content")
      allow(RichTextExample).to receive(:first).and_return(@rich_text_example)
      allow(@rich_text_example).to receive("generated_content=")
      allow(@rich_text_example).to receive(:save)
    end

    it "finds and assigns the first Rich Text Example and renders it immediately" do
      expect(RichTextExample).to receive(:first)
      
      get(
        :direct
      )

      expect(assigns(:rich_text_example))
    end

    it "saves the generated content to the database" do
      expect(RichTextExample).to receive(:first).and_return(@rich_text_example)
      expect(@rich_text_example).to receive("generated_content=").with("the content")
      expect(@rich_text_example).to receive(:save)

      get(
        :direct
      )
    end

  end

  describe "async" do
    before do 
      @first_rich_text_example = double("rich text example", id: "rich-text-example-id")
      allow(RichTextExample).to receive(:first).and_return(@first_rich_text_example)
      allow(GenerateHtmlJob).to receive(:perform_async)
    end

    it "finds and assigns the first Rich Text Example and renders it immediately" do
      expect(RichTextExample).to receive(:first)
      
      get(
        :async
      )

      expect(assigns(:rich_text_example))
    end

    it "runs a job to send an email" do
      expect(GenerateHtmlJob).to receive(:perform_async).with(
        "example_id" => "rich-text-example-id",
      )

      get(
        :async
      )
    end
  end
end