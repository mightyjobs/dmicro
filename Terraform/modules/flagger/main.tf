
# modules/flagger/main.tf

# Helm Release for Flagger
resource "helm_release" "flagger" {
  name       = "flagger"
  repository = "https://flagger.app"
  chart      = "flagger"
  namespace  = "flagger-system"
  create_namespace = true

  set {
    name  = "meshProvider"
    value = "nginx"
  }

  set {
    name  = "metricsServer"
    value = "http://prometheus:9090"
  }

  depends_on = [var.aks_ready]  # This ensures Flagger waits for AKS
}

# Helm Release for NGINX Ingress Controller
resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"
  create_namespace = true

  depends_on = [var.aks_ready]  # NGINX depends on AKS
}

# Helm Release for Prometheus
resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  namespace  = "monitoring"
  create_namespace = true

  depends_on = [var.aks_ready]  # Prometheus depends on AKS
}

# Variables
variable "aks_ready" {
  description = "Signal that AKS is ready for Helm deployments"
  type        = bool
}


# resource "helm_release" "flagger" {
#   name       = "flagger"
#   repository = "https://flagger.app"
#   chart      = "flagger"
#   namespace  = "flagger-system"
#   create_namespace = true

#   set {
#     name  = "meshProvider"
#     value = "nginx"
#   }

#   set {
#     name  = "metricsServer"
#     value = "http://prometheus:9090"
#   }

#   depends_on = [module.aks]
# }

# resource "helm_release" "nginx_ingress" {
#   name       = "nginx-ingress"
#   repository = "https://kubernetes.github.io/ingress-nginx"
#   chart      = "ingress-nginx"
#   namespace  = "ingress-nginx"
#   create_namespace = true

#   depends_on = [module.aks]
# }

# resource "helm_release" "prometheus" {
#   name       = "prometheus"
#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart      = "prometheus"
#   namespace  = "monitoring"
#   create_namespace = true

#   depends_on = [module.aks]
# }

# # Variables
# variable "aks_ready" {
#   description = "Signal that AKS is ready for Helm deployments"
#   type        = bool
# }