output "cluster_name" {
  description = "Name of the provisioned kind cluster"
  value       = kind_cluster.this.name
}

output "kubeconfig_path" {
  description = "Local path to the generated kubeconfig file"
  value       = kind_cluster.this.kubeconfig_path
}

output "endpoint" {
  description = "Kubernetes API server endpoint"
  value       = kind_cluster.this.endpoint
}

output "client_certificate" {
  value     = kind_cluster.this.client_certificate
  sensitive = true
}

output "client_key" {
  value     = kind_cluster.this.client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = kind_cluster.this.cluster_ca_certificate
  sensitive = true
}
