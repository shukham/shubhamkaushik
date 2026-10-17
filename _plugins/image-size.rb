# Liquid filter `image_size`: returns [width, height] of a local PNG or JPEG
# (path relative to the site root), or nil. Images rendered with explicit
# dimensions don't shift the page layout while they load.
module Jekyll
  module ImageSize
    CACHE = {}

    def image_size(path)
      file = File.join(@context.registers[:site].source, path.to_s.delete_prefix("/"))
      return nil unless File.file?(file)

      CACHE[file] ||= File.open(file, "rb") { |io| ImageSize.read(io) }
    end

    def self.read(io)
      header = io.read(24).to_s
      if header.start_with?("\x89PNG".b)
        header[16, 8].unpack("NN")
      elsif header.start_with?("\xFF\xD8".b)
        read_jpeg(io)
      end
    end

    # Walks JPEG segments until a start-of-frame marker, which holds the size.
    def self.read_jpeg(io)
      io.seek(2)
      while (segment = io.read(4)) && segment.bytesize == 4
        marker, length = segment.unpack("nn")
        if marker.between?(0xFFC0, 0xFFCF) && ![0xFFC4, 0xFFC8, 0xFFCC].include?(marker)
          height, width = io.read(5).unpack("xnn")
          return [width, height]
        end
        io.seek(length - 2, IO::SEEK_CUR)
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::ImageSize)
