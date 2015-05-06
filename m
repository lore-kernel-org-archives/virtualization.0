From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: [PATCH RFC 6/7] vhost-net: tell tap backend about the vnet endianness
Date: Wed, 06 May 2015 14:08:17 +0200
Message-ID: <20150506120817.8607.88016.stgit@bahia.huguette.org>
References: <20150506120729.8607.23404.stgit@bahia.huguette.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150506120729.8607.23404.stgit@bahia.huguette.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The default behaviour for TAP/MACVTAP is to consider vnet as native endian.

This patch handles the cases when this is not true:
- virtio 1.0: always little-endian
- legacy cross-endian

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 hw/net/vhost_net.c |   33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index cf23335..1884e59 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -38,6 +38,7 @@
 #include "standard-headers/linux/virtio_ring.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/virtio-access.h"
 
 struct vhost_net {
     struct vhost_dev dev;
@@ -194,6 +195,27 @@ static void vhost_net_set_vq_index(struct vhost_net *net, int vq_index)
     net->dev.vq_index = vq_index;
 }
 
+static int vhost_net_set_vnet_endian(VirtIODevice *dev, NetClientState *peer,
+                                     bool set)
+{
+    int r = 0;
+
+    if (virtio_has_feature(dev, VIRTIO_F_VERSION_1) ||
+        (virtio_legacy_is_cross_endian(dev) && !virtio_is_big_endian(dev))) {
+        r = qemu_set_vnet_le(peer, set);
+        if (r) {
+            error_report("backend does not support LE vnet headers");
+        }
+    } else if (virtio_legacy_is_cross_endian(dev)) {
+        r = qemu_set_vnet_be(peer, set);
+        if (r) {
+            error_report("backend does not support BE vnet headers");
+        }
+    }
+
+    return r;
+}
+
 static int vhost_net_start_one(struct vhost_net *net,
                                VirtIODevice *dev)
 {
@@ -304,6 +326,11 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
         goto err;
     }
 
+    r = vhost_net_set_vnet_endian(dev, ncs[0].peer, true);
+    if (r < 0) {
+        goto err;
+    }
+
     for (i = 0; i < total_queues; i++) {
         vhost_net_set_vq_index(get_vhost_net(ncs[i].peer), i * 2);
     }
@@ -311,7 +338,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
     r = k->set_guest_notifiers(qbus->parent, total_queues * 2, true);
     if (r < 0) {
         error_report("Error binding guest notifier: %d", -r);
-        goto err;
+        goto err_endian;
     }
 
     for (i = 0; i < total_queues; i++) {
@@ -333,6 +360,8 @@ err_start:
         fprintf(stderr, "vhost guest notifier cleanup failed: %d\n", e);
         fflush(stderr);
     }
+err_endian:
+    vhost_net_set_vnet_endian(dev, ncs[0].peer, false);
 err:
     return r;
 }
@@ -355,6 +384,8 @@ void vhost_net_stop(VirtIODevice *dev, NetClientState *ncs,
         fflush(stderr);
     }
     assert(r >= 0);
+
+    assert(vhost_net_set_vnet_endian(dev, ncs[0].peer, false) >= 0);
 }
 
 void vhost_net_cleanup(struct vhost_net *net)
