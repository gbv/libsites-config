info:
	@echo "'make clean' removes all untracked and ignored files."
	@echo "'make dirs' creates (empty) directories as listed in isil.csv."

dirs:
	@xargs mkdir -p < isil.csv

clean:
	@git clean -xdf
