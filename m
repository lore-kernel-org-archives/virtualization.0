From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Qemu and virtio 1.0
Date: Wed, 25 Feb 2015 14:50:22 +1030
Message-ID: <877fv6mxkp.fsf@rustcorp.com.au>
References: <1417101409-29482-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

OK, I am trying to experiment with virtio 1.0 support using the
latest kernel and MST's qemu tree:

        https://git.kernel.org/cgit/virt/kvm/mst/qemu.git/?h=virtio-1.0

The first issue is that the device config endian was wrong (see
attached patch).

I'm now setting up a BE guest on my x86 laptop, and a BE and LE guest
on a BE powerpc machine, to check that all combinations work correctly.
If others test too, that would be appreciated!

Cheers,
Rusty.

From 95ac91554ed602f856a2a5fcc25eaffcad1b1c8d Mon Sep 17 00:00:00 2001
From: Rusty Russell <rusty@rustcorp.com.au>
Date: Tue, 24 Feb 2015 14:47:44 +1030
Subject: [PATCH] virtio_config_write*/virtio_config_read*: Don't endian swap
 for virtio 1.0.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 079944c..882a31b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -662,7 +662,12 @@ uint32_t virtio_config_readw(VirtIODevice *vdev, uint32_t addr)
 
     k->get_config(vdev, vdev->config);
 
-    val = lduw_p(vdev->config + addr);
+    /* Virtio 1.0 is always LE */
+    if (virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        val = lduw_le_p(vdev->config + addr);
+    } else {
+        val = lduw_p(vdev->config + addr);
+    }
     return val;
 }
 
@@ -677,7 +682,12 @@ uint32_t virtio_config_readl(VirtIODevice *vdev, uint32_t addr)
 
     k->get_config(vdev, vdev->config);
 
-    val = ldl_p(vdev->config + addr);
+    /* Virtio 1.0 is always LE */
+    if (virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        val = ldl_le_p(vdev->config + addr);
+    } else {
+        val = ldl_p(vdev->config + addr);
+    }
     return val;
 }
 
@@ -706,7 +716,12 @@ void virtio_config_writew(VirtIODevice *vdev, uint32_t addr, uint32_t data)
         return;
     }
 
-    stw_p(vdev->config + addr, val);
+    /* Virtio 1.0 is always LE */
+    if (virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        stw_le_p(vdev->config + addr, val);
+    } else {
+        stw_p(vdev->config + addr, val);
+    }
 
     if (k->set_config) {
         k->set_config(vdev, vdev->config);
@@ -722,7 +737,12 @@ void virtio_config_writel(VirtIODevice *vdev, uint32_t addr, uint32_t data)
         return;
     }
 
-    stl_p(vdev->config + addr, val);
+    /* Virtio 1.0 is always LE */
+    if (virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        stl_le_p(vdev->config + addr, val);
+    } else {
+        stl_p(vdev->config + addr, val);
+    }
 
     if (k->set_config) {
         k->set_config(vdev, vdev->config);
