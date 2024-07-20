# To Run this project Using Docker

### Build docker image:
` docker build -t pyspark-app .
`
### Build docker Container and run the job:
`docker run -v $(pwd)/Metrics:/app/Metrics pyspark-app`
