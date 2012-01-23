require 'paperclip'
require 'paperclip/tiles'

module Paperclip
  class ZoomTiles < Tiles
    attr_accessor :zooms

    def initialize(file, options = {}, attachment = nil)
      super(file, options, attachment)

      @zooms = options[:tiles_zooms]
    end

    def make_tiles(src)
      ret = {}
      zooms.each do |zoom, scale|
        if scale == 1
          dst = src

          crops(dst).each do |field, crop|
            ret[[zoom, field].flatten.join('_')] = make_tile(dst, field.unshift(zoom), crop)
          end
        else
          dst = Tempfile.new(["#{basename}_#{zoom}", ".#{format}"])
          dst.binmode

          geo     = Geometry.from_file(src)
          new_geo = Geometry.new((geo.width.to_f*scale).to_i, (geo.height.to_f*scale).to_i)
          scale   = "-resize #{new_geo.width}x#{new_geo.height} +repage"

          Paperclip.run("convert", ":source #{scale} :dest", {
            source: "#{File.expand_path(file.path)}[0]",
            dest:   File.expand_path(dst.path)
          })

          crops(dst, new_geo).each do |field, crop|
            ret[[zoom, field].flatten.join('_')] = make_tile(dst, field.unshift(zoom), crop)
          end
        end

      end
      ret
    end

  end
end