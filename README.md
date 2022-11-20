# raoh_struct
Forces the typing of the attributes of an instance

## Example

```ruby
require 'raoh_struct'

class User < Raoh::Struct::Base
  attribute :first_name, String, transform: %i[capitalize]
  attribute :last_name, String, transform: %i[upcase]
  attribute :age, Integer, default: 38
end

maxime = User.new do |user|
  user.first_name = 'maxime'
  user.last_name = 'Désécot'
end

puts maxime.first_name
=> Maxime
puts maxime.last_name
=> DÉSÉCOT
puts maxime.age
=> 38

maxime.first_name = 'kenshiro'

puts maxime.first_name_changed?
=> true
puts maxime.last_name_changed?
=> false

puts maxime.first_name
=> Kenshiro
puts maxime.last_name
=> DÉSÉCOT

puts maxime.first_name_was
=> Maxime
```