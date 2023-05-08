# Use Tomcat as the base image
FROM tomcat:latest

# Set the working directory
WORKDIR /usr/local/tomcat

# Copy the .war file from the build directory to the webapps directory in Tomcat
COPY target/*.war /usr/local/tomcat/webapps/

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
