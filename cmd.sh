#!/bin/bash
trap 'exit' ERR # stops the execution of the script if a command or pipeline has an error

# exec command is used in order to avoid creating a new process,
# which ensures any signals (such as SIGTERM) are received by our uwsgi process rather than
# being swallowed by the parent process

if [ "$ENV" = 'DEV' ]; then
  echo "Running Development Server"
  exec python "identidock.py"
else
  echo "Running Production Server"
  exec uwsgi --http 0.0.0.0:9090 --wsgi-file /app/identidock.py --callable app --stats 0.0.0.0:9191
fi
