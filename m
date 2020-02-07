From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2] tools/virtio: option to build an out of tree module
Date: Fri, 7 Feb 2020 02:35:02 -0500
Message-ID: <20200207073327.1205669-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Handy for testing with distro kernels.
Warn that the resulting module is completely unsupported,
and isn't intended for production use.

Usage:
        make oot # builds vhost_test.ko, vhost.ko
        make oot-clean # cleans out files created

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

changes from v1:
	lots of refactoring
	disable all modules except vhost by default (more of a chance
						     it'll build)
	oot-clean target

 tools/virtio/Makefile | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index 8e2a908115c2..f33f32f1d208 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -8,7 +8,32 @@ CFLAGS += -g -O2 -Werror -Wall -I. -I../include/ -I ../../usr/include/ -Wno-poin
 vpath %.c ../../drivers/virtio ../../drivers/vhost
 mod:
 	${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test V=${V}
-.PHONY: all test mod clean
+
+#oot: build vhost as an out of tree module for a distro kernel
+#no effort is taken to make it actually build or work, but tends to mostly work
+#if the distro kernel is very close to upstream
+#unsupported! this is a development tool only, don't use the
+#resulting modules in production!
+OOT_KSRC=/lib/modules/$$(uname -r)/build
+OOT_VHOST=`pwd`/../../drivers/vhost
+#Everyone depends on vhost
+#Tweak the below to enable more modules
+OOT_CONFIGS=\
+	CONFIG_VHOST=m \
+	CONFIG_VHOST_NET=n \
+	CONFIG_VHOST_SCSI=n \
+	CONFIG_VHOST_VSOCK=n
+OOT_BUILD=KCFLAGS="-I "${OOT_VHOST} ${MAKE} -C ${OOT_KSRC} V=${V}
+oot-build:
+	echo "UNSUPPORTED! Don't use the resulting modules in production!"
+	${OOT_BUILD} M=`pwd`/vhost_test
+	${OOT_BUILD} M=${OOT_VHOST} ${OOT_CONFIGS}
+
+oot-clean: oot-build
+oot: oot-build
+oot-clean: OOT_BUILD+=clean
+
+.PHONY: all test mod clean vhost oot oot-clean oot-build
 clean:
 	${RM} *.o vringh_test virtio_test vhost_test/*.o vhost_test/.*.cmd \
               vhost_test/Module.symvers vhost_test/modules.order *.d
-- 
MST
