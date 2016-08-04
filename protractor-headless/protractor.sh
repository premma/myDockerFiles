#!/bin/bash
cd "$1"
CHROME_DEVEL_SANDBOX="" xvfb-run --server-args='-screen 0 1280x1024x24' protractor $2

