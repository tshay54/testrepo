task hello {
  String addressee
  command {
    echo "Hello ${addressee}!"
    echo "${addressee}" > addressee.txt
  }
  output {
    String salutation = read_string(stdout())
    File addressee_file = "addressee.txt"
  }
  runtime {
    docker: "gcr.io/gcp-runtimes/ubuntu_16_0_4"
  }
}

workflow wf_hello {
  call hello
  output {
     hello.salutation
     hello.addressee_file
  }
}