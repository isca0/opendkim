#### Opendkim Milter in Docker
  
This project is a Docker container to run opendkim milter for mailservers  
such as postfix...   
  
If you are looking for a very simple way to use opendkim?  
> You just found! :wink:  
  
  
#### Getting the container  
  
This is a very small container with 12MB(virtual), based on Alpine:3.7  
  
```
$ docker pull isca/opendkim
```
  
#### Using this container  
  
Fast way to run:  
  
```
$ docker run -p 8891:8891 isca/opendkim:latest
```
  
Using local mapped keys and set a volume:  
  
```
$ docker run -p 8891:8891 -v ${PWD}/mykeysfolder:/etc/opendkim/keys -e domain="mydomain.com" -e selector="mydomain" -e "keyfile=/etc/opendkim/keys/myprivatekey.private" isca/opendkim
```
This way the local folder `mykeyfoler` will be mounted as opendkim `keys` folder, this folder  
must contain a valid opendkim private key, in this example called `myprivatekey.private`.  
If you are running for the first time and don't specify any private key, than this container  
will generate one for you, and display on stdout. It will also generate the key on the specified  
volume directory.  
You must keep in mind the opendkim is running as opendkim user inside the container, and if you  
pass your private key, the volume folder will be owned by the uid `100`, the private will have  
the permissions setted to `u=rw,g=r` a.k.a `640`.  
  
  
Running with internal specified hosts:  
  
```
$ docker run -p 8891:8891 -v ${PWD}/mykeysfolder:/etc/opendkim/keys -e selector="mydomain" -e domain="mydomain.com" -e "myprivatekey.private" -e inthosts="192.168.0.0/24 10.0.0.0/8" isca/opendkim  
```
This way is the most custom way to run this container, here you are specifing a list of internal hosts  
wich can communicate with opendkim. By default this environment is `0.0.0.0/0`, but in most cases you'll  
only need to care with this, when running in host mode with `--network host` option.  
  
#### Environments  
  
The full list of environments is:  
  
  * domain: yourdomain.com   
  Use to specify your domain.  

  * selector: yourdomain  
  Here you specify the dkim selector to be used. Normally it will be your domain name, but can be  
  any name you want, if not set by default will be `example`.  
    
  * keyfile: somepath   
  Specify the path for your private key. Must be the full path for container.  
  e.g:  
  If you have a file `mypk.key` on local folder `myfolder` you must mount `myfolder`  
  as opendkim `keys` folder and specify the `keyfile=/etc/opendkim/keys/mypk.key`.  
  By the way, when the container start `myfolder` will be owned by uid `100`.  
  
  ```
  $ docker run -p 8891:8891 -v ${PWD}/myfolder:/etc/opendkim/keys -e selector="mydomain" -e domain="mydomain.com" -e keyfile="/etc/opendkim/keys/mypk.key" -e mydomain.com isca/opendkim
  ```
  
  * inthosts: 192.168.0.0/24 10.0.0.2  
  Specify your internal hosts separated with spaces and protect with double quotes `"`.  
  
#### License  
GPL-v3  
  
#### Author  
  
Igor Brandao [isca](isca.space)  
  
Hope you Enjoy... :wink:  
  
