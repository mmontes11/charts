# gotway

Cloud native API Gateway powered with in-redis cache.

- API composition: expose your services to the internet using a single endpoint
- Cloud native: configure routing and cache using [Kubernetes CRDs](./manifests/examples/catalog.yml)
- In-memory cache using redis 
- Cache invalidation using tags
- Health checking
- Management [REST API](#management-rest-api)
- ~6MB [Docker image](https://hub.docker.com/r/gotwaygateway/gotway/tags) available for multiple architectures
- [Helm chart](https://github.com/gotway/charts)

### Installation

```bash
helm repo add mmontes https://charts.mmontes-dev.duckdns.org
helm repo add gotway https://charts.gotway.duckdns.org
helm install redis mmontes/redis
helm install gotway gotway/gotway
```