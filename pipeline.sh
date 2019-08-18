# Set pipeline
fly -t node-app sp -c express-status-monitor/job-node.yml -p build-pipeline

# Unpause pipeline
fly -t node-app up -p build-pipeline

# Trigger job
fly -t node-app tj -j build-pipeline/run-pipeline -w

# Show list of builds
fly -t node-app builds
