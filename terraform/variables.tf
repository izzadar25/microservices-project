variable "cluster_name" {
  description = "Name of the local kind Kubernetes cluster"
  type        = string
  default     = "microservices-cluster"
}

variable "kubernetes_version" {
  description = "kind node image tag (Kubernetes version) - see https://github.com/kubernetes-sigs/kind/releases"
  type        = string
  default     = "v1.29.2"
}

variable "worker_node_count" {
  description = "Number of worker nodes in addition to the control-plane node"
  type        = number
  default     = 1
}

variable "kubeconfig_path" {
  description = "Path where the kubeconfig for this cluster will be written"
  type        = string
  default     = "~/.kube/config-microservices-cluster"
}

variable "ingress_host_port" {
  description = "Host port mapped to the control-plane node's port 80, for future ingress use"
  type        = number
  default     = 8080
}
