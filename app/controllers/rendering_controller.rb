# frozen_string_literal: true

class RenderingController < ApplicationController
  before_action :first_rich_text_example

  def direct
    @rich_text_example.generated_content = @rich_text_example.content
    @rich_text_example.save
  end

  def async
    GenerateHtmlJob.perform_async("example_id" => @rich_text_example.id)
  end

  private

  def first_rich_text_example
    @rich_text_example = RichTextExample.first
  end
end
