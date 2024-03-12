FROM python:3
RUN apt-get update && apt-get install -y python3-pip
RUN pip install django==3.2  
COPY . .
Expose 8000
RUN python manage.py migrate
CMD ["python","manage.py","runserver","0.0.0.0:8000"]

