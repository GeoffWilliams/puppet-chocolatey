all:
	bundle exec pdqtest --skip-idempotency all
	bundle exec puppet strings

shell:
	bundle exec pdqtest --keep-container --skip-idempotency acceptance
