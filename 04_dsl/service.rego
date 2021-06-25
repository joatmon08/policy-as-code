package service.policies

import input
import data.exceptions

soft_mandatory(type, elem) = true {
  exceptions[type][_] = elem
} else = false { true }

warn[msg] {
  num_intentions := count(input)
  num_intentions != 3
  msg = sprintf("number of intentions should be 3, currently %v", [num_intentions])
}

deny[msg] {
  web := [intention.DestinationName | intention := input[_]; intention.SourceName == "web"]
  web != ["app"]
  not soft_mandatory("intentions", "web")
  msg = sprintf("traffic should only be allowed from web to app, currently web to %v", [web])
}

deny[msg] {
  app := [intention.DestinationName | intention := input[_]; intention.SourceName == "app"]
  app != ["database"]
  not soft_mandatory("intentions", "app")
  msg = sprintf("traffic should only be allowed from app to database, currently app to %v", [app])
}

deny[msg] {
  sources := [intention.SourceName | intention := input[_]; intention.DestinationName == "database"]
  sources != ["app"]
  not soft_mandatory("intentions", "database")
  msg = sprintf("traffic should only be allowed from app to database, currently %v to database", [sources])
}

deny[msg] {
  actions := [intention.Action | intention := input[_]; intention.SourceName == "*"]
  actions != ["deny"]
  not soft_mandatory("intentions", "*")
  msg = sprintf("intention should deny all other traffic by default, currently %v", [actions])
}