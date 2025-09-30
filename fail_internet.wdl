workflow wf_fail_on_no_connection {
  call fail_egress_test
}

task fail_egress_test {
  command <<<
    #!/bin/bash
    # This command tells the script to exit immediately if any command fails.
    set -e

    echo "--- Attempting to connect to example.com:443 ---"
    echo "This task will now FAIL if the connection is blocked."

    # The 'timeout' command will fail with a non-zero exit code if it can't
    # connect within 20 seconds. The 'set -e' command above catches this
    # failure and terminates the script, causing the WDL task to fail.
    timeout 20 bash -c 'exec 3<>/dev/tcp/example.com/443'

    # This success message will only be printed if the connection is successful.
    echo "--- SUCCESS: Connection was established. ---"
  >>>

  runtime {
    docker: "ubuntu:22.04"
  }
}
