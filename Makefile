.PHONY: postgres
postgres:
	docker run --name postgres -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -p 5433:5432 -d postgres:alpine

.PHONY: createdb
createdb:
	docker exec -it postgres createdb --username=root --owner=root simple_bank

.PHONY: dropdb
dropdb:
	docker exec -it postgres dropdb simple_bank

.PHONY: migrate_up
migrate_up:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5433/simple_bank?sslmode=disable" -verbose up

.PHONY: migrate_down
migrate_down:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5433/simple_bank?sslmode=disable" -verbose down
