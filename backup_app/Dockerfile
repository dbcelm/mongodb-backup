FROM python:3.11

# Install necessary dependencies
RUN pip install django

# Install kubectl (adjust version as needed)
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Set the working directory
WORKDIR /app

# Copy your Django app code into the container
COPY . /app

# Expose the port your Django app will run on
EXPOSE 8000

# Start your Django app
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]