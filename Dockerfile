
FROM tomcat 
WORKDIR webapps 
COPY target/SampleWebApp.war  .
RUN rm -rf ROOT && mv SampleWebApp.war ROOT.war
EXPOSE 8080
ENTRYPOINT ["sh", "/usr/local/tomcat/bin/startup.sh"]