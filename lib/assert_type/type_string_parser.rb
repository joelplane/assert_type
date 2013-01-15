require File.expand_path('./type_string_tokeniser.rb', File.dirname(__FILE__))
require File.expand_path('./type_node.rb', File.dirname(__FILE__))
require File.expand_path('./parse_error.rb', File.dirname(__FILE__))


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
      quick_check_tokens
      root = TypeNode.root
      previous_word = root
      current_words = [root]
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
      root
    end

    def tokens
      @tokens ||= TypeStringTokeniser.tokenise @type_string
    end

    def quick_check_tokens
      unless check_angle_brackets_matched && check_angle_brackets_enclose_type
        raise ParseError.new
      end
    end

    def check_angle_brackets_matched
      open_angle_brackets = 0
      tokens.each do |token|
        if token.name == :open_angle
          open_angle_brackets += 1
        elsif token.name == :close_angle
          open_angle_brackets -= 1
        end
        return false if open_angle_brackets < 0
      end
      open_angle_brackets == 0
    end

    def check_angle_brackets_enclose_type
      previous_name = nil
      tokens.each do |token|
        return false if previous_name == :open_angle && token.name != :word
        previous_name = token.name
      end
      true
    end

  end
end
