[
    {
      "name": "${domain}-container-${environment}",
      "image": "${container_image}",
      "essential": true,
      "cpu": 256,
      "memory": 512,
      "portMappings": [
        {
          "containerPort": ${container_port},
          "protocol": "tcp"
        }
      ],
      "environment": [
        { "name": "Name", "value": "${domain}-container-${environment}" },
        { "name": "ENV", "value": "${environment}" }
      ],
      "healthCheck": {
        "command": ["CMD-SHELL", "curl -f http://localhost:3000/health-check || exit 1"],
        "interval": 30,
        "timeout": 10,
        "retries": 3,
        "startPeriod": 10
      }
    }
]