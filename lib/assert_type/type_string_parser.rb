require File.expand_path('./type_string_tokeniser.rb', File.dirname(__FILE__))
require File.expand_path('./type_node.rb', File.dirname(__FILE__))

module AssertType
  class TypeStringParser

    # @param type_string [String] like Array<Fixnum>
    def self.parse type_string
      new(type_string).parse
    end

    def initialize type_string
      @type_string = type_string
    end

    def parse
      first_token = tokens.shift
      main_type = first_token.value
      node = TypeNode.new main_type
      previous_word = node
      current_words = []
      tokens.each do |token|
        case token.name
          when :open_angle
            current_words.push previous_word
          when :close_angle
            current_words.pop
          when :word
            current_words.last.children << (previous_word = TypeNode.new(token.value))
          when :comma
            # ignore commas
        end
      end
      node
    end

    def tokens
      @tokens ||= TypeStringTokeniser.tokenise @type_string
    end

  end
end
