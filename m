From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/3] Virtio draft IV: the net driver
Date: Wed, 04 Jul 2007 14:40:53 +1000
Message-ID: <1183524053.6110.45.camel@localhost.localdomain>
References: <1183522348.6110.37.camel@localhost.localdomain>
	<1183522765.6110.40.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1183522765.6110.40.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization <virtualization@lists.linux-foundation.org>
Cc: Carsten Otte <cotte@de.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

The network driver uses *two* virtqueues: one for input packets and
one for output packets.  This has nice locking properties (ie. we
don't do any for recv vs send).

TODO:
	1) GSO.
	2) Checksum options.
	3) Big packets.
	4) Multi-client devices (maybe separate driver?).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/Makefile       |    2 
 drivers/net/virtio_net.c   |  276 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio_net.h |   15 ++
 3 files changed, 292 insertions(+), 1 deletion(-)

===================================================================
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -37,7 +37,7 @@ obj-$(CONFIG_CASSINI) += cassini.o
 
 obj-$(CONFIG_MACE) += mace.o
 obj-$(CONFIG_BMAC) += bmac.o
-
+obj-y += virtio_net.o
 obj-$(CONFIG_DGRS) += dgrs.o
 obj-$(CONFIG_VORTEX) += 3c59x.o
 obj-$(CONFIG_TYPHOON) += typhoon.o
===================================================================
--- /dev/null
+++ b/drivers/net/virtio_net.c
@@ -0,0 +1,276 @@
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
+/* FIXME: Make dynamic */
+#define MAX_PACKET_LEN (ETH_HLEN+ETH_DATA_LEN)
+
+struct virtnet_info
+{
+	struct virtqueue *vq_recv;
+	struct virtqueue *vq_send;
+	struct net_device *ndev;
+
+	/* Number of input buffers, and max we've ever had. */
+	unsigned int num, max;
+
+	/* Receive & send queues. */
+	struct sk_buff_head recv;
+	struct sk_buff_head send;
+};
+
+static bool skb_xmit_done(struct virtqueue *vq)
+{
+	struct virtnet_info *vi = vq->priv;
+
+	/* In case we were waiting for output buffers. */
+	netif_wake_queue(vi->ndev);
+	return true;
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
+static void try_fill_recv(struct virtnet_info *vi)
+{
+	struct sk_buff *skb;
+	struct scatterlist sg[MAX_SKB_FRAGS];
+	int num, err;
+
+	for (;;) {
+		skb = netdev_alloc_skb(vi->ndev, MAX_PACKET_LEN);
+		if (unlikely(!skb))
+			break;
+
+		skb_put(skb, MAX_PACKET_LEN);
+		num = skb_to_sgvec(skb, sg, 0, skb->len);
+		skb_queue_head(&vi->recv, skb);
+
+		err = vi->vq_recv->ops->add_buf(vi->vq_recv, sg, 0, num, skb);
+		if (err) {
+			skb_unlink(skb, &vi->recv);
+			kfree_skb(skb);
+			break;
+		}
+		vi->num++;
+	}
+	if (unlikely(vi->num > vi->max))
+		vi->max = vi->num;
+	vi->vq_recv->ops->sync(vi->vq_recv);
+}
+
+static bool skb_recv_done(struct virtqueue *vq)
+{
+	struct virtnet_info *vi = vq->priv;
+
+	netif_rx_schedule(vi->ndev);
+	/* Suppress further interrupts. */
+	return false;
+}
+
+static int virtnet_poll(struct net_device *dev, int *budget)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct sk_buff *skb = NULL;
+	unsigned int len, received = 0;
+
+again:
+	while (received < dev->quota &&
+	       (skb = vi->vq_recv->ops->get_buf(vi->vq_recv, &len)) != NULL) {
+		__skb_unlink(skb, &vi->recv);
+		receive_skb(vi->ndev, skb, len);
+		vi->num--;
+		received++;
+	}
+
+        dev->quota -= received;
+        *budget -= received;
+
+	/* FIXME: If we oom and completely run out of inbufs, we need
+	 * to start a timer trying to fill more. */
+	if (vi->num < vi->max / 2)
+		try_fill_recv(vi);
+
+	/* Still more work to do? */
+	if (skb)
+		return 1; /* not done */
+
+	netif_rx_complete(dev);
+	if (unlikely(!vi->vq_recv->ops->restart(vi->vq_recv))
+	    && netif_rx_reschedule(dev, received))
+		goto again;
+
+	return 0;
+}
+
+static void free_old_xmit_skbs(struct virtnet_info *vi)
+{
+	struct sk_buff *skb;
+	unsigned int len;
+
+	while ((skb = vi->vq_send->ops->get_buf(vi->vq_send, &len)) != NULL) {
+		/* They cannot have written to the packet. */
+		BUG_ON(len != 0);
+		pr_debug("Sent skb %p\n", skb);
+		__skb_unlink(skb, &vi->send);
+		vi->ndev->stats.tx_bytes += skb->len;
+		vi->ndev->stats.tx_packets++;
+		kfree_skb(skb);
+	}
+}
+
+static int start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int num, err;
+	struct scatterlist sg[MAX_SKB_FRAGS];
+	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
+
+	pr_debug("%s: xmit %p %02x:%02x:%02x:%02x:%02x:%02x\n",
+		 dev->name, skb,
+		 dest[0], dest[1], dest[2], dest[3], dest[4], dest[5]);
+
+	free_old_xmit_skbs(vi);
+
+	num = skb_to_sgvec(skb, sg, 0, skb->len);
+	__skb_queue_head(&vi->send, skb);
+	err = vi->vq_send->ops->add_buf(vi->vq_send, sg, num, 0, skb);
+	if (err) {
+		pr_debug("%s: virtio not prepared to send\n", dev->name);
+		skb_unlink(skb, &vi->send);
+		netif_stop_queue(dev);
+		return NETDEV_TX_BUSY;
+	}
+	vi->vq_send->ops->sync(vi->vq_send);
+
+	return 0;
+}
+
+static int virtnet_open(struct net_device *dev)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+
+	try_fill_recv(vi);
+
+	/* If we didn't even get one input buffer, we're useless. */
+	if (vi->num == 0)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int virtnet_close(struct net_device *dev)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct sk_buff *skb;
+
+	/* networking core has neutered skb_xmit_done/skb_recv_done, so don't
+	 * worry about races vs. get(). */
+	while ((skb = __skb_dequeue(&vi->recv)) != NULL) {
+		vi->vq_recv->ops->detach_buf(vi->vq_recv, skb);
+		kfree_skb(skb);
+		vi->num--;
+	}
+	while ((skb = __skb_dequeue(&vi->send)) != NULL) {
+		vi->vq_send->ops->detach_buf(vi->vq_send, skb);
+		kfree_skb(skb);
+	}
+	BUG_ON(vi->num != 0);
+	return 0;
+}
+
+struct net_device *virtnet_probe(struct virtqueue *vq_recv,
+				 struct virtqueue *vq_send,
+				 struct device *device,
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
+	dev->poll = virtnet_poll;
+	dev->hard_start_xmit = start_xmit;
+	dev->weight = 16;
+	SET_NETDEV_DEV(dev, device);
+
+	vi = netdev_priv(dev);
+	vi->ndev = dev;
+	vi->vq_recv = vq_recv;
+	vi->vq_send = vq_send;
+	vq_recv->cb = skb_recv_done;
+	vq_send->cb = skb_xmit_done;
+	vq_recv->priv = vq_send->priv = vi;
+	skb_queue_head_init(&vi->recv);
+	skb_queue_head_init(&vi->send);
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
+void virtnet_remove(struct net_device *dev)
+{
+	unregister_netdev(dev);
+	free_netdev(dev);
+}
+EXPORT_SYMBOL_GPL(virtnet_remove);
+
+MODULE_DESCRIPTION("Virtio network driver");
+MODULE_LICENSE("GPL");
===================================================================
--- /dev/null
+++ b/include/linux/virtio_net.h
@@ -0,0 +1,15 @@
+#ifndef _LINUX_VIRTIO_NET_H
+#define _LINUX_VIRTIO_NET_H
+#include <linux/types.h>
+#include <linux/etherdevice.h>
+struct device;
+struct net_device;
+struct virtqueue;
+
+struct net_device *virtnet_probe(struct virtqueue *vq_recv,
+				 struct virtqueue *vq_send,
+				 struct device *dev,
+				 const u8 mac[ETH_ALEN]);
+void virtnet_remove(struct net_device *dev);
+
+#endif /* _LINUX_VIRTIO_NET_H */
