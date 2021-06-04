module CategoriesHelper
    def hex_color_to_rgba(hex, opacity)
        rgb = hex.match(/^#(..)(..)(..)$/).captures.map(&:hex)
        "rgba(#{rgb.join(", ")}, #{opacity})"
    end
end
