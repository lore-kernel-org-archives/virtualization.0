From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH RFC 3/3] Virtio draft II: example net driver
Date: Thu, 07 Jun 2007 22:07:03 +1000
Message-ID: <1181218023.14054.199.camel__46294.2799008035$1181218100$gmane$org@localhost.localdomain>
References: <1181217762.14054.192.camel@localhost.localdomain>
	<1181217867.14054.195.camel@localhost.localdomain>
	<1181217920.14054.196.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1181217920.14054.196.camel@localhost.localdomain>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Borntraeger <cborntra@de.ibm.com>, Latchesar Ionkov <lionkov@lanl.gov>, Suzanne McIntosh <skranjac@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

TODO:
	1) NAPI (will require way of suppressing virtio callbacks)
	2) GSO.
	3) Checksum options.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/Makefile       |    2 
 drivers/net/virtio_net.c   |  243 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio_net.h |   12 ++
 3 files changed, 256 insertions(+), 1 deletion(-)

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
@@ -0,0 +1,243 @@
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
+#define SKB_ID(skb) (*(unsigned long *)(skb)->cb)
+
+struct virtnet_info
+{
+	struct virtio_device *vdev;
+	struct net_device *ndev;
+
+	/* Receive & send queues. */
+	struct sk_buff_head recv;
+	struct sk_buff_head send;
+
+	/* Transmitted packets waiting to be freed */
+	struct sk_buff_head free;
+};
+
+static void skb_xmit_done(struct virtio_device *vdev, void *_skb, unsigned len)
+{
+	struct virtnet_info *vi = vdev->priv;
+	struct sk_buff *skb = _skb;
+
+	assert_spin_locked(&vdev->lock);
+
+	__skb_unlink(skb, &vi->send);
+	vi->ndev->stats.tx_bytes += len;
+	vi->ndev->stats.tx_packets++;
+	__skb_queue_head(&vi->free, skb);
+
+	pr_debug("Sent skb %p\n", skb);
+	/* In case we were waiting for output buffers. */
+	netif_wake_queue(vi->ndev);
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
+static void skb_recv_done(struct virtio_device *, void *, unsigned);
+static int try_fill_recv(struct virtnet_info *vi)
+{
+	struct sk_buff *skb;
+	struct scatterlist sg[MAX_SKB_FRAGS];
+	unsigned long num, id;
+
+	assert_spin_locked(&vi->vdev->lock);
+
+	skb = netdev_alloc_skb(vi->ndev, MAX_PACKET_LEN);
+	if (unlikely(!skb))
+		return -ENOMEM;
+
+	skb_put(skb, MAX_PACKET_LEN);
+	num = skb_to_sgvec(skb, sg, 0, skb->len);
+	skb_queue_head(&vi->recv, skb);
+
+	id = vi->vdev->ops->add_inbuf(vi->vdev, sg, num, skb_recv_done, skb);
+	if (IS_ERR_VALUE(id)) {
+		skb_unlink(skb, &vi->recv);
+		kfree_skb(skb);
+		return id;
+	}
+	return 0;
+}
+
+static void skb_recv_done(struct virtio_device *vdev, void *_skb, unsigned len)
+{
+	struct virtnet_info *vi = vdev->priv;
+	struct sk_buff *skb = _skb;
+
+	assert_spin_locked(&vdev->lock);
+	__skb_unlink(skb, &vi->recv);
+	receive_skb(vi->ndev, skb, len);
+	try_fill_recv(vi);
+}
+
+static void free_old_skbs(struct sk_buff_head *free)
+{
+	struct sk_buff *skb;
+	while ((skb = __skb_dequeue(free)) != NULL)
+		kfree_skb(skb);
+}
+
+static int start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	unsigned long num, id;
+	struct scatterlist sg[MAX_SKB_FRAGS];
+	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
+	unsigned long flags;
+
+	pr_debug("%s: xmit %p %02x:%02x:%02x:%02x:%02x:%02x\n",
+		 dev->name, skb,
+		 dest[0], dest[1], dest[2], dest[3], dest[4], dest[5]);
+
+	spin_lock_irqsave(&vi->vdev->lock, flags);
+	/* Free any transmitted packets: not supposed to do it in interrupt */
+	free_old_skbs(&vi->free);
+
+	num = skb_to_sgvec(skb, sg, 0, skb->len);
+	__skb_queue_head(&vi->send, skb);
+	id = vi->vdev->ops->add_outbuf(vi->vdev, sg, num, skb_xmit_done, skb);
+	if (IS_ERR_VALUE(id)) {
+		pr_debug("%s: virtio not prepared to send\n", dev->name);
+		skb_unlink(skb, &vi->send);
+		netif_stop_queue(dev);
+		return NETDEV_TX_BUSY;
+	}
+	SKB_ID(skb) = id;
+	vi->vdev->ops->sync(vi->vdev);
+	spin_unlock_irqrestore(&vi->vdev->lock, flags);
+
+	return 0;
+}
+
+static int virtnet_open(struct net_device *dev)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int i, err;
+
+	spin_lock_irq(&vi->vdev->lock);
+	for (i = 0; (err = try_fill_recv(vi)) == 0; i++);
+	vi->vdev->ops->sync(vi->vdev);
+	spin_unlock_irq(&vi->vdev->lock);
+
+	/* If we didn't even get one input buffer, we're useless. */
+	if (i == 0)
+		return err;
+
+	return 0;
+}
+
+static int virtnet_close(struct net_device *dev)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct sk_buff *skb;
+
+	spin_lock_irq(&vi->vdev->lock);
+	while ((skb = __skb_dequeue(&vi->recv)) != NULL) {
+		vi->vdev->ops->detach_inbuf(vi->vdev, SKB_ID(skb));
+		kfree_skb(skb);
+	}
+	while ((skb = __skb_dequeue(&vi->send)) != NULL) {
+		vi->vdev->ops->detach_outbuf(vi->vdev, SKB_ID(skb));
+		kfree_skb(skb);
+	}
+	free_old_skbs(&vi->free);
+	spin_unlock_irq(&vi->vdev->lock);
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
+	vdev->priv = vi;
+	skb_queue_head_init(&vi->recv);
+	skb_queue_head_init(&vi->send);
+	skb_queue_head_init(&vi->free);
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
@@ -0,0 +1,12 @@
+#ifndef _LINUX_VIRTIO_NET_H
+#define _LINUX_VIRTIO_NET_H
+#include <linux/types.h>
+#include <linux/etherdevice.h>
+struct net_device;
+struct virtio_device;
+
+struct net_device *virtnet_probe(struct virtio_device *vdev,
+				 const u8 mac[ETH_ALEN]);
+void virtnet_remove(struct net_device *dev);
+
+#endif /* _LINUX_VIRTIO_NET_H */
