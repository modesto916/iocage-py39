ZPOOL=""
SERVER=""
PYTHON?=/usr/local/bin/python3.9

depends:
	@(pkg -vv | grep -e "url.*/latest") > /dev/null 2>&1 || (echo "It is advised pkg url is using \"latest\" instead of \"quarterly\" in /etc/pkg/FreeBSD.conf.";)
	@test -s ${PYTHON} || (echo "Python binary ${PYTHON} not found, iocage will install python39"; pkg install -q -y python39)
	pkg install -q -y py39-libzfs
	${PYTHON} -m ensurepip
	${PYTHON} -m pip install -Ur requirements.txt

install: depends
	${PYTHON} setup.py install 
uninstall:
	${PYTHON} -m pip uninstall -y iocage-lib iocage-cli
test:
	pytest --zpool $(ZPOOL) --server $(SERVER)
help:
	@echo "    install"
	@echo "        Installs iocage"
	@echo "    uninstall"
	@echo "        Removes iocage"
	@echo "    test"
	@echo "        Run unit tests with pytest"
