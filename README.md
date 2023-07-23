# README

I cannot for the life of me figure out why asset URLs are generated wrongly when inside a Sidekiq worker. 

This aims to showcase the issue. 

The interesting spec is: 
`spec/generating_html_with_rich_content_spec.rb`

Once you've run `bundle install`, you can run the spec with 
`rspec spec/generating_html_with_rich_content_spec.rb`

For image processing, you will need something like libvips: 
`brew install vips`

This seems similar to an issue raised a while ago: 
https://github.com/rails/rails/issues/35540

but I couldn't figure out the fix for my situation, since we do not have direct access to the image being rendered (this is all taken care of by ActionText). 