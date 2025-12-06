#!/bin/bash
# This script retrieves the Poetry virtual environment path and sources its activate.fish

# Get the Poetry virtual environment path (ensure you're in the project directory with a valid pyproject.toml)
venv=$(poetry env info --path)

# Construct the full path for the activate.fish script
activate_script="$venv/bin/activate.fish"

# Check if the activate.fish file exists and source it if so
if [ -f "$activate_script" ]; then
	echo "Sourcing Poetry environment from: $activate_script"
	source "$activate_script"
else
	echo "Activation script not found at: $activate_script"
fi
