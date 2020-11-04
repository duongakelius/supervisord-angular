1. install npm & node
2. run `npm instali`
3. run `ng build --prod` to build angular app in`dist` folder
4. build docker image:
   `docker build -t nginx-angular -f nginx.dev.dockerfile .`
5. run docker as root
   `docker run -p 8080:80 nginx-angular`
6. test supervisord works (with root) by visit `localhost:8080`

### Run with non root user - "appuser"

7. use user `appuser` (uid = 1001) by uncommenting `line 28`
   in `nginx.dev.dockerfile`
8. build docker image again:
   `docker build -t nginx-angular -f nginx.dev.dockerfile .`
9. run docker as appuser
   `docker run -p 8080:80 nginx-angular`
   I got the same error when running in new cluster:
   `Error: Cannot open an HTTP server: socket.error reported errno.EACCES (13)`

# Another approach

1. go to step 4
2. run docker as root in foreground mode
   `docker run -it nginx-angular /bin/bash`
3. run `./start.sh` to start supervisord
4. test supervisord works (with root) by visit `localhost:8080`

### Run with non root user - "appuser"

5. switch to `appuser`
   `su - appuser`
6. run `./start.sh` to start supervisord
7. after granting `appuser` the rights to access supervisord, i got the same error when running in new cluster:
   `Error: Cannot open an HTTP server: socket.error reported errno.EACCES (13)`
