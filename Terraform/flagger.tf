# provider "helm" {
#   kubernetes {
#     config_path = "~/.kube/config"
#   }
# }

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
# }

# resource "helm_release" "nginx_ingress" {
#   name       = "nginx-ingress"
#   repository = "https://kubernetes.github.io/ingress-nginx"
#   chart      = "ingress-nginx"
#   namespace  = "ingress-nginx"
#   create_namespace = true
# }

# resource "helm_release" "prometheus" {
#   name       = "prometheus"
#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart      = "prometheus"
#   namespace  = "monitoring"
#   create_namespace = true
# }
