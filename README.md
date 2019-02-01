```
curl https://raw.githubusercontent.com/ARtoriouSs/ostis-docker/master/Dockerfile | docker build --pull --tag ostis --file - .
```

<or>

```
curl https://raw.githubusercontent.com/ARtoriouSs/ostis-docker/master/Dockerfile.noupdate | docker build --pull --tag ostis --file - .
```

```
docker run -p 8000:8000/tcp ostis bash -c "redis-server & cd ostis/scripts/ && ./restart_sctp.sh & cd ostis/scripts/ && ./run_scweb.sh"
```

or

```
docker run -p 8000:8000/tcp ostis bash -c "./run.sh"
```

in new tab

```
docker rm -f $(docker ps -aq)
docker rmi ostis
```
