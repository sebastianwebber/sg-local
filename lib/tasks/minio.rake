desc "setup namespace"
task :setup_namespaces do |t|
  ["monitoring", "storage", "stackgres"].each do |ns|
    run "kubectl", "create namespace #{ns}"
  end
end

desc "setup minio buckets"
task :setup_minio, [] => :setup_namespaces do |t, args|
  run_multi %{
    helm install
        --namespace storage
        --set 'buckets[0].name=sg-backups,buckets[0].policy=none,buckets[0].purge=false'
        minio
        minio/minio
  }

  access_key, secret_key = ["accesskey", "secretkey"].map do |k|
    %x[kubectl get secret -n storage -o wide minio -o jsonpath="{.data.#{k}}" | base64 --decode]
  end

  run "kubectl", "create secret generic", "sg-backup-creds", :namespace => "default", "from-literal" => ["accesskey=#{access_key}", "secretkey=#{secret_key}"]
end
