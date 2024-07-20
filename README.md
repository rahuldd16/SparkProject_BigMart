# To Run this project Using Docker

### Build docker image:
` docker build -t pyspark-app .
`
### Build docker Container and run the job: 
## In this we have volume mount to get the results file into our local file system.
`docker run -v $(pwd)/Metrics:/app/Metrics pyspark-app`
