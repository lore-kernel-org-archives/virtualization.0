From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/6] virtio net driver
Date: Thu, 20 Sep 2007 22:14:55 +1000
Message-ID: <1190290495.7262.235.camel__46640.0865502239$1190290658$gmane$org@localhost.localdomain>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<1190290140.7262.228.camel@localhost.localdomain>
	<1190290369.7262.231.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190290369.7262.231.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel <kvm-devel@lists.sourceforge.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, lguest <lguest@ozlabs.org>, Jeff Garzik <jeff@garzik.org>, Dor Laor <dor.laor@qumranet.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

The network driver uses *two* virtqueues: one for input packets and
one for output packets.  This has nice locking properties (ie. we
don't do any for recv vs send).

TODO:
	1) Big packets.
	2) Multi-client devices (maybe separate driver?).
	3) Resolve freeing of old xmit skbs (someone sent patch IIRC?)

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/Kconfig        |    6 
 drivers/net/Makefile       |    2 
 drivers/net/virtio_net.c   |  438 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio_net.h |   36 +++
 4 files changed, 481 insertions(+), 1 deletion(-)

===================================================================
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2998,4 +2998,10 @@ config NET_POLL_CONTROLLER
 config NET_POLL_CONTROLLER
 	def_bool NETPOLL
 
+config VIRTIO_NET
+	tristate "Virtio network driver (EXPERIMENTAL)"
+	depends on EXPERIMENTAL && VIRTIO
+	---help---
+	  This is the virtual network driver for lguest.  Say Y or M.
+
 endif # NETDEVICES
===================================================================
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_SUNVNET) += sunvnet.o
 
 obj-$(CONFIG_MACE) += mace.o
 obj-$(CONFIG_BMAC) += bmac.o
-
+obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
 obj-$(CONFIG_DGRS) += dgrs.o
 obj-$(CONFIG_VORTEX) += 3c59x.o
 obj-$(CONFIG_TYPHOON) += typhoon.o
===================================================================
--- /dev/null
+++ b/drivers/net/virtio_net.c
@@ -0,0 +1,438 @@
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
+#include <linux/virtio_net.h>
+#include <linux/scatterlist.h>
+
+/* FIXME: MTU in config. */
+#define MAX_PACKET_LEN (ETH_HLEN+ETH_DATA_LEN)
+
+struct virtnet_info
+{
+	struct virtqueue_ops *vq_ops;
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
+static inline struct virtio_net_hdr *skb_vnet_hdr(struct sk_buff *skb)
+{
+	return (struct virtio_net_hdr *)skb->cb;
+}
+
+static inline void vnet_hdr_to_sg(struct scatterlist *sg, struct sk_buff *skb)
+{
+	sg_init_one(sg, skb_vnet_hdr(skb), sizeof(struct virtio_net_hdr));
+}
+
+static bool skb_xmit_done(void *ndev)
+{
+	/* In case we were waiting for output buffers. */
+	netif_wake_queue(ndev);
+	return true;
+}
+
+static void receive_skb(struct net_device *dev, struct sk_buff *skb,
+			unsigned len)
+{
+	struct virtio_net_hdr *hdr = skb_vnet_hdr(skb);
+
+	if (unlikely(len < sizeof(struct virtio_net_hdr) + ETH_HLEN)) {
+		pr_debug("%s: short packet %i\n", dev->name, len);
+		dev->stats.rx_length_errors++;
+		goto drop;
+	}
+	len -= sizeof(struct virtio_net_hdr);
+	BUG_ON(len > MAX_PACKET_LEN);
+
+	skb_trim(skb, len);
+	skb->protocol = eth_type_trans(skb, dev);
+	pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
+		 ntohs(skb->protocol), skb->len, skb->pkt_type);
+	dev->stats.rx_bytes += skb->len;
+	dev->stats.rx_packets++;
+
+	if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
+		pr_debug("Needs csum!\n");
+		skb->ip_summed = CHECKSUM_PARTIAL;
+		skb->csum_start = hdr->csum_start;
+		skb->csum_offset = hdr->csum_offset;
+		if (skb->csum_start > skb->len - 2
+		    || skb->csum_offset > skb->len - 2) {
+			if (net_ratelimit())
+				printk(KERN_WARNING "%s: csum=%u/%u len=%u\n",
+				       dev->name, skb->csum_start,
+				       skb->csum_offset, skb->len);
+			goto frame_err;
+		}
+	}
+
+	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
+		pr_debug("GSO!\n");
+		switch (hdr->gso_type) {
+		case VIRTIO_NET_HDR_GSO_TCPV4:
+			skb_shinfo(skb)->gso_type = SKB_GSO_TCPV4;
+			break;
+		case VIRTIO_NET_HDR_GSO_TCPV4_ECN:
+			skb_shinfo(skb)->gso_type = SKB_GSO_TCP_ECN;
+			break;
+		case VIRTIO_NET_HDR_GSO_UDP:
+			skb_shinfo(skb)->gso_type = SKB_GSO_UDP;
+			break;
+		case VIRTIO_NET_HDR_GSO_TCPV6:
+			skb_shinfo(skb)->gso_type = SKB_GSO_TCPV6;
+			break;
+		default:
+			if (net_ratelimit())
+				printk(KERN_WARNING "%s: bad gso type %u.\n",
+				       dev->name, hdr->gso_type);
+			goto frame_err;
+		}
+
+		skb_shinfo(skb)->gso_size = hdr->gso_size;
+		if (skb_shinfo(skb)->gso_size == 0) {
+			if (net_ratelimit())
+				printk(KERN_WARNING "%s: zero gso size.\n",
+				       dev->name);
+			goto frame_err;
+		}
+
+		/* Header must be checked, and gso_segs computed. */
+		skb_shinfo(skb)->gso_type |= SKB_GSO_DODGY;
+		skb_shinfo(skb)->gso_segs = 0;
+	}
+
+	netif_receive_skb(skb);
+	return;
+
+frame_err:
+	dev->stats.rx_frame_errors++;
+drop:
+	dev_kfree_skb(skb);
+}
+
+static void try_fill_recv(struct virtnet_info *vi)
+{
+	struct sk_buff *skb;
+	struct scatterlist sg[1+MAX_SKB_FRAGS];
+	int num, err;
+
+	for (;;) {
+		skb = netdev_alloc_skb(vi->ndev, MAX_PACKET_LEN);
+		if (unlikely(!skb))
+			break;
+
+		skb_put(skb, MAX_PACKET_LEN);
+		vnet_hdr_to_sg(sg, skb);
+		num = skb_to_sgvec(skb, sg+1, 0, skb->len) + 1;
+		skb_queue_head(&vi->recv, skb);
+
+		err = vi->vq_ops->add_buf(vi->vq_recv, sg, 0, num, skb);
+		if (err) {
+			skb_unlink(skb, &vi->recv);
+			kfree_skb(skb);
+			break;
+		}
+		vi->num++;
+	}
+	if (unlikely(vi->num > vi->max))
+		vi->max = vi->num;
+	vi->vq_ops->kick(vi->vq_recv);
+}
+
+static bool skb_recv_done(void *ndev)
+{
+	netif_rx_schedule(ndev);
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
+	       (skb = vi->vq_ops->get_buf(vi->vq_recv, &len)) != NULL) {
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
+	if (unlikely(!vi->vq_ops->restart(vi->vq_recv))
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
+	while ((skb = vi->vq_ops->get_buf(vi->vq_send, &len)) != NULL) {
+		pr_debug("Sent skb %p\n", skb);
+		__skb_unlink(skb, &vi->send);
+		vi->ndev->stats.tx_bytes += len;
+		vi->ndev->stats.tx_packets++;
+		kfree_skb(skb);
+	}
+}
+
+static int start_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	int num, err;
+	struct scatterlist sg[1+MAX_SKB_FRAGS];
+	struct virtio_net_hdr *hdr;
+	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
+
+	pr_debug("%s: xmit %p %02x:%02x:%02x:%02x:%02x:%02x\n",
+		 dev->name, skb,
+		 dest[0], dest[1], dest[2], dest[3], dest[4], dest[5]);
+
+	free_old_xmit_skbs(vi);
+
+	/* Encode metadata header at front. */
+	hdr = skb_vnet_hdr(skb);
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		hdr->flags = VIRTIO_NET_HDR_F_NEEDS_CSUM;
+		hdr->csum_start = skb->csum_start - skb_headroom(skb);
+		hdr->csum_offset = skb->csum_offset;
+	} else {
+		hdr->flags = 0;
+		hdr->csum_offset = hdr->csum_start = 0;
+	}
+
+	if (skb_is_gso(skb)) {
+		hdr->gso_size = skb_shinfo(skb)->gso_size;
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_ECN)
+			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4_ECN;
+		else if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4)
+			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
+		else if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6)
+			hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
+		else if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
+			hdr->gso_type = VIRTIO_NET_HDR_GSO_UDP;
+		else
+			BUG();
+	} else {
+		hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;
+		hdr->gso_size = 0;
+	}
+
+	vnet_hdr_to_sg(sg, skb);
+	num = skb_to_sgvec(skb, sg+1, 0, skb->len) + 1;
+	__skb_queue_head(&vi->send, skb);
+	err = vi->vq_ops->add_buf(vi->vq_send, sg, num, 0, skb);
+	if (err) {
+		pr_debug("%s: virtio not prepared to send\n", dev->name);
+		skb_unlink(skb, &vi->send);
+		netif_stop_queue(dev);
+		return NETDEV_TX_BUSY;
+	}
+	vi->vq_ops->kick(vi->vq_send);
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
+	vi->vq_ops->shutdown(vi->vq_recv);
+	while ((skb = __skb_dequeue(&vi->recv)) != NULL) {
+		kfree_skb(skb);
+		vi->num--;
+	}
+	vi->vq_ops->shutdown(vi->vq_send);
+	while ((skb = __skb_dequeue(&vi->send)) != NULL)
+		kfree_skb(skb);
+
+	BUG_ON(vi->num != 0);
+	return 0;
+}
+
+static void *virtnet_probe(struct device *device,
+			   struct virtio_config_space *config,
+			   struct virtqueue_ops *vq_ops)
+{
+	int err, coff;
+	unsigned int len;
+	struct net_device *dev;
+	struct virtnet_info *vi;
+
+	/* Allocate ourselves a network device with room for our info */
+	dev = alloc_etherdev(sizeof(struct virtnet_info));
+	if (!dev)
+		return ERR_PTR(-ENOMEM);
+
+	/* Set up network device as normal. */
+	SET_MODULE_OWNER(dev);
+	ether_setup(dev);
+	dev->open = virtnet_open;
+	dev->stop = virtnet_close;
+	dev->poll = virtnet_poll;
+	dev->hard_start_xmit = start_xmit;
+	dev->weight = 16;
+	dev->features = NETIF_F_HIGHDMA;
+	SET_NETDEV_DEV(dev, device);
+
+	/* Do we support "hardware" checksums? */
+	coff = virtio_config_find(config, VIRTIO_CONFIG_NET_F, &len);
+	if (virtio_use_bit(config, coff, len, VIRTIO_NET_F_NO_CSUM)) {
+		/* This opens up the world of extra features. */
+		dev->features |= NETIF_F_HW_CSUM|NETIF_F_SG|NETIF_F_FRAGLIST;
+		if (virtio_use_bit(config, coff, len, VIRTIO_NET_F_TSO4))
+			dev->features |= NETIF_F_TSO;
+		if (virtio_use_bit(config, coff, len, VIRTIO_NET_F_UFO))
+			dev->features |= NETIF_F_UFO;
+		if (virtio_use_bit(config, coff, len, VIRTIO_NET_F_TSO4_ECN))
+			dev->features |= NETIF_F_TSO_ECN;
+		if (virtio_use_bit(config, coff, len, VIRTIO_NET_F_TSO6))
+			dev->features |= NETIF_F_TSO6;
+	}
+
+	/* Configuration may specify what MAC to use.  Otherwise random. */
+	coff = virtio_config_find(config, VIRTIO_CONFIG_NET_MAC_F, &len);
+	if (coff >= 0) {
+		dev->addr_len = len;
+		virtio_config_get(config, coff, len, dev->dev_addr);
+	} else
+		random_ether_addr(dev->dev_addr);
+
+	/* Set up our device-specific information */
+	vi = netdev_priv(dev);
+	vi->ndev = dev;
+	vi->vq_ops = vq_ops;
+
+	/* We expect two virtqueues, receive then send. */
+	vi->vq_recv = virtio_config_vq(config, vq_ops, device,
+				       skb_recv_done, dev);
+	if (IS_ERR(vi->vq_recv)) {
+		err = PTR_ERR(vi->vq_recv);
+		goto free;
+	}
+
+	vi->vq_send = virtio_config_vq(config, vq_ops, device,
+				       skb_xmit_done, dev);
+	if (IS_ERR(vi->vq_send)) {
+		err = PTR_ERR(vi->vq_send);
+		goto free_recv;
+	}
+
+	/* Initialize our empty receive and send queues. */
+	skb_queue_head_init(&vi->recv);
+	skb_queue_head_init(&vi->send);
+
+	err = register_netdev(dev);
+	if (err) {
+		pr_debug("virtio_net: registering device failed\n");
+		goto free_send;
+	}
+	pr_debug("virtnet: registered device %s\n", dev->name);
+	return dev;
+
+free_send:
+	vq_ops->free_vq(vi->vq_send);
+free_recv:
+	vq_ops->free_vq(vi->vq_recv);
+free:
+	free_netdev(dev);
+	return ERR_PTR(err);
+}
+
+static void virtnet_remove(void *dev)
+{
+	unregister_netdev(dev);
+	free_netdev(dev);
+}
+
+static struct pci_device_id id_table[] = {
+	VIRTIO_DEV_ID(VIRTIO_ID_NET, PCI_CLASS_NETWORK_OTHER),
+	{ 0 },
+};
+
+static struct virtio_driver virtio_net = {
+	.name =         KBUILD_MODNAME,
+	.owner =        THIS_MODULE,
+	.id_table =     id_table,
+	.probe =        virtnet_probe,
+	.remove =       __devexit_p(virtnet_remove),
+};
+
+static int __init init(void)
+{
+	return register_virtio_driver(&virtio_net);
+}
+
+static void __exit fini(void)
+{
+	unregister_virtio_driver(&virtio_net);
+}
+module_init(init);
+module_exit(fini);
+
+MODULE_DEVICE_TABLE(pci, id_table);
+MODULE_DESCRIPTION("Virtio network driver");
+MODULE_LICENSE("GPL");
===================================================================
--- /dev/null
+++ b/include/linux/virtio_net.h
@@ -0,0 +1,36 @@
+#ifndef _LINUX_VIRTIO_NET_H
+#define _LINUX_VIRTIO_NET_H
+#include <linux/virtio_config.h>
+
+/* The ID for virtio_net */
+#define VIRTIO_ID_NET	1
+
+/* The bitmap of config for virtio net */
+#define VIRTIO_CONFIG_NET_F	0x40
+#define VIRTIO_NET_F_NO_CSUM	1
+#define VIRTIO_NET_F_TSO4	2
+#define VIRTIO_NET_F_UFO	4
+#define VIRTIO_NET_F_TSO4_ECN	8
+#define VIRTIO_NET_F_TSO6	16
+
+/* The config defining mac address. */
+#define VIRTIO_CONFIG_NET_MAC_F	0x41
+
+/* This is the first element of the scatter-gather list.  If you don't
+ * specify GSO or CSUM features, you can simply ignore the header. */
+struct virtio_net_hdr
+{
+#define VIRTIO_NET_HDR_F_NEEDS_CSUM	1	// Use csum_start, csum_offset
+      __u8 flags;
+#define VIRTIO_NET_HDR_GSO_NONE		0	// Not a GSO frame
+#define VIRTIO_NET_HDR_GSO_TCPV4	1	// GSO frame, IPv4 TCP (TSO)
+/* FIXME: Do we need this?  If they said they can handle ECN, do they care? */
+#define VIRTIO_NET_HDR_GSO_TCPV4_ECN	2	// GSO frame, IPv4 TCP w/ ECN
+#define VIRTIO_NET_HDR_GSO_UDP		3	// GSO frame, IPv4 UDP (UFO)
+#define VIRTIO_NET_HDR_GSO_TCPV6	4	// GSO frame, IPv6 TCP
+      __u8 gso_type;
+      __u16 gso_size;
+      __u16 csum_start;
+      __u16 csum_offset;
+};
+#endif /* _LINUX_VIRTIO_NET_H */
