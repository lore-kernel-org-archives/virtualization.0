From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 4/6] virtio: add virtio IDs file
Date: Mon, 21 Sep 2009 16:28:28 +0930
Message-ID: <200909211628.29196.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.osdl.org
Cc: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
List-Id: virtualization@lists.linuxfoundation.org

From: =?UTF-8?B?RmVybmFuZG8gTHVpcyBWw6F6cXVleiBDYW8=?=

Virtio IDs are spread all over the tree which makes assigning new IDs
bothersome. Putting them together should make the process less error-prone.

Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 Documentation/lguest/lguest.c       |    1 +
 drivers/block/virtio_blk.c          |    1 +
 drivers/char/hw_random/virtio-rng.c |    1 +
 drivers/char/virtio_console.c       |    1 +
 drivers/net/virtio_net.c            |    1 +
 drivers/virtio/virtio_balloon.c     |    1 +
 include/linux/virtio_9p.h           |    2 --
 include/linux/virtio_balloon.h      |    3 ---
 include/linux/virtio_blk.h          |    3 ---
 include/linux/virtio_console.h      |    3 ---
 include/linux/virtio_ids.h          |   17 +++++++++++++++++
 include/linux/virtio_net.h          |    3 ---
 include/linux/virtio_rng.h          |    3 ---
 net/9p/trans_virtio.c               |    1 +
 14 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/Documentation/lguest/lguest.c b/Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c
+++ b/Documentation/lguest/lguest.c
@@ -42,6 +42,7 @@
 #include <signal.h>
 #include "linux/lguest_launcher.h"
 #include "linux/virtio_config.h"
+#include <linux/virtio_ids.h>
 #include "linux/virtio_net.h"
 #include "linux/virtio_blk.h"
 #include "linux/virtio_console.h"
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -3,6 +3,7 @@
 #include <linux/blkdev.h>
 #include <linux/hdreg.h>
 #include <linux/virtio.h>
+#include <linux/virtio_ids.h>
 #include <linux/virtio_blk.h>
 #include <linux/scatterlist.h>
 
diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -21,6 +21,7 @@
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
 #include <linux/virtio.h>
+#include <linux/virtio_ids.h>
 #include <linux/virtio_rng.h>
 
 /* The host will fill any buffer we give it with sweet, sweet randomness.  We
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -31,6 +31,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/virtio.h>
+#include <linux/virtio_ids.h>
 #include <linux/virtio_console.h>
 #include "hvc_console.h"
 
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -22,6 +22,7 @@
 #include <linux/ethtool.h>
 #include <linux/module.h>
 #include <linux/virtio.h>
+#include <linux/virtio_ids.h>
 #include <linux/virtio_net.h>
 #include <linux/scatterlist.h>
 #include <linux/if_vlan.h>
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -19,6 +19,7 @@
  */
 //#define DEBUG
 #include <linux/virtio.h>
+#include <linux/virtio_ids.h>
 #include <linux/virtio_balloon.h>
 #include <linux/swap.h>
 #include <linux/kthread.h>
diff --git a/include/linux/virtio_9p.h b/include/linux/virtio_9p.h
--- a/include/linux/virtio_9p.h
+++ b/include/linux/virtio_9p.h
@@ -4,8 +4,6 @@
  * compatible drivers/servers. */
 #include <linux/virtio_config.h>
 
-/* The ID for virtio console */
-#define VIRTIO_ID_9P	9
 /* Maximum number of virtio channels per partition (1 for now) */
 #define MAX_9P_CHAN	1
 
diff --git a/include/linux/virtio_balloon.h b/include/linux/virtio_balloon.h
--- a/include/linux/virtio_balloon.h
+++ b/include/linux/virtio_balloon.h
@@ -4,9 +4,6 @@
  * compatible drivers/servers. */
 #include <linux/virtio_config.h>
 
-/* The ID for virtio_balloon */
-#define VIRTIO_ID_BALLOON	5
-
 /* The feature bitmap for virtio balloon */
 #define VIRTIO_BALLOON_F_MUST_TELL_HOST	0 /* Tell before reclaiming pages */
 
diff --git a/include/linux/virtio_blk.h b/include/linux/virtio_blk.h
--- a/include/linux/virtio_blk.h
+++ b/include/linux/virtio_blk.h
@@ -5,9 +5,6 @@
 #include <linux/types.h>
 #include <linux/virtio_config.h>
 
-/* The ID for virtio_block */
-#define VIRTIO_ID_BLOCK	2
-
 /* Feature bits */
 #define VIRTIO_BLK_F_BARRIER	0	/* Does host support barriers? */
 #define VIRTIO_BLK_F_SIZE_MAX	1	/* Indicates maximum segment size */
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -5,9 +5,6 @@
 /* This header, excluding the #ifdef __KERNEL__ part, is BSD licensed so
  * anyone can use the definitions to implement compatible drivers/servers. */
 
-/* The ID for virtio console */
-#define VIRTIO_ID_CONSOLE	3
-
 /* Feature bits */
 #define VIRTIO_CONSOLE_F_SIZE	0	/* Does host provide console size? */
 
diff --git a/include/linux/virtio_ids.h b/include/linux/virtio_ids.h
new file mode 100644
--- /dev/null
+++ b/include/linux/virtio_ids.h
@@ -0,0 +1,17 @@
+#ifndef _LINUX_VIRTIO_IDS_H
+#define _LINUX_VIRTIO_IDS_H
+/*
+ * Virtio IDs
+ *
+ * This header is BSD licensed so anyone can use the definitions to implement
+ * compatible drivers/servers.
+ */
+
+#define VIRTIO_ID_NET		1 /* virtio net */
+#define VIRTIO_ID_BLOCK		2 /* virtio block */
+#define VIRTIO_ID_CONSOLE	3 /* virtio console */
+#define VIRTIO_ID_RNG		4 /* virtio ring */
+#define VIRTIO_ID_BALLOON	5 /* virtio balloon */
+#define VIRTIO_ID_9P		9 /* 9p virtio console */
+
+#endif /* _LINUX_VIRTIO_IDS_H */
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -6,9 +6,6 @@
 #include <linux/virtio_config.h>
 #include <linux/if_ether.h>
 
-/* The ID for virtio_net */
-#define VIRTIO_ID_NET	1
-
 /* The feature bitmap for virtio net */
 #define VIRTIO_NET_F_CSUM	0	/* Host handles pkts w/ partial csum */
 #define VIRTIO_NET_F_GUEST_CSUM	1	/* Guest handles pkts w/ partial csum */
diff --git a/include/linux/virtio_rng.h b/include/linux/virtio_rng.h
--- a/include/linux/virtio_rng.h
+++ b/include/linux/virtio_rng.h
@@ -4,7 +4,4 @@
  * compatible drivers/servers. */
 #include <linux/virtio_config.h>
 
-/* The ID for virtio_rng */
-#define VIRTIO_ID_RNG	4
-
 #endif /* _LINUX_VIRTIO_RNG_H */
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -43,6 +43,7 @@
 #include <net/9p/transport.h>
 #include <linux/scatterlist.h>
 #include <linux/virtio.h>
+#include <linux/virtio_ids.h>
 #include <linux/virtio_9p.h>
 
 #define VIRTQUEUE_NUM	128
