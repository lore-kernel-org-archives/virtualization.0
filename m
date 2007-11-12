From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Change virtio_pci to use a shared memory area for config
Date: Mon, 12 Nov 2007 18:51:09 +1100
Message-ID: <200711121851.09207.rusty@rustcorp.com.au>
References: <11947379652062-git-send-email-aliguori@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11947379652062-git-send-email-aliguori@us.ibm.com>
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
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Dor Laor <dor.laor@qumranet.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sunday 11 November 2007 10:39:25 Anthony Liguori wrote:
> This patch changes virtio_pci to use a shared memory area for virtio config
> info instead of using the PCI configuration space.  This is closer
> semantically to what the virtio API exposes and is it a lot easier to
> implement on both ends.

No it's not!

Does this help illuminate your path?

Cheers,
Rusty.
BTW: Am switching back to a patchqueue... it's just easier.
==
Simplify virtio configuration further: use structs

Instead of using constants for offsets, and documenting sizes, we can
actually expost them as a structure representation.  This is clearer,
and easier for the host to implement.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 07f7ae8105c8 Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c	Mon Nov 12 17:44:21 2007 +1100
+++ b/Documentation/lguest/lguest.c	Mon Nov 12 18:47:48 2007 +1100
@@ -35,6 +35,7 @@
 #include <assert.h>
 #include <sched.h>
 #include <limits.h>
+#include <stddef.h>
 #include "linux/lguest_launcher.h"
 #include "linux/virtio_config.h"
 #include "linux/virtio_net.h"
@@ -184,7 +185,7 @@ static void *_convert(struct iovec *iov,
 #define cpu_to_le64(v64) (v64)
 #define le16_to_cpu(v16) (v16)
 #define le32_to_cpu(v32) (v32)
-#define le64_to_cpu(v32) (v64)
+#define le64_to_cpu(v64) (v64)
 
 /*L:100 The Launcher code itself takes us out into userspace, that scary place
  * where pointers run wild and free!  Unfortunately, like most userspace
@@ -985,7 +986,7 @@ static void handle_input(int fd)
  * number of virtqueue descriptors, then two sets of feature bits, then an
  * array of configuration bytes.  This routine returns the configuration
  * pointer. */
-static void *device_config(const struct device *dev)
+static u8 *device_config(const struct device *dev)
 {
 	return (void *)(dev->desc + 1)
 		+ dev->desc->num_vq * sizeof(struct lguest_vqconfig)
@@ -1081,24 +1082,18 @@ static void add_feature(struct device *d
 	features[bit / CHAR_BIT] |= (1 << (bit % CHAR_BIT));
 }
 
-/* This routine adds a new configuration field to an existing device's
+/* This routine sets the configuration fields for an existing device's
  * descriptor.  It only works for the last device, but that's OK because that's
  * how we use it. */
-static void add_desc_field(struct device *dev, unsigned off, unsigned len,
-			   const void *c)
-{
-	u8 *config = device_config(dev);
-
-	/* Extend the length of the device's config space if needed. */
-	if (off + len > dev->desc->config_len)
-		dev->desc->config_len = off + len;
-
+static void set_config(struct device *dev, unsigned len, const void *conf)
+{
 	/* Check we haven't overflowed our single page. */
-	if (config + dev->desc->config_len > devices.descpage + getpagesize())
+	if (device_config(dev) + len > devices.descpage + getpagesize())
 		errx(1, "Too many devices");
 
-	/* Copy in the config information. */
-	memcpy(config + off, c, len);
+	/* Copy in the config information, and store the length. */
+	memcpy(device_config(dev), conf, len);
+	dev->desc->config_len = len;
 }
 
 /* This routine does all the creation and setup of a new device, including
@@ -1252,7 +1247,7 @@ static void setup_tun_net(const char *ar
 	int netfd, ipfd;
 	u32 ip;
 	const char *br_name = NULL;
-	u8 hwaddr[6];
+	struct virtio_net_config conf;
 
 	/* We open the /dev/net/tun device and tell it we want a tap device.  A
 	 * tap device is like a tun device, only somehow different.  To tell
@@ -1291,11 +1286,11 @@ static void setup_tun_net(const char *ar
 		ip = str2ip(arg);
 
 	/* Set up the tun device, and get the mac address for the interface. */
-	configure_device(ipfd, ifr.ifr_name, ip, hwaddr);
+	configure_device(ipfd, ifr.ifr_name, ip, conf.mac);
 
 	/* Tell Guest what MAC address to use. */
 	add_feature(dev, VIRTIO_NET_F_MAC);
-	add_desc_field(dev, VIRTIO_CONFIG_NET_MAC_F, sizeof(hwaddr), hwaddr);
+	set_config(dev, sizeof(conf), &conf);
 
 	/* We don't need the socket any more; setup is done. */
 	close(ipfd);
@@ -1485,8 +1480,7 @@ static void setup_block_file(const char 
 	struct device *dev;
 	struct vblk_info *vblk;
 	void *stack;
-	u64 cap;
-	unsigned int val;
+	struct virtio_blk_config conf;
 
 	/* This is the pipe the I/O thread will use to tell us I/O is done. */
 	pipe(p);
@@ -1504,19 +1498,18 @@ static void setup_block_file(const char 
 	vblk->fd = open_or_die(filename, O_RDWR|O_LARGEFILE);
 	vblk->len = lseek64(vblk->fd, 0, SEEK_END);
 
-	/* We're going to specify the maximum number of segments, and we
-	 * support barriers. */
-	add_feature(dev, VIRTIO_BLK_F_SEG_MAX);
+	/* We support barriers. */
 	add_feature(dev, VIRTIO_BLK_F_BARRIER);
 
 	/* Tell Guest how many sectors this device has. */
-	cap = cpu_to_le64(vblk->len / 512);
-	add_desc_field(dev, VIRTIO_CONFIG_BLK_F_CAPACITY, sizeof(cap), &cap);
+	conf.capacity = cpu_to_le64(vblk->len / 512);
 
 	/* Tell Guest not to put in too many descriptors at once: two are used
 	 * for the in and out elements. */
-	val = cpu_to_le32(VIRTQUEUE_NUM - 2);
-	add_desc_field(dev, VIRTIO_CONFIG_BLK_F_SEG_MAX, sizeof(val), &val);
+	add_feature(dev, VIRTIO_BLK_F_SEG_MAX);
+	conf.seg_max = cpu_to_le32(VIRTQUEUE_NUM - 2);
+
+	set_config(dev, sizeof(conf), &conf);
 
 	/* The I/O thread writes to this end of the pipe when done. */
 	vblk->done_fd = p[1];
@@ -1535,7 +1528,7 @@ static void setup_block_file(const char 
 	close(vblk->workpipe[0]);
 
 	verbose("device %u: virtblock %llu sectors\n",
-		devices.device_num, cap);
+		devices.device_num, le64_to_cpu(conf.capacity));
 }
 /* That's the end of device setup. */
 
diff -r 07f7ae8105c8 drivers/block/virtio_blk.c
--- a/drivers/block/virtio_blk.c	Mon Nov 12 17:44:21 2007 +1100
+++ b/drivers/block/virtio_blk.c	Mon Nov 12 18:47:48 2007 +1100
@@ -218,7 +218,8 @@ static int virtblk_probe(struct virtio_d
 		blk_queue_ordered(vblk->disk->queue, QUEUE_ORDERED_TAG, NULL);
 
 	/* Host must always specify the capacity. */
-	__virtio_config_val(vdev, VIRTIO_CONFIG_BLK_F_CAPACITY, &cap);
+	__virtio_config_val(vdev, offsetof(struct virtio_blk_config, capacity),
+			    &cap);
 
 	/* If capacity is too big, truncate with warning. */
 	if ((sector_t)cap != cap) {
@@ -231,12 +232,14 @@ static int virtblk_probe(struct virtio_d
 	/* Host can optionally specify maximum segment size and number of
 	 * segments. */
 	err = virtio_config_val(vdev, VIRTIO_BLK_F_SIZE_MAX,
-				VIRTIO_CONFIG_BLK_F_SIZE_MAX, &v);
+				offsetof(struct virtio_blk_config, size_max),
+				&v);
 	if (!err)
 		blk_queue_max_segment_size(vblk->disk->queue, v);
 
 	err = virtio_config_val(vdev, VIRTIO_BLK_F_SEG_MAX,
-				VIRTIO_CONFIG_BLK_F_SEG_MAX, &v);
+				offsetof(struct virtio_blk_config, seg_max),
+				&v);
 	if (!err)
 		blk_queue_max_hw_segments(vblk->disk->queue, v);
 
diff -r 07f7ae8105c8 drivers/net/virtio_net.c
--- a/drivers/net/virtio_net.c	Mon Nov 12 17:44:21 2007 +1100
+++ b/drivers/net/virtio_net.c	Mon Nov 12 18:47:48 2007 +1100
@@ -352,8 +352,9 @@ static int virtnet_probe(struct virtio_d
 
 	/* Configuration may specify what MAC to use.  Otherwise random. */
 	if (vdev->config->feature(vdev, VIRTIO_NET_F_MAC)) {
-		vdev->config->get(vdev, VIRTIO_CONFIG_NET_MAC_F, dev->dev_addr,
-				  dev->addr_len);
+		vdev->config->get(vdev,
+				  offsetof(struct virtio_net_config, mac),
+				  dev->dev_addr, dev->addr_len);
 	} else
 		random_ether_addr(dev->dev_addr);
 
diff -r 07f7ae8105c8 include/linux/virtio_blk.h
--- a/include/linux/virtio_blk.h	Mon Nov 12 17:44:21 2007 +1100
+++ b/include/linux/virtio_blk.h	Mon Nov 12 18:47:48 2007 +1100
@@ -10,12 +10,15 @@
 #define VIRTIO_BLK_F_SIZE_MAX	1	/* Indicates maximum segment size */
 #define VIRTIO_BLK_F_SEG_MAX	2	/* Indicates maximum # of segments */
 
-/* The capacity (in 512-byte sectors).  8 bytes. */
-#define VIRTIO_CONFIG_BLK_F_CAPACITY	0
-/* The maximum segment size. 4 bytes. */
-#define VIRTIO_CONFIG_BLK_F_SIZE_MAX	0x08
-/* The maximum number of segments.  4 bytes. */
-#define VIRTIO_CONFIG_BLK_F_SEG_MAX	0x0A
+struct virtio_blk_config
+{
+	/* The capacity (in 512-byte sectors). */
+	__le64 capacity;
+	/* The maximum segment size (if VIRTIO_BLK_F_SIZE_MAX) */
+	__le32 size_max;
+	/* The maximum number of segments (if VIRTIO_BLK_F_SEG_MAX) */
+	__le32 seg_max;
+} __attribute__((packed));
 
 /* These two define direction. */
 #define VIRTIO_BLK_T_IN		0
diff -r 07f7ae8105c8 include/linux/virtio_net.h
--- a/include/linux/virtio_net.h	Mon Nov 12 17:44:21 2007 +1100
+++ b/include/linux/virtio_net.h	Mon Nov 12 18:47:48 2007 +1100
@@ -13,8 +13,11 @@
 #define VIRTIO_NET_F_TSO6	4
 #define VIRTIO_NET_F_MAC	5
 
-/* The config defining mac address (6 bytes) */
-#define VIRTIO_CONFIG_NET_MAC_F	0
+struct virtio_net_config
+{
+	/* The config defining mac address (if VIRTIO_NET_F_MAC) */
+	__u8 mac[6];
+} __attribute__((packed));
 
 /* This is the first element of the scatter-gather list.  If you don't
  * specify GSO or CSUM features, you can simply ignore the header. */
