From: Dor Laor <dor.laor@gmail.com>
Subject: [kvm-devel] [Virtio-for-kvm] [PATCH 2/13] [Mostly resend] virtio
 additions
Date: Fri, 21 Dec 2007 17:17:14 +0200
Message-ID: <476BD8FA.80805__245.37294307283$1198250371$gmane$org@qumranet.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>Anthony Liguori <a>
List-Id: virtualization@lists.linuxfoundation.org

 From 2334d90a3b9f8b9207163e9e0fad714e88a28771 Mon Sep 17 00:00:00 2001
From: Rusty Russell <rusty@rustcorp.com.au>
Date: Wed, 7 Nov 2007 21:02:22 +1100
Subject: [PATCH] virtio: An entropy device, as suggested by hpa.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 Documentation/lguest/lguest.c       |   53 +++++++++++++++
 drivers/char/hw_random/Kconfig      |   10 +++
 drivers/char/hw_random/Makefile     |    1 +
 drivers/char/hw_random/virtio-rng.c |  124 
+++++++++++++++++++++++++++++++++++
 include/linux/virtio_rng.h          |    8 ++
 5 files changed, 196 insertions(+), 0 deletions(-)
 create mode 100644 drivers/char/hw_random/virtio-rng.c
 create mode 100644 include/linux/virtio_rng.h

diff --git a/Documentation/lguest/lguest.c b/Documentation/lguest/lguest.c
index 029cc7c..314e977 100644
--- a/Documentation/lguest/lguest.c
+++ b/Documentation/lguest/lguest.c
@@ -41,6 +41,7 @@
 #include "linux/virtio_net.h"
 #include "linux/virtio_blk.h"
 #include "linux/virtio_console.h"
+#include "linux/virtio_rng.h"
 #include "linux/virtio_ring.h"
 #include "asm-x86/bootparam.h"
 /*L:110 We can ignore the 38 include files we need for this program, 
but I do
@@ -1535,6 +1536,54 @@ static void setup_block_file(const char *filename)
 }
 /* That's the end of device setup. */
 
+/* This is the routine which handles console input (ie. stdin). */
+static bool handle_rng_input(int fd, struct device *dev)
+{
+    int len;
+    unsigned int head, in_num, out_num;
+    struct iovec iov[dev->vq->vring.num];
+
+    printf("Got input on rng fd!\n");
+    /* First we need a buffer from the Guests's virtqueue. */
+    head = get_vq_desc(dev->vq, iov, &out_num, &in_num);
+
+    /* If they're not ready for input, stop listening to this file
+     * descriptor.  We'll start again once they add an input buffer. */
+    if (head == dev->vq->vring.num) {
+        printf("But no buffer!\n");
+        return false;
+    }
+
+    if (out_num)
+        errx(1, "Output buffers in rng?");
+
+    /* This is why we convert to iovecs: the readv() call uses them, and so
+     * it reads straight into the Guest's buffer. */
+    len = readv(dev->fd, iov, in_num);
+    /* Tell the Guest about the new input. */
+    add_used_and_trigger(fd, dev->vq, head, len);
+
+    /* Everything went OK! */
+    return true;
+}
+
+static void setup_rng(void)
+{
+    struct device *dev;
+    int fd;
+
+    fd = open_or_die("/dev/urandom", O_RDONLY);
+
+    /* The device responds to return from I/O thread. */
+    dev = new_device("rng", VIRTIO_ID_RNG, fd, handle_rng_input);
+
+    /* The device has one virtqueue, where the Guest places inbufs. */
+    add_virtqueue(dev, VIRTQUEUE_NUM, enable_fd);
+
+    verbose("device %u: rng\n", devices.device_num);
+}
+/* That's the end of device setup. */
+
 /*L:220 Finally we reach the core of the Launcher, which runs the 
Guest, serves
  * its input and output, and finally, lays it to rest. */
 static void __attribute__((noreturn)) run_guest(int lguest_fd)
@@ -1581,6 +1630,7 @@ static struct option opts[] = {
     { "verbose", 0, NULL, 'v' },
     { "tunnet", 1, NULL, 't' },
     { "block", 1, NULL, 'b' },
+    { "rng", 0, NULL, 'r' },
     { "initrd", 1, NULL, 'i' },
     { NULL },
 };
@@ -1648,6 +1698,9 @@ int main(int argc, char *argv[])
         case 'b':
             setup_block_file(optarg);
             break;
+        case 'r':
+            setup_rng();
+            break;
         case 'i':
             initrd_name = optarg;
             break;
diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 2d7cd48..de20022 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -105,3 +105,13 @@ config HW_RANDOM_PASEMI
 
       If unsure, say Y.
 
+config HW_RANDOM_VIRTIO
+    tristate "VirtIO Random Number Generator support"
+    depends on HW_RANDOM && VIRTIO
+    ---help---
+      This driver provides kernel-side support for the virtual Random 
Number
+      Generator hardware.
+
+      To compile this driver as a module, choose M here: the
+      module will be called virtio-rng.  If unsure, say N.
+
diff --git a/drivers/char/hw_random/Makefile 
b/drivers/char/hw_random/Makefile
index c8b7300..b4940dd 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_HW_RANDOM_VIA) += via-rng.o
 obj-$(CONFIG_HW_RANDOM_IXP4XX) += ixp4xx-rng.o
 obj-$(CONFIG_HW_RANDOM_OMAP) += omap-rng.o
 obj-$(CONFIG_HW_RANDOM_PASEMI) += pasemi-rng.o
+obj-$(CONFIG_HW_RANDOM_VIRTIO) += virtio-rng.o
diff --git a/drivers/char/hw_random/virtio-rng.c 
b/drivers/char/hw_random/virtio-rng.c
new file mode 100644
index 0000000..f723cc3
--- /dev/null
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -0,0 +1,124 @@
+/*
+ * Randomness driver for virtio
+ *  Copyright (C) 2007 Rusty Russell IBM Corporation
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  
02110-1301 USA
+ */
+#include <linux/err.h>
+#include <linux/hw_random.h>
+#include <linux/scatterlist.h>
+#include <linux/spinlock.h>
+#include <linux/virtio.h>
+#include <linux/virtio_rng.h>
+
+static struct virtqueue *vq;
+static u32 random_data;
+static bool have_data;
+
+static bool random_recv_done(struct virtqueue *vq)
+{
+    have_data = true;
+
+    /* Don't suppress callbacks: there can't be any more since we
+     * have used up the only buffer. */
+    return true;
+}
+
+static void register_buffer(void)
+{
+    struct scatterlist sg;
+
+    sg_init_one(&sg, &random_data, sizeof(random_data));
+    /* There should always be room for one buffer. */
+    if (vq->vq_ops->add_buf(vq, &sg, 0, 1, &random_data) != 0)
+        BUG();
+    vq->vq_ops->kick(vq);
+}
+
+static int virtio_data_present(struct hwrng *rng)
+{
+    return have_data;
+}
+
+static int virtio_data_read(struct hwrng *rng, u32 *data)
+{
+    BUG_ON(!have_data);
+    *data = random_data;
+
+    have_data = false;
+    register_buffer();
+    return sizeof(*data);
+}
+
+static struct hwrng virtio_hwrng = {
+    .name = "virtio",
+    .data_present = virtio_data_present,
+    .data_read = virtio_data_read,
+};
+
+static int virtrng_probe(struct virtio_device *vdev)
+{
+    int err;
+
+    /* We expect a single virtqueue. */
+    vq = vdev->config->find_vq(vdev, 0, random_recv_done);
+    if (IS_ERR(vq))
+        return PTR_ERR(vq);
+
+    err = hwrng_register(&virtio_hwrng);
+    if (err) {
+        vdev->config->del_vq(vq);
+        return err;
+    }
+
+    register_buffer();
+    return 0;
+}
+
+static void virtrng_remove(struct virtio_device *vdev)
+{
+    hwrng_unregister(&virtio_hwrng);
+    vq->vq_ops->shutdown(vq);
+    vdev->config->del_vq(vq);
+}
+
+static struct virtio_device_id id_table[] = {
+    { VIRTIO_ID_RNG, VIRTIO_DEV_ANY_ID },
+    { 0 },
+};
+
+static struct virtio_driver virtio_rng = {
+    .driver.name =    KBUILD_MODNAME,
+    .driver.owner =    THIS_MODULE,
+    .id_table =    id_table,
+    .probe =    virtrng_probe,
+    .remove =    __devexit_p(virtrng_remove),
+};
+
+static int __init init(void)
+{
+    return register_virtio_driver(&virtio_rng);
+}
+
+static void __exit fini(void)
+{
+    unregister_virtio_driver(&virtio_rng);
+}
+module_init(init);
+module_exit(fini);
+
+MODULE_DEVICE_TABLE(virtio, id_table);
+MODULE_DESCRIPTION("Virtio random number driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio_rng.h b/include/linux/virtio_rng.h
new file mode 100644
index 0000000..331afb6
--- /dev/null
+++ b/include/linux/virtio_rng.h
@@ -0,0 +1,8 @@
+#ifndef _LINUX_VIRTIO_RNG_H
+#define _LINUX_VIRTIO_RNG_H
+#include <linux/virtio_config.h>
+
+/* The ID for virtio_rng */
+#define VIRTIO_ID_RNG    4
+
+#endif /* _LINUX_VIRTIO_RNG_H */
-- 
1.5.3.3
