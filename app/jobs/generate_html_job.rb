# frozen_string_literal: true

class GenerateHtmlJob
  include Sidekiq::Job

  def perform(args)
    rich_text_example = RichTextExample.find(args["example_id"])

    processed_content = rich_text_example.content
    rich_text_example.content_from_sidekiq = processed_content
    rich_text_example.save
  end
end
