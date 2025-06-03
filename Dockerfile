# Use the official Python 3 image as the base image
FROM python:3.12-slim

# Set the working directory to /app
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the required packages
RUN pip install -r requirements.txt

# Copy the project files into the container
COPY . .

# Expose the port that the server will listen on
EXPOSE 8000

# Set the environment variables
ENV DEBUG=False
ENV ALLOWED_HOSTS=0.0.0.0
ENV STATIC_ROOT=

# Run the command to start the server when the container starts
CMD ["gunicorn", "vex_tournament.wsgi:application", "--bind", "0.0.0.0:8000"]
