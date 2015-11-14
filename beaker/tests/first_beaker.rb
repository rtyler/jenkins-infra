test_name "some test"

step "Make sure the service restarts properly"
hosts.each do |host|
  install_pe
end
