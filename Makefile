PREFIX = /usr/local

i3-master-stack:
	@PY3BIN=$(command -v python3)
	printf "${PY3BIN}"
	@printf "Checking for i3ipc..."
	@pip list 2>/dev/null | grep 'i3ipc' > /dev/null && printf "done\n" || printf "\033[31mPlease install the 'i3ipc' pip module.\n"
	@printf "Checking for python3..."
	@command -v python3 > /dev/null && printf "done\n\033[0;32mReady to install! Run 'make install' to install the program.\n "

install:
	sed -i "1 s/^/${PY3BIN}/" master-stack
	sed -i "1 s/^/${PY3BIN}/" swapper
	install -Dm755 ./master-stack "${DESTDIR}${PREFIX}/bin/master-stack"
	install -Dm755 ./swapper "${DESTDIR}${PREFIX}/bin/swapper"

clean:
	rm -f ${DESTDIR}${PREFIX}/bin/master-stack
	rm -f ${DESTDIR}${PREFIX}/bin/swapper

.PHONY: i3-master-stack install clean