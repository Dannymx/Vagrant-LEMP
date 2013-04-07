#!/bin/bash

read -p "Synfony project's path ? " project_path
sed -i "s//" project_path/composer.json
sed -i "s//" project_path/app/AppKernel.php
