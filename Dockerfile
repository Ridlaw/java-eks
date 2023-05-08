# Use the official Tomcat image as the base image
FROM tomcat:latest

# Copy the .war file into the Tomcat webapps directory
COPY target/SampleWebApp.war /usr/local/tomcat/webapps/

# Expose port 8080 (the default Tomcat port)
EXPOSE 8080

ENTRYPOINT ["sh", "/usr/local/tomcat/bin/startup.sh"]
