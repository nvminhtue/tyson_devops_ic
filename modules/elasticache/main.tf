resource "aws_elasticache_subnet_group" "this" {
  name       = "${var.namespace}-subnet-group"
  subnet_ids = var.subnets_ids
}

resource "aws_elasticache_replication_group" "this" {
  replication_group_id = "${var.namespace}-replication-group"

  engine         = local.engine
  engine_version = local.engine_version
  node_type      = local.node_type

  // Redis Cluster mode disabled
  num_cache_clusters         = local.num_cache_clusters
  parameter_group_name       = local.parameter_group_name
  automatic_failover_enabled = false
  at_rest_encryption_enabled = false

  subnet_group_name  = aws_elasticache_subnet_group.this.name
  security_group_ids = var.security_group_ids
}
