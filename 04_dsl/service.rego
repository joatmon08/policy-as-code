package service.policies

import input

deny[msg] {
  num_intentions := count(input)
  num_intentions != 3
  msg = sprintf("number of intentions should be 3, currently %v", [num_intentions])
}

deny[msg] {
  web := [intention.DestinationName | intention := input[_]; intention.SourceName == "web"]
  web != ["app"]
  msg = sprintf("traffic should only be allowed from web to app, currently web to %v", [web])
}

deny[msg] {
  app := [intention.DestinationName | intention := input[_]; intention.SourceName == "app"]
  app != ["database"]
  msg = sprintf("traffic should only be allowed from app to database, currently app to %v", [app])
}

deny[msg] {
  actions := [intention.Action | intention := input[_]; intention.SourceName == "*"]
  actions != ["deny"]
  msg = sprintf("intention should deny all other traffic by default, currently %v", [actions])
}