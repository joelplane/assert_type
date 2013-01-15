assert_type
===========

Provides a simple method to make assertions about the type of a value,
including nested types.

## Installation

    gem install assert_type

## Example

### Set-up

#### In development

Include the AssertType::AssertMethods module in Object,
which will make the assert_type method available anywhere.

It doesn't need to live in Object if you're not comfortable having it there.

```ruby
require 'assert_type'
class Object
  include AssertType::AssertMethods
end
```

#### In production

Include the AssertType::NoOpMethods module instead of AssertType::AssertMethods
to include an assert_type method with the same signature that does nothing.

```ruby
require 'assert_type'
class Object
  include AssertType::NoOpMethods
end
```

### Making assertions

The first argument is the type string. It's based on YARD types. The entire YARD type syntax is not supported.

```ruby
assert_type "Array", []                                  # wont raise
assert_type "Array", {}                                  # will raise AssertType::AssertionError

assert_type "Array<Fixnum>", [1,2,3]                     # wont raise
assert_type "Array<Fixnum>", []                          # wont raise
assert_type "Array<Fixnum>", [1.1,2.2,3.3]               # will raise AssertType::AssertionError
assert_type "Array<Fixnum>", nil                         # will raise AssertType::AssertionError

assert_type "Array<Fixnum>, nil", [1,2,3]                # wont raise
assert_type "Array<Fixnum>, nil", nil                    # wont raise

assert_type "String, Symbol", "three"                    # wont raise
assert_type "String, Symbol", :three                     # wont raise
assert_type "String, Symbol", 3                          # will raise AssertType::AssertionError

assert_type "Array<String, Symbol>", ["three"]           # wont raise
assert_type "Array<String, Symbol>", [:three]            # wont raise
assert_type "Array<String, Symbol>", []                  # wont raise
assert_type "Array<String, Symbol>", [3]                 # will raise AssertType::AssertionError

assert_type "Array<Set<Numeric>>", [Set.new([1,2])]      # wont raise
assert_type "Array<Set<Numeric>>", [Set.new]             # wont raise
assert_type "Array<Set<Numeric>>", []                    # wont raise
assert_type "Array<Set<Numeric>>", [Set.new(["1","2"])]  # will raise AssertType::AssertionError
assert_type "Array<Set<Numeric>>", [[1,2]]               # will raise AssertType::AssertionError
assert_type "Array<Set<Numeric>>", [3]                   # will raise AssertType::AssertionError
```