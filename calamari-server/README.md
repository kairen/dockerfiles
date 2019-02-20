# Calamari Server on Docker
Run calamari server on docker. 

**Pull the image from Docker Repository：**
```sh
docker pull kairen/docker-calamari-server:1.3.1
```

**Running the image：**
```sh
docker run -d -p 80:80 -p 4505:4505 -p 4506:4506 -ti \
--name calamari-server kairen/docker-calamari-server:1.3.1 -d
```
> if you want to logging calamari, you can using ```bash``` to replace the end of the ```-d``` parameter.
 
Now, open your browser to check calamari server. default accoutn:```admin```, password:```admin```.
