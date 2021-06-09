desc "setup helm repos"
task :setup_helm, [] do |t, args|
  {
    "minio" => "https://helm.min.io/",
    "prometheus-community" => "https://prometheus-community.github.io/helm-charts",
    "stable" => "https://charts.helm.sh/stable",
  }.each do |k, v|
    run "helm", "repo add", k, v
  end

  run "helm", "repo update"
end
