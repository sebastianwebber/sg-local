desc "setup monitoring"
task :setup_monitoring, [] do |t, args|
  run "helm", "install", "prometheus", "prometheus-community/kube-prometheus-stack", :namespace => "monitoring", "set" => "grafana.enabled=true", :version => "12.10.6"
end
