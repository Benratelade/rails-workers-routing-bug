# frozen_string_literal: true

require 'rails_helper'

describe 'rendering/direct.html.erb' do
  before do
    @rich_text_example = RichTextExample.new(content: 'some content')
  end

  it 'displays the content for the rich_text_example' do
    render

    expect(rendered).to include('some content')
  end
end
