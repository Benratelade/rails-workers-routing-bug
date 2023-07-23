class CreateRichTextExamples < ActiveRecord::Migration[7.0]
  def change
    create_table :rich_text_examples do |t|
      t.timestamps
    end
  end
end
