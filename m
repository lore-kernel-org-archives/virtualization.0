From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH RFC 2/3] virtio infrastructure: example net driver
Date: Thu, 31 May 2007 22:20:44 +1000
Message-ID: <1180614044.11133.61.camel__20591.5440260016$1180614114$gmane$org@localhost.localdomain>
References: <1180613947.11133.58.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1180613947.11133.58.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel <kvm-devel@lists.sourceforge.net>, Xen Mailing List <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>, Anthony Liguori <anthony@codemonkey.ws>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Example net driver using virtio

TODO:
	1) Locking (see #2).
	2) NAPI.
	3) GSO.
	4) Checksum options.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/Makefile       |    2
 drivers/net/virtio_net.c   |  237 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio_net.h |   13 ++
 3 files changed, 251 insertions(+), 1 deletion(-)

diff -r 96df1769fce9 drivers/net/Makefile
--- a/drivers/net/Makefile	Thu May 31 17:52:38 2007 +1000
+++ b/drivers/net/Makefile	Thu May 31 17:52:40 2007 +1000
@@ -37,7 +37,7 @@ obj-$(CONFIG_CASSINI) += cassini.o
 
 obj-$(CONFIG_MACE) += mace.o
 obj-$(CONFIG_BMAC) += bmac.o
-
+obj-y += virtio_net.o
 obj-$(CONFIG_DGRS) += dgrs.o
 obj-$(CONFIG_VORTEX) += 3c59x.o
 obj-$(CONFIG_TYPHOON) += typhoon.o
diff -r 96df1769fce9 drivers/net/virtio_net.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/drivers/net/virtio_net.c	Thu May 31 17:53:54 2007 +1000
@@ -0,0 +1,236 @@
+/* A simple network driver using virtio.
+ *
+ * Copyright 2007 Rusty Russell <rusty@rustcorp.com.au> IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+//#define DEBUG
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/module.h>
+#include <linux/virtio.h>
+#include <linux/scatterlist.h>
+
+#define NET_BUFS 128
+/* FIXME: Make dynamic */
+#define MAX_PACKET_LEN (ETH_HLEN+ETH_DATA_LEN)
+
+struct virtnet_info
+{
+	struct virtio_device *vdev;
+	struct net_device *ndev;
+
+	/* Receive queue. */
+	struct sk_buff *in[NET_BUFS];
+	/* Send queue. */
+	struct sk_buff *out[NET_BUFS];
+
+	/* Lengths for input buffers as they are used. */
+	unsigned long in_used[NET_BUFS];
+
+	/* Lengths for output buffers as they are used. */
+	unsigned long out_used[NET_BUFS];
+
+	/* IDs for buffers. */
+	long in_ids[NET_BUFS];
+	long out_ids[NET_BUFS];
+};
+
+static int start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	unsigned int n, i;
+	/* FIXME: What *is* the max here? */
+	struct scatterlist sg[MAX_SKB_FRAGS + 2];
+	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
+
+	pr_debug("%s: xmit %02x:%02x:%02x:%02x:%02x:%02x\n",
+		 dev->name, dest[0],dest[1],dest[2],dest[3],dest[4],dest[5]);
+
+	/* Go through and find a new output slot, and free any on the way */
+	for (i = 0; i < NET_BUFS; i++) {
+		if (!vi->out[i])
+			break;
+
+		if (!vi->out_used[i])
+			continue;
+
+		vi->vdev->ops->detach_outbuf(vi->vdev, vi->out_ids[i]);
+		dev->stats.tx_bytes += vi->out_used[i];
+		dev->stats.tx_packets++;
+		dev_kfree_skb(vi->out[i]);
+		vi->out[i] = NULL;
+		break;
+	}
+	if (unlikely(i == NET_BUFS)) {
+		pr_debug("%s: ring full\n", dev->name);
+		goto stop;
+	}
+
+	n = skb_to_sgvec(skb, sg, 0, skb->len);
+	vi->out_used[i] = 0;
+	vi->out_ids[i] = vi->vdev->ops->add_outbuf(vi->vdev, sg, n,
+						   &vi->out_used[i]);
+	if (IS_ERR_VALUE(vi->out_ids[i])) {
+		pr_debug("%s: virtio not prepared to send\n", dev->name);
+		goto stop;
+	}
+	vi->out[i] = skb;
+	virtio_sync(vi->vdev);
+	return 0;
+stop:
+	netif_stop_queue(dev);
+	return NETDEV_TX_BUSY;
+}
+
+static void receive_skb(struct net_device *dev, struct sk_buff *skb,
+			unsigned len)
+{
+	if (unlikely(len < ETH_HLEN)) {
+		pr_debug("%s: short packet %i\n", dev->name, len);
+		dev->stats.rx_length_errors++;
+		dev_kfree_skb(skb);
+		return;
+	}
+	BUG_ON(len > MAX_PACKET_LEN);
+
+	skb_trim(skb, len);
+	skb->protocol = eth_type_trans(skb, dev);
+	pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
+		 ntohs(skb->protocol), skb->len, skb->pkt_type);
+	dev->stats.rx_bytes += skb->len;
+	dev->stats.rx_packets++;
+	netif_rx(skb);
+}
+
+static void try_fill_recv(struct virtnet_info *vi, unsigned int i)
+{
+	/* FIXME: What *is* the max here? */
+	struct scatterlist sg[MAX_SKB_FRAGS + 1];
+	unsigned int n;
+
+	vi->in[i] = netdev_alloc_skb(vi->ndev, MAX_PACKET_LEN);
+	if (unlikely(!vi->in[i]))
+		return;
+
+	skb_put(vi->in[i], MAX_PACKET_LEN);
+	n = skb_to_sgvec(vi->in[i], sg, 0, vi->in[i]->len);
+	vi->in_used[i] = 0;
+	vi->in_ids[i] = vi->vdev->ops->add_inbuf(vi->vdev, sg, n,
+						 &vi->in_used[i]);
+	if (IS_ERR_VALUE(vi->in_ids[i])) {
+		kfree_skb(vi->in[i]);
+		vi->in[i] = NULL;
+	}
+}
+
+static int virtnet_open(struct net_device *dev)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	unsigned int i;
+
+	for (i = 0; i < NET_BUFS; i++)
+		try_fill_recv(vi, i);
+
+	virtio_sync(vi->vdev);
+	return 0;
+}
+
+static int virtnet_close(struct net_device *dev)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	unsigned int i;
+
+	for (i = 0; i < NET_BUFS; i++) {
+		if (vi->in[i]) {
+			vi->vdev->ops->detach_inbuf(vi->vdev, vi->in_ids[i]);
+			kfree_skb(vi->in[i]);
+			vi->in[i] = NULL;
+		}
+		if (vi->out[i]) {
+			vi->vdev->ops->detach_outbuf(vi->vdev, vi->out_ids[i]);
+			kfree_skb(vi->out[i]);
+			vi->out[i] = NULL;
+		}
+	}
+	return 0;
+}
+
+struct net_device *virtnet_probe(struct virtio_device *vdev,
+				 const u8 mac[ETH_ALEN])
+{
+	int err;
+	struct net_device *dev;
+	struct virtnet_info *vi;
+
+	dev = alloc_etherdev(sizeof(struct virtnet_info));
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	SET_MODULE_OWNER(dev);
+
+	ether_setup(dev);
+	memcpy(dev->dev_addr, mac, ETH_ALEN);
+	dev->open = virtnet_open;
+	dev->stop = virtnet_close;
+	dev->hard_start_xmit = start_xmit;
+	SET_NETDEV_DEV(dev, vdev->dev);
+
+	vi = netdev_priv(dev);
+	vi->vdev = vdev;
+	vi->ndev = dev;
+
+	err = register_netdev(dev);
+	if (err) {
+		pr_debug("virtio_net: registering device failed\n");
+		goto free;
+	}
+	pr_debug("virtnet: registered device %s\n", dev->name);
+	return dev;
+
+free:
+	free_netdev(dev);
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(virtnet_probe);
+
+/* We get this when the other side sends buffers, or consumes them. */
+int virtnet_interrupt(struct net_device *dev)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	unsigned int i;
+
+	for (i = 0; i < NET_BUFS; i++) {
+		if (vi->in[i] && vi->in_used[i]) {
+			vi->vdev->ops->detach_inbuf(vi->vdev, vi->in_ids[i]);
+			receive_skb(dev, vi->in[i], vi->in_used[i]);
+			try_fill_recv(vi, i);
+		}
+	}
+
+	netif_wake_queue(dev);
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL_GPL(virtnet_interrupt);
+
+void virtnet_remove(struct net_device *dev)
+{
+	unregister_netdev(dev);
+	free_netdev(dev);
+}
+EXPORT_SYMBOL_GPL(virtnet_remove);
+
+MODULE_DESCRIPTION("Virtio network driver");
+MODULE_LICENSE("GPL");
diff -r 96df1769fce9 include/linux/virtio_net.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/linux/virtio_net.h	Thu May 31 17:52:40 2007 +1000
@@ -0,0 +1,13 @@
+#ifndef _LINUX_VIRTIO_NET_H
+#define _LINUX_VIRTIO_NET_H
+#include <linux/types.h>
+#include <linux/etherdevice.h>
+struct net_device;
+struct virtio_device;
+
+struct net_device *virtnet_probe(struct virtio_device *vdev,
+				 const u8 mac[ETH_ALEN]);
+int virtnet_interrupt(struct net_device *dev);
+void virtnet_remove(struct net_device *dev);
+
+#endif /* _LINUX_VIRTIO_NET_H */
