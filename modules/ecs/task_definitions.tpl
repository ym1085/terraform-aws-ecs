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
      ]
    }
]