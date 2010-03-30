From: David L Stevens <dlstevens@us.ibm.com>
Subject: [PATCH][QEMU][VHOST]fix feature bit handling for mergeable rx buffers
Date: Tue, 30 Mar 2010 12:21:05 -0700
Message-ID: <201003301921.o2UJL5EH003473@lab1.dls>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
To: mst@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org


This patch adds mergeable receive buffer support to qemu-kvm,
to allow enabling it when vhost_net supports it.

It also adds a missing call to vhost_net_ack_features() to
push acked features to vhost_net.

The patch is relative to Michael Tsirkin's qemu-kvm git tree.

					+-DLS

Signed-off-by: David L Stevens <dlstevens@us.ibm.com>

diff -ruNp qemu-kvm.mst/hw/vhost_net.c qemu-kvm.dls/hw/vhost_net.c
--- qemu-kvm.mst/hw/vhost_net.c	2010-03-03 13:39:07.000000000 -0800
+++ qemu-kvm.dls/hw/vhost_net.c	2010-03-29 20:37:34.000000000 -0700
@@ -5,6 +5,7 @@
 #include <sys/ioctl.h>
 #include <linux/vhost.h>
 #include <linux/virtio_ring.h>
+#include <linux/if_tun.h>
 #include <netpacket/packet.h>
 #include <net/ethernet.h>
 #include <net/if.h>
@@ -38,15 +39,6 @@ unsigned vhost_net_get_features(struct v
 	return features;
 }
 
-void vhost_net_ack_features(struct vhost_net *net, unsigned features)
-{
-	net->dev.acked_features = net->dev.backend_features;
-	if (features & (1 << VIRTIO_F_NOTIFY_ON_EMPTY))
-		net->dev.acked_features |= (1 << VIRTIO_F_NOTIFY_ON_EMPTY);
-	if (features & (1 << VIRTIO_RING_F_INDIRECT_DESC))
-		net->dev.acked_features |= (1 << VIRTIO_RING_F_INDIRECT_DESC);
-}
-
 static int vhost_net_get_fd(VLANClientState *backend)
 {
 	switch (backend->info->type) {
@@ -58,6 +50,25 @@ static int vhost_net_get_fd(VLANClientSt
 	}
 }
 
+void vhost_net_ack_features(struct vhost_net *net, unsigned features)
+{
+	int vnet_hdr_sz = sizeof(struct virtio_net_hdr);
+
+	net->dev.acked_features = net->dev.backend_features;
+	if (features & (1 << VIRTIO_F_NOTIFY_ON_EMPTY))
+		net->dev.acked_features |= (1 << VIRTIO_F_NOTIFY_ON_EMPTY);
+	if (features & (1 << VIRTIO_RING_F_INDIRECT_DESC))
+		net->dev.acked_features |= (1 << VIRTIO_RING_F_INDIRECT_DESC);
+	if (features & (1 << VIRTIO_NET_F_MRG_RXBUF)) {
+		net->dev.acked_features |= (1 << VIRTIO_NET_F_MRG_RXBUF);
+		vnet_hdr_sz = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+	}
+#ifdef TUNSETVNETHDRSZ
+	if (ioctl(vhost_net_get_fd(net->vc), TUNSETVNETHDRSZ, &vnet_hdr_sz) < 0)
+		perror("TUNSETVNETHDRSZ");
+#endif /* TUNSETVNETHDRSZ */
+}
+
 struct vhost_net *vhost_net_init(VLANClientState *backend, int devfd)
 {
 	int r;
diff -ruNp qemu-kvm.mst/hw/virtio-net.c qemu-kvm.dls/hw/virtio-net.c
--- qemu-kvm.mst/hw/virtio-net.c	2010-03-03 13:39:07.000000000 -0800
+++ qemu-kvm.dls/hw/virtio-net.c	2010-03-29 16:15:46.000000000 -0700
@@ -211,12 +211,16 @@ static void virtio_net_set_features(Virt
     n->mergeable_rx_bufs = !!(features & (1 << VIRTIO_NET_F_MRG_RXBUF));
 
     if (n->has_vnet_hdr) {
+	struct vhost_net *vhost_net = tap_get_vhost_net(n->nic->nc.peer);
+
         tap_set_offload(n->nic->nc.peer,
                         (features >> VIRTIO_NET_F_GUEST_CSUM) & 1,
                         (features >> VIRTIO_NET_F_GUEST_TSO4) & 1,
                         (features >> VIRTIO_NET_F_GUEST_TSO6) & 1,
                         (features >> VIRTIO_NET_F_GUEST_ECN)  & 1,
                         (features >> VIRTIO_NET_F_GUEST_UFO)  & 1);
+	if (vhost_net)
+		vhost_net_ack_features(vhost_net, features);
     }
 }
 
