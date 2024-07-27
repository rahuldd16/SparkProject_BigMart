resource "kubernetes_deployment" "pyspark_app" {
  metadata {
    name = "pyspark-app"
  }
}