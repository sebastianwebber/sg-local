desc "setup metal lb"
task :setup_metallb, [] do |t, args|
  run_multi %{
    kubectl get configmap kube-proxy -n kube-system -o yaml |
    sed -e "s/strictARP: false/strictARP: true/" |
    kubectl apply -f - -n kube-system
  }

  ["namespace", "metallb"].each do |f|
    run "kubectl", "apply", :filename => "https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/#{f}.yaml"
  end

  secret_key = %x[openssl rand -base64 128]
  run "kubectl", "create secret generic", "memberlist", :namespace => "metallb-system", "from-literal" => "secretkey=#{secret_key}"
  run "kubectl", "apply", :filename => "config/01-lb-config.yaml"
end
