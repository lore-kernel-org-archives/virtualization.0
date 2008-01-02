From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH 1/3] Make virtio modules GPL
Date: Wed,  2 Jan 2008 15:01:32 -0600
Message-ID: <1199307694277-git-send-email-aliguori__2333.26317179507$1199307849$gmane$org@us.ibm.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: kvm-devel@lists.sourceforge.net, Dor Laor <dor.laor@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

The virtio modules do not advertise themselves as GPL but rely on exported
GPL symbols.  This makes them unloadable as modules.

This patch adds the appropriate MODULE_LICENSE().

Signed-off: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 54a8017..8f6040d 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -8,6 +8,8 @@
 
 #define VIRTIO_MAX_SG	(3+MAX_PHYS_SEGMENTS)
 
+MODULE_LICENSE("GPL");
+
 static unsigned char virtblk_index = 'a';
 struct virtio_blk
 {
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ebe4b03..9789e68 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -28,6 +28,8 @@
 static int napi_weight = 128;
 module_param(napi_weight, int, 0444);
 
+MODULE_LICENSE("GPL");
+
 /* FIXME: MTU in config. */
 #define MAX_PACKET_LEN (ETH_HLEN+ETH_DATA_LEN)
 
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 646f716..6e27c08 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -2,6 +2,8 @@
 #include <linux/spinlock.h>
 #include <linux/virtio_config.h>
 
+MODULE_LICENSE("GPL");
+
 static ssize_t device_show(struct device *_d,
 			   struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 951e4c7..15ee2fa 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -20,6 +20,8 @@
 #include <linux/virtio_ring.h>
 #include <linux/device.h>
 
+MODULE_LICENSE("GPL");
+
 #ifdef DEBUG
 /* For development, we want to crash whenever the ring is screwed. */
 #define BAD_RING(vq, fmt...)			\
