# Pull base image
FROM 10.19.13.36:5000/tomcat:7.x
MAINTAINER gucl<gucl@asiainfo.com>

RUN sed -i '/\# OS/i JAVA_OPTS="$JAVA_OPTS -server -Xms4096M -Xmx4096M -XX:PermSize=128M -XX:MaxPermSize=256M " '  /opt/tomcat/bin/catalina.sh

# Install tomcat7
RUN rm -rf /opt/tomcat/webapps/* && mkdir /opt/tomcat/webapps/ROOT
# 此处的uac.war 各中心要根据情况自己修改，
# 如仓库中心的为ch-route-web.war
COPY ./build/libs/ch-route-web.war /opt/tomcat/webapps/ROOT/ROOT.war
RUN cd /opt/tomcat/webapps/ROOT && jar -xf ROOT.war && rm -rf /opt/tomcat/webapps/ROOT.war

ADD ./script/start-web.sh /start-web.sh
RUN chmod 755 /*.sh

# Define default command.
CMD ["/start-web.sh"]