PREFIX = /usr/local
PY3BIN = $(shell which python3)

i3-master-stack:
	@printf "Checking for i3ipc..."
	@pip list 2>/dev/null | grep 'i3ipc' > /dev/null && printf "\033[0;32mfound\033[0m\n" || printf "\033[31mPlease install the 'i3ipc' pip module.\033[0m\n"
	@printf "Checking for python3..."
	@command -v python3 > /dev/null && printf "\033[0;32mfound\033[0m\n\033[0;32mReady to install! Run 'make install' to install the program.\n" || printf "\033[31mPlease install python3.\n"

install:
	@sed -i "1d" master-stack
	@sed -i "1d" swapper
	@sed -i "1i\\" master-stack
	@sed -i "1i\\" swapper
	@sed -i "1 s|^|#!${PY3BIN}\n|" master-stack
	@sed -i "1 s|^|#!${PY3BIN}\n|" swapper
	install -Dm755 ./master-stack "${DESTDIR}${PREFIX}/bin/master-stack"
	install -Dm755 ./swapper "${DESTDIR}${PREFIX}/bin/swapper"

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/master-stack
	rm -f ${DESTDIR}${PREFIX}/bin/swapper

.PHONY: i3-master-stack install uninstall