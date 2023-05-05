Build Images
===
## build controller images
build controller image and push to docker hub
-------
```bash
docker login
cd docker
./prepare.sh
docker build -t matieqiang/ngrinder-controller:3.5.8-statistics ./controller
docker push matieqiang/ngrinder-controller:3.5.8-statistics
```

## build agent images
