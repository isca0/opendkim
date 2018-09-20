#### Opendkim Milter in Docker
  
This project is a Docker container to run opendkim milter for mailservers  
such as postfix...   
  
If you are looking for a very simple way to use opendkim?  
> You just found! :wink:  
  
  
#### Getting the container  
  
This is a very small container with 42MB, based on Alpine:3.7  
  
```
$ docker pull isca0/opendkim
```
  
#### Using this container  
  
Fast way to run:  
  
```
$ docker run -p 8891:8891 isca0/opendkim:latest
```
  
Using local mapped keys and set a volume:  

```
$ docker run -p 8891:8891 -v ./mykeysfolder:/etc/opendkim/keys -e domain="mydomain.com" -e "myprivatekey.private" isca0/opendkim
```
This way the local folder `mykeyfoler` will be mounted as opendkim keys folder. This folder must contain a valid opendkim private key, in this example called `myprivatekey.private`.  
If you are running for the first time and don't specify any private key, than this container will generate one for you and display on the output. And also this generate key will be created on the specified volume folder.  
  
  
Running with internal specified hosts:  
  
```
$ docker run -p 8891:8891 -v ./mykeysfolder:/etc/opendkim/keys -e domain="mydomain.com" -e "myprivatekey.private" -e inthosts="192.168.0.0/24 10.0.0.0/8" isca0/opendkim  
```
This way is the most custom way to run this container, here you are specifing a list of internal hosts   
wich can communicate with opendkim. By default this environment is `0.0.0.0/0`, but in most cases you'll  
only need to care with this, when running in host mode with `--network host` option.  
  
#### Environments  
  
The full list of environments is:  
  
  * domain: yourdomain.com   
  Use to specify your domain.  
    
  * keyfile: somepath   
  Specify the path for your private key.  
    
  * inthosts: 192.168.0.0/24 10.0.0.2   
  Specify your internal hosts separated with spaces and protect with double quotes `"`.  
  
#### License  
GPL-v3  
  
#### Author  
  
Igor Brandao [isca](isca.space)  
  
Hope you Enjoy... :wink:  
  
