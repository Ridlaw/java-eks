FROM tomcat:latest

# Create a new directory for the .war file
WORKDIR /usr/local/tomcat/webapps

# Copy the .war file from the host machine to the container
COPY target/SampleWebApp.war .

# Remove the default ROOT directory and rename the .war file
RUN rm -rf ROOT && mv SampleWebApp.war ROOT.war

# Expose port 8080 for the Tomcat server
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
