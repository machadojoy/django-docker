#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

python manage.py makemigrations --no-input
python manage.py migrate --no-input
python manage.py collectstatic --no-input

gunicorn skeletonProject.wsgi:application --bind 0.0.0.0:8000

celery -A skeletonProject worker -l info