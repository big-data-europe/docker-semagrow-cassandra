FROM semagrow/semagrow:1.5.1

MAINTAINER Yiannis Mouchakis <gmouchakis@iit.demokritos.gr>


RUN cd / && \
    git clone https://github.com/semagrow/semagrow.git && \
    cd semagrow && \
    git checkout tags/1.5.1 && \
    mvn clean install -DskipTests && \
    cd / && \
    git clone https://github.com/semagrow/connector-cassandra.git && \
    cd connector-cassandra && \
    git checkout tags/1.5.1 && \
    mvn clean package && \
    mvn dependency:copy-dependencies && \
    cp target/*.jar $SEMAGROW_HOME/domains/localhost/webapps/SemaGrow/WEB-INF/lib/ && \
    cp target/dependency/*.jar $SEMAGROW_HOME/domains/localhost/webapps/SemaGrow/WEB-INF/lib/ && \
    cd / && \
    rm -r /semagrow && \
    rm -r /connector-cassandra

CMD cp_resources $SEMAGROW_HOME && catalina.sh run
 
