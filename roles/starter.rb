name "starter"
description "This is an example Chef role"
run_list "recipe[starter]"
override_attributes({
  "starter_name" => "admin it",
})
