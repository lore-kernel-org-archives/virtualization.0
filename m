From: Dor Laor <dor.laor@gmail.com>
Subject: [PATCH] Increase the tx queue to 512 descriptors to fix
	performance problem.
Date: Wed, 09 Jan 2008 15:23:36 +0200
Message-ID: <1199885016.4382.22.camel__40591.0942391076$1199885124$gmane$org@localhost.localdomain>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain
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
To: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.
List-Id: virtualization@lists.linuxfoundation.org

Now that we have a host timer based tx wakeup it waits for 64
packets or timeout before processing them.
This might cause the guest to run out of tx buffers while the host
holds them up.

This is a temporal solution to quickly bring back performance to 800mbps.
But a better fix will soon be sent (its not the only problem).

Signed-off-by: Dor Laor <dor.laor@qumranet.com>
---
 qemu/hw/virtio-net.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/qemu/hw/virtio-net.c b/qemu/hw/virtio-net.c
index 777fe2c..3d07b65 100644
--- a/qemu/hw/virtio-net.c
+++ b/qemu/hw/virtio-net.c
@@ -293,7 +293,7 @@ void *virtio_net_init(PCIBus *bus, NICInfo *nd, int devfn)
     n->vdev.update_config = virtio_net_update_config;
     n->vdev.get_features = virtio_net_get_features;
     n->rx_vq = virtio_add_queue(&n->vdev, 512, virtio_net_handle_rx);
-    n->tx_vq = virtio_add_queue(&n->vdev, 128, virtio_net_handle_tx);
+    n->tx_vq = virtio_add_queue(&n->vdev, 512, virtio_net_handle_tx);
     n->can_receive = 0;
     memcpy(n->mac, nd->macaddr, 6);
     n->vc = qemu_new_vlan_client(nd->vlan, virtio_net_receive,
-- 
1.5.3.7
