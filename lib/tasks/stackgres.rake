SG_VERSION = "1.0.0-alpha4"
UI_PASSWD = "password"

desc "setup stackgres"
task :setup_stackgres, [] do |t, args|
  chart_url = "https://stackgres.io/downloads/stackgres-k8s/stackgres/#{SG_VERSION}/helm/stackgres-operator.tgz"

  str_args = [
    "grafana.webHost=prometheus-grafana.monitoring",
    "grafana.user=admin",
    "grafana.password=prom-operator",
    "adminui.service.type=LoadBalancer",
    "prometheus.allowAutobind=true",
    "authentication.password=#{UI_PASSWD}",
  ]
  run "helm", "install", "stackgres-operator", chart_url, :namespace => "stackgres", "set" => "grafana.enabled=true", "set-string" => str_args
end


desc "deploy the database"
task :deploy_database, [] do |t, args|
  Dir.glob("db-cluster/*.yml").sort_by do |file|
    file
  end.each do |f|
    run "kubectl", "apply", :filename => f
  end
end