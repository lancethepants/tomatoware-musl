include config.mk

tomatoware:toolchain

toolchain:
	./scripts/toolchain.sh

clean:
	rm -rf toolchain
	git clean -fdxq && git reset --hard

toolchain-clean:
	rm -rf toolchain
	rm -rf /opt/tomatoware/$(DESTARCH)-$(FLOAT)-musl
