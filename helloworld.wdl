version 1.0

import "sub" as sub

task hello {
    input {
      String name
      String type
      String? sequence
      Int age
      Boolean someBool
      Array[String] friends
    }

    command {
        echo "Hello ${name}!"
        echo "Type is ${type}!"
        echo "Sequence is ${sequence}!"
        echo "Age is ${age}!"
        echo "Boolean is ${someBool}!"
        echo "Friends are ${sep="," friends}!"
    }

    runtime {
        docker: "debian:stable-slim"
    }

    output {
        File response = stdout()
    }
}

task anotherTask {
    input {
      String name
    }

    command {
        echo "Hello again ${name}!"
    }

    runtime {
        docker: "debian:stable-slim"
    }

    output {
        File response = stdout()
    }
}

workflow hello_world {
  input {
    String name = "World"
    String type
    String? sequence
    Int age = 25
    Boolean someBool
    Array[String] friends = ["Alice", "Bob", "Carol"]
  }

  call hello {
      input:
        name = name,
        type = type,
        sequence = sequence,
        age = age,
        someBool = someBool,
        friends = friends,
  }

  call anotherTask {
    input:
      name = name
  }

  call sub.goodbye {
      input:
        goodbye_input = name
    }
}
