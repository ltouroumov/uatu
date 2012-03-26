# UATU (File system observer)
This script was developed for personnal use. It's not bug free but it works for me.

## Usage

The script must be invoked with either a command or a script to run:

	$ uatu -s update.sh
	Watcher started

	$ uatu -c "echo 'Hello'"
	...

The script will notify upon changes and trigger the script/command.
You can also specify a directory to watch (if the script isn't in the same dir)

	$ uatu -s update.sh -b ./src
	...

You can also specify a time interval between triggers (to prevent overkill trigger)

	$ uatu -s update.sh -w 5

Will wait 5 seconds for the next update