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

# Copy the .env file
COPY .env ./.env

# Set the environment variables
ENV ALLOWED_HOSTS=['*']
ENV PATH=$PATH:/app/.env
ENV DEBUG=False


# Collect static files and ensure app is ready
RUN /usr/local/bin/python manage.py collectstatic --noinput
RUN /usr/local/bin/python manage.py makemigrations && /usr/local/bin/python manage.py migrate

# Run the command to start the server when the container starts
CMD ["gunicorn", "vex_tournament.wsgi:application", "--bind", "0.0.0.0:8000"]
