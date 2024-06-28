locals {
  engine               = "redis"
  engine_version       = "6.x"
  parameter_group_name = "default.redis6.x"
  node_type            = "cache.t3.micro"
  num_cache_clusters   = 1
}
