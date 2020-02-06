From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] tools/virtio: option to build an out of tree module
Date: Thu, 6 Feb 2020 03:01:30 -0500
Message-ID: <20200206080125.1178242-1-mst@redhat.com>
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

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/Makefile | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index 8e2a908115c2..94106cde49e3 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -8,7 +8,18 @@ CFLAGS += -g -O2 -Werror -Wall -I. -I../include/ -I ../../usr/include/ -Wno-poin
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
+oot:
+	echo "UNSUPPORTED! Don't use the resulting modules in production!"
+	KCFLAGS="-I "`pwd`/../../drivers/vhost ${MAKE} -C /usr/src/kernels/$$(uname -r) M=`pwd`/vhost_test V=${V}
+	KCFLAGS="-I "`pwd`/../../drivers/vhost ${MAKE} -C /usr/src/kernels/$$(uname -r) M=`pwd`/../../drivers/vhost V=${V} CONFIG_VHOST_VSOCK=n
+
+.PHONY: all test mod clean vhost oot
 clean:
 	${RM} *.o vringh_test virtio_test vhost_test/*.o vhost_test/.*.cmd \
               vhost_test/Module.symvers vhost_test/modules.order *.d
-- 
MST
