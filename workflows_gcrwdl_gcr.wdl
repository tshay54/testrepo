task hello {
  String addressee
  command {
    echo "Hello ${addressee}!"
  }
  output {
    String salutation = read_string(stdout())
  }
  runtime {
    docker: "gcr.io/gcp-runtimes/ubuntu_16_0_4"
  }
}

workflow wf_hello {
  call hello
  output {
     hello.salutation
  }
}