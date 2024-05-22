#!/bin/bash

BASE_DIR="/sledge"

find "$BASE_DIR" -type d -exec git config --add safe.directory '{}' \;
