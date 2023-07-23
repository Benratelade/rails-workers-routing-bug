class AddContentFromSidekiqToRichTextExamples < ActiveRecord::Migration[7.0]
  def change
    add_column :rich_text_examples, :content_from_sidekiq, :string
  end
end
