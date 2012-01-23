$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require 'paperclip/zoom_tiles/version'

Gem::Specification.new do |s|
  s.name              = "paperclip-zoom_tiles"
  s.version           = Paperclip::ZoomTiles::VERSION
  s.platform          = Gem::Platform::RUBY
  s.author            = "Benjamin Huettinger"
  s.email             = ["gems@maxigs.de"]
  s.homepage          = "https://github.com/maxigs/paperclip-zoom_tiles"
  s.summary           = "Tile extension for Paperclip to split large images into tiles with multiple zoom levels."
  s.description       = "Tile extension for Paperclip to split large images into tiles with multiple zoom levels."

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]

end
