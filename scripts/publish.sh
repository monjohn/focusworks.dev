#!/bin/bash
mix serum.build
scp -r site/\* do-deploy:/var/www/focusworks.dev/html