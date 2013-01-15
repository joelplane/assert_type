require File.expand_path('./parse_error.rb', File.dirname(__FILE__))

module AssertType
  class TypeStringTokeniser

    # @param type_string [String] like Array<Fixnum>
    def self.tokenise type_string
      new(type_string).tokens
    end

    def initialize type_string
      @type_string = type_string.strip
    end

    def tokens
      tokens = []
      while (t = next_token) do
        tokens << t
      end
      raise ParseError.new unless @type_string.strip == ""
      tokens
    end

    private

    Token = Struct.new :name, :value

    TOKEN_MATCHERS = [
      {:token_name => :word, :matcher => /^\w+/},
      {:token_name => :open_angle, :matcher => /^</},
      {:token_name => :close_angle, :matcher => /^>/},
      {:token_name => :comma, :matcher => /^,/}
    ]

    # @return [Token, nil]
    def next_token
      value = nil
      matcher = TOKEN_MATCHERS.detect do |tm_hash|
        value = @type_string.scan(tm_hash[:matcher])[0]
        !value.nil?
      end
      matcher && (Token.new(matcher[:token_name], value).tap do |t|
        @type_string = (@type_string.slice(value.length, @type_string.length) || '').strip
      end)
    end

  end
end
