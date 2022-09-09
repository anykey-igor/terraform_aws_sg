variable "rules" {
  description = "Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description'])"
  type        = map(list(any))

  # Protocols (tcp, udp, icmp, all - are allowed keywords) or numbers (from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml):
  # All = -1, IPV4-ICMP = 1, TCP = 6, UDP = 17, IPV6-ICMP = 58
  default = {
    # Consul
    consul-tcp             = [8300, 8300, "tcp", "Consul server"]
    consul-grpc-tcp        = [8502, 8502, "tcp", "Consul gRPC"]
    consul-webui-http-tcp  = [8500, 8500, "tcp", "Consul web UI HTTP"]
    consul-webui-https-tcp = [8501, 8501, "tcp", "Consul web UI HTTPS"]
    consul-dns-tcp         = [8600, 8600, "tcp", "Consul DNS"]
    consul-dns-udp         = [8600, 8600, "udp", "Consul DNS"]
    consul-serf-lan-tcp    = [8301, 8301, "tcp", "Serf LAN"]
    consul-serf-lan-udp    = [8301, 8301, "udp", "Serf LAN"]
    consul-serf-wan-tcp    = [8302, 8302, "tcp", "Serf WAN"]
    consul-serf-wan-udp    = [8302, 8302, "udp", "Serf WAN"]
    # Docker Swarm
    docker-swarm-mngmt-tcp   = [2377, 2377, "tcp", "Docker Swarm cluster management"]
    docker-swarm-node-tcp    = [7946, 7946, "tcp", "Docker Swarm node"]
    docker-swarm-node-udp    = [7946, 7946, "udp", "Docker Swarm node"]
    docker-swarm-overlay-udp = [4789, 4789, "udp", "Docker Swarm Overlay Network Traffic"]
    # DNS
    dns-udp = [53, 53, "udp", "DNS"]
    dns-tcp = [53, 53, "tcp", "DNS"]
    # NTP - Network Time Protocol
    ntp-udp = [123, 123, "udp", "NTP"]
    # Elasticsearch
    elasticsearch-rest-tcp = [9200, 9200, "tcp", "Elasticsearch REST interface"]
    elasticsearch-java-tcp = [9300, 9300, "tcp", "Elasticsearch Java interface"]
    # Grafana
    grafana-tcp = [3000, 3000, "tcp", "Grafana Dashboard"]
    # HTTP
    http-80-tcp   = [80, 80, "tcp", "HTTP"]
    http-8080-tcp = [8080, 8080, "tcp", "HTTP"]
    # HTTPS
    https-443-tcp  = [443, 443, "tcp", "HTTPS"]
    https-8443-tcp = [8443, 8443, "tcp", "HTTPS"]
    # Kibana
    kibana-tcp = [5601, 5601, "tcp", "Kibana Web Interface"]
    # Kubernetes
    kubernetes-api-tcp = [6443, 6443, "tcp", "Kubernetes API Server"]
    # Logstash
    logstash-tcp = [5044, 5044, "tcp", "Logstash"]
    # Memcached
    memcached-tcp = [11211, 11211, "tcp", "Memcached"]
    # MongoDB
    mongodb-27017-tcp = [27017, 27017, "tcp", "MongoDB"]
    mongodb-27018-tcp = [27018, 27018, "tcp", "MongoDB shard"]
    mongodb-27019-tcp = [27019, 27019, "tcp", "MongoDB config server"]
    # MySQL
    mysql-tcp = [3306, 3306, "tcp", "MySQL/Aurora"]
    # MSSQL Server
    mssql-tcp           = [1433, 1433, "tcp", "MSSQL Server"]
    mssql-udp           = [1434, 1434, "udp", "MSSQL Browser"]
    mssql-analytics-tcp = [2383, 2383, "tcp", "MSSQL Analytics"]
    mssql-broker-tcp    = [4022, 4022, "tcp", "MSSQL Broker"]
    # Nomad
    nomad-http-tcp = [4646, 4646, "tcp", "Nomad HTTP"]
    nomad-rpc-tcp  = [4647, 4647, "tcp", "Nomad RPC"]
    nomad-serf-tcp = [4648, 4648, "tcp", "Serf"]
    nomad-serf-udp = [4648, 4648, "udp", "Serf"]
    # PostgreSQL
    postgresql-tcp = [5432, 5432, "tcp", "PostgreSQL"]
    # Prometheus
    prometheus-http-tcp             = [9090, 9090, "tcp", "Prometheus"]
    prometheus-pushgateway-http-tcp = [9091, 9091, "tcp", "Prometheus Pushgateway"]
    # RabbitMQ
    rabbitmq-4369-tcp  = [4369, 4369, "tcp", "RabbitMQ epmd"]
    rabbitmq-5671-tcp  = [5671, 5671, "tcp", "RabbitMQ"]
    rabbitmq-5672-tcp  = [5672, 5672, "tcp", "RabbitMQ"]
    rabbitmq-15672-tcp = [15672, 15672, "tcp", "RabbitMQ"]
    rabbitmq-25672-tcp = [25672, 25672, "tcp", "RabbitMQ"]
    # Redis
    redis-tcp = [6379, 6379, "tcp", "Redis"]
    # SMTP
    smtp-tcp                 = [25, 25, "tcp", "SMTP"]
    smtp-submission-587-tcp  = [587, 587, "tcp", "SMTP Submission"]
    smtp-submission-2587-tcp = [2587, 2587, "tcp", "SMTP Submission"]
    smtps-465-tcp            = [465, 465, "tcp", "SMTPS"]
    smtps-2456-tcp           = [2465, 2465, "tcp", "SMTPS"]
    # Squid
    squid-proxy-tcp = [3128, 3128, "tcp", "Squid default proxy"]
    # SSH
    ssh-tcp = [22, 22, "tcp", "SSH"]
    # Zabbix
    zabbix-server = [10051, "tcp", "Zabbix Server"]
    zabbix-proxy  = [10051, "tcp", "Zabbix Proxy"]
    zabbix-agent  = [10050, "tcp", "Zabbix Agent"]
    # Open all ports & protocols
    all-all       = [-1, -1, "-1", "All protocols"]
    all-tcp       = [0, 65535, "tcp", "All TCP ports"]
    all-udp       = [0, 65535, "udp", "All UDP ports"]
    all-icmp      = [-1, -1, "icmp", "All IPV4 ICMP"]
    all-ipv6-icmp = [-1, -1, 58, "All IPV6 ICMP"]
    # This is a fallback rule to pass to lookup() as default. It does not open anything, because it should never be used.
    _ = ["", "", ""]
  }
}

variable "auto_groups" {
  description = "Map of groups of security group rules to use to generate modules (see update_groups.sh)"
  type        = map(map(list(string)))

  # Valid keys - ingress_rules, egress_rules, ingress_with_self, egress_with_self
  default = {
    consul = {
      ingress_rules     = ["consul-tcp", "consul-grpc-tcp", "consul-webui-http-tcp", "consul-webui-https-tcp", "consul-dns-tcp", "consul-dns-udp", "consul-serf-lan-tcp", "consul-serf-lan-udp", "consul-serf-wan-tcp", "consul-serf-wan-udp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    docker-swarm = {
      ingress_rules     = ["docker-swarm-mngmt-tcp", "docker-swarm-node-tcp", "docker-swarm-node-udp", "docker-swarm-overlay-udp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    elasticsearch = {
      ingress_rules     = ["elasticsearch-rest-tcp", "elasticsearch-java-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    grafana = {
      ingress_rules     = ["grafana-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    http-80 = {
      ingress_rules     = ["http-80-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    http-8080 = {
      ingress_rules     = ["http-8080-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    https-443 = {
      ingress_rules     = ["https-443-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    https-8443 = {
      ingress_rules     = ["https-8443-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    kubernetes-api = {
      ingress_rules     = ["kubernetes-api-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    kibana = {
      ingress_rules     = ["kibana-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    logstash = {
      ingress_rules     = ["logstash-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    memcached = {
      ingress_rules     = ["memcached-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    mongodb = {
      ingress_rules     = ["mongodb-27017-tcp", "mongodb-27018-tcp", "mongodb-27019-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    mysql = {
      ingress_rules     = ["mysql-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    mssql = {
      ingress_rules     = ["mssql-tcp", "mssql-udp", "mssql-analytics-tcp", "mssql-broker-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    nomad = {
      ingress_rules     = ["nomad-http-tcp", "nomad-rpc-tcp", "nomad-serf-tcp", "nomad-serf-udp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    postgresql = {
      ingress_rules     = ["postgresql-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    ntp = {
      ingress_rules     = ["ntp-udp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    prometheus = {
      ingress_rules     = ["prometheus-http-tcp", "prometheus-pushgateway-http-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    rabbitmq = {
      ingress_rules     = ["rabbitmq-4369-tcp", "rabbitmq-5671-tcp", "rabbitmq-5672-tcp", "rabbitmq-15672-tcp", "rabbitmq-25672-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    redis = {
      ingress_rules     = ["redis-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    smtp = {
      ingress_rules     = ["smtp-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    smtp-submission = {
      ingress_rules     = ["smtp-submission-587-tcp", "smtp-submission-2587-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    smtps = {
      ingress_rules     = ["smtps-465-tcp", "smtps-2465-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    ssh = {
      ingress_rules     = ["ssh-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    web = {
      ingress_rules     = ["http-80-tcp", "http-8080-tcp", "https-443-tcp", "web-jmx-tcp"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
    zabbix = {
      ingress_rules     = ["zabbix-server", "zabbix-proxy", "zabbix-agent"]
      ingress_with_self = ["all-all"]
      egress_rules      = ["all-all"]
    }
  }
}
