info:
	@echo "'make clean' will remove all untracked and ignored files."

clean:
	@git clean -xdf
