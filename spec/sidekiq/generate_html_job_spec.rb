require 'rails_helper'
RSpec.describe GenerateHtmlJob, type: :job do
  it "generates the html for the rich text and saves it" do
    rich_text_example = double("rich text example", content: "the content")
  
    expect(RichTextExample).to receive(:find).with("the example id").and_return(rich_text_example)
    expect(rich_text_example).to receive("content_from_sidekiq=").with("the content")
    expect(rich_text_example).to receive(:save)

    @job = GenerateHtmlJob.new.perform("example_id" => "the example id")
  end
end
