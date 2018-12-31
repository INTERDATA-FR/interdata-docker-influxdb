include params

build: build-influxdb

build-latest: build-influxdb-latest

build-influxdb:
	@echo "======================================================================"
	@echo "  ____  _    _ _____ _      _____  "
	@echo " |  _ \| |  | |_   _| |    |  __ \ "
	@echo " | |_) | |  | | | | | |    | |  | |"
	@echo " |  _ <| |  | | | | | |    | |  | |"
	@echo " | |_) | |__| |_| |_| |____| |__| |"
	@echo " |____/ \____/|_____|______|_____/ "
	@echo "                                   "
	@echo " Docker image - $(INFLUXDB_IMAGE_NAME):$(INFLUXDB_IMAGE_TAG)"
	@echo "======================================================================"
	docker build \
		--build-arg UBUNTU_IMAGE=$(UBUNTU_IMAGE) \
		--build-arg INFLUXDB_IMAGE=$(INFLUXDB_IMAGE_VERSION) \
		-t $(INFLUXDB_IMAGE_NAME):$(INFLUXDB_IMAGE_TAG) \
		.

rebuild: destroy clean-all build start

restart:
	@echo "============================================================"
	@echo "DOCKER RESTART - $(DOCKER_FILE)"
	@echo "============================================================"
	docker-compose -f $(DOCKER_FILE) restart

start:
	@echo "============================================================"
	@echo "DOCKER START - $(DOCKER_FILE)"
	@echo "============================================================"
	docker-compose -f $(DOCKER_FILE) up -d

stop:
	@echo "============================================================"
	@echo "DOCKER STOP - $(DOCKER_FILE)"
	@echo "============================================================"
	docker-compose -f $(DOCKER_FILE) stop
