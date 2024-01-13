# Lilipad-Agent

Sidecar process for updating `lilipad_config.json` on a box.

[Docker Hub](https://hub.docker.com/repository/docker/awkwardsandwich7/lilipad-agent/general).

## Quickstart

```
docker build --tag lilipad-agent . 

docker run -p 4567:4567 lilipad-agent
```
