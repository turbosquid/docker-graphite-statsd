#!/bin/bash
# Run this on the host to clean out the whisper data. Cleans out daya not written isinc $DAYS ago
DAYS=30
WHISPER_DIR=/mnt/graphite/storage/whisper
find $WHISPER_DIR -type f -mtime +$DAYS -name \*.wsp -delete && \
	find $WHISPER_DIR  -depth -type d -empty -delete
