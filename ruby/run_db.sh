#!/bin/bash
docker run --name a9shomework-db -e POSTGRES_DB=blog_db -e POSTGRES_PASSWORD=temp123 -e POSTGRES_USER=applicant -d -p 5432:5432 postgres
