tagversion=v1.0
git reset --hard origin/master 
git pull 
chmod a+x onekey-docker.sh 
gradle clean && gradle build -x test 
docker build -t 10.19.13.18:5000/ch-route-web:${tagversion} .   
docker push 10.19.13.18:5000/ch-route-web:${tagversion} 

docker rmi aioptapp/ch-route-web:${tagversion} 
docker tag 10.19.13.18:5000/ch-route-web:${tagversion} aioptapp/ch-route-web:${tagversion} 
docker login --username=aioptapp --password=aioptapp@123 --email=wuzhen3@asiainfo.com 
docker push aioptapp/ch-route-web:${tagversion} 
