desc "Creates the kind cluster"
task :create_cluster, [] do |t, args|
  run "kind", "create cluster", :image => "kindest/node:v1.19.11"
end

desc "Destroys the kind cluster and everything else"
task :clean, [] do |t, args|
  run "kind", "delete cluster"
end
