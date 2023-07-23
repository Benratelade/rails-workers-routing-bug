class AddGeneratedContentToRichTextExamples < ActiveRecord::Migration[7.0]
  def change
    add_column :rich_text_examples, :generated_content, :string
  end
end
