#!/bin/bash

cd "$(dirname "$0")"

export templdpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

echo "Starting server PRESS CTRL-C to exit"

# Tip: Make a local copy of this script to avoid it being overwritten by steam.
# NOTE: Minimum password length is 5 characters & Password cant be in the server name.
# NOTE: You need to make sure the ports 2456-2458 is being forwarded to your server through your local router & firewall.
./valheim_server.x86_64 -name "BonkTown" -port 2456 -world "BonkTown" -password "buttstuff42069" -logFile log.txt -savedir /home/steam/valheim/save_data -public 0 -modifier raids less -modifier resources muchmore -modifier portals casual -modifier deathpenalty casual -modifier combat easy &
server_pid=$!

echo "$server_pid"

export LD_LIBRARY_PATH=$templdpath
# Function to catch signals and forward them
stop_server() {
    echo "Stopping Valheim server gracefully..."
    kill -SIGINT "$server_pid"
    wait "$server_pid"
    exit 0
}

trap stop_server SIGTERM SIGINT

# Wait for the server process to finish
wait "$server_pid"

