# frozen_string_literal: true

module Components
  module SeparatorHelper
    def render_separator(options = {})
      options = { class: "shrink-0 bg-border h-[1px] w-full #{options[:class]}" }.reverse_merge(options)
      content_tag :div, '', options
    end
  end
end
