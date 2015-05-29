require "spec_helper"

describe command("env 'x=() { :;}; echo vulnerable' 'BASH_FUNC_x()=() { :;}; echo vulnerable' bash -c \"echo test\" 2>&1 | grep 'vulnerable'") do
  its(:stdout) { should_not match(/vulnerable/) }
end

describe command("(shellshocker=\"() { x() { _;}; x() { _;} <<a; }\" bash -c date 2>/dev/null || echo vulnerable) | grep 'vulnerable'") do
  its(:stdout) { should_not match(/vulnerable/) }
end

describe command("(cd /tmp; rm -f /tmp/echo; env X='() { (a)=>\' bash -c \"echo echo nonvuln\" 2>/dev/null; [[ \"$(cat echo 2> /dev/null)\" == \"nonvuln\" ]] && echo vulnerable 2> /dev/null) | grep 'vulnerable'") do
  its(:stdout) { should_not match(/vulnerable/) }
end

describe command("(bash -c 'true <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF <<EOF' 2>/dev/null || echo 'vulnerable') | grep 'vulnerable'") do
  its(:stdout) { should_not match(/vulnerable/) }
end

describe command("bash -c '((for x in {1..200}; do echo \"for x$x in ; do :\"; done; for x in {1..200}; do echo done; done) | bash || echo vulnerable) | grep vulnerable)'") do
  its(:stdout) { should_not match(/vulnerable/) }
end

describe command("env X=' () { }; echo vulnerable' bash -c 'date' | grep 'vulnerable'") do
  its(:stdout) { should_not match(/vulnerable/) }
end
