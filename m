From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 6/8] lguest: the net driver
Date: Tue, 10 Apr 2007 21:11:15 +1000
Message-ID: <1176203475.26372.37.camel__2440.08793165467$1176215176$gmane$org@localhost.localdomain>
References: <1176203068.26372.21.camel@localhost.localdomain>
	<1176203130.26372.23.camel@localhost.localdomain>
	<1176203176.26372.25.camel@localhost.localdomain>
	<1176203231.26372.27.camel@localhost.localdomain>
	<1176203285.26372.29.camel@localhost.localdomain>
	<1176203333.26372.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1176203333.26372.31.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <ak@muc.de>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Lguest net driver

A simple net driver for lguest.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/Makefile     |    1 =

 drivers/net/lguest_net.c |  355 ++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 356 insertions(+)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -220,3 +220,4 @@ obj-$(CONFIG_FS_ENET) +=3D fs_enet/
 obj-$(CONFIG_FS_ENET) +=3D fs_enet/
 =

 obj-$(CONFIG_NETXEN_NIC) +=3D netxen/
+obj-$(CONFIG_LGUEST_GUEST) +=3D lguest_net.o
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/drivers/net/lguest_net.c
@@ -0,0 +1,355 @@
+/* A simple network driver for lguest.
+ *
+ * Copyright 2006 Rusty Russell <rusty@rustcorp.com.au> IBM Corporation
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA
+ */
+//#define DEBUG
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/module.h>
+#include <linux/mm_types.h>
+#include <linux/lguest_bus.h>
+#include <asm/io.h>
+
+#define SHARED_SIZE		PAGE_SIZE
+#define MAX_LANS		4
+#define NUM_SKBS		8
+
+struct lguestnet_info
+{
+	/* The shared page(s). */
+	struct lguest_net *peer;
+	unsigned long peer_phys;
+	unsigned long mapsize;
+
+	/* My peerid. */
+	unsigned int me;
+
+	struct net_device_stats stats;
+
+	/* Receive queue. */
+	struct sk_buff *skb[NUM_SKBS];
+	struct lguest_dma dma[NUM_SKBS];
+};
+
+/* How many bytes left in this page. */
+static unsigned int rest_of_page(void *data)
+{
+	return PAGE_SIZE - ((unsigned long)data % PAGE_SIZE);
+}
+
+/* Simple convention: offset 4 * peernum. */
+static unsigned long peer_key(struct lguestnet_info *info, unsigned peernu=
m)
+{
+	return info->peer_phys + 4 * peernum;
+}
+
+static void skb_to_dma(const struct sk_buff *skb, unsigned int headlen,
+		       struct lguest_dma *dma)
+{
+	unsigned int i, seg;
+
+	for (i =3D seg =3D 0; i < headlen; seg++, i +=3D rest_of_page(skb->data+i=
)) {
+		dma->addr[seg] =3D virt_to_phys(skb->data + i);
+		dma->len[seg] =3D min((unsigned)(headlen - i),
+				    rest_of_page(skb->data + i));
+	}
+	for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++, seg++) {
+		const skb_frag_t *f =3D &skb_shinfo(skb)->frags[i];
+		/* Should not happen with MTU less than 64k - 2 * PAGE_SIZE. */
+		if (seg =3D=3D LGUEST_MAX_DMA_SECTIONS) {
+			printk("Woah dude!  Megapacket!\n");
+			break;
+		}
+		dma->addr[seg] =3D page_to_phys(f->page) + f->page_offset;
+		dma->len[seg] =3D f->size;
+	}
+	if (seg < LGUEST_MAX_DMA_SECTIONS)
+		dma->len[seg] =3D 0;
+}
+
+/* We overload multicast bit to show promiscuous mode. */
+#define PROMISC_BIT		0x01
+
+static void lguestnet_set_multicast(struct net_device *dev)
+{
+	struct lguestnet_info *info =3D dev->priv;
+
+	if ((dev->flags & (IFF_PROMISC|IFF_ALLMULTI)) || dev->mc_count)
+		info->peer[info->me].mac[0] |=3D PROMISC_BIT;
+	else
+		info->peer[info->me].mac[0] &=3D ~PROMISC_BIT;
+}
+
+static int promisc(struct lguestnet_info *info, unsigned int peer)
+{
+	return info->peer[peer].mac[0] & PROMISC_BIT;
+}
+
+static int mac_eq(const unsigned char mac[ETH_ALEN],
+		  struct lguestnet_info *info, unsigned int peer)
+{
+	/* Ignore multicast bit, which peer turns on to mean promisc. */
+	if ((info->peer[peer].mac[0] & (~PROMISC_BIT)) !=3D mac[0])
+		return 0;
+	return memcmp(mac+1, info->peer[peer].mac+1, ETH_ALEN-1) =3D=3D 0;
+}
+
+static void transfer_packet(struct net_device *dev,
+			    struct sk_buff *skb,
+			    unsigned int peernum)
+{
+	struct lguestnet_info *info =3D dev->priv;
+	struct lguest_dma dma;
+
+	skb_to_dma(skb, skb_headlen(skb), &dma);
+	pr_debug("xfer length %04x (%u)\n", htons(skb->len), skb->len);
+
+	hcall(LHCALL_SEND_DMA, peer_key(info,peernum), __pa(&dma), 0);
+	if (dma.used_len !=3D skb->len) {
+		info->stats.tx_carrier_errors++;
+		pr_debug("Bad xfer to peer %i: %i of %i (dma %p/%i)\n",
+			 peernum, dma.used_len, skb->len,
+			 (void *)dma.addr[0], dma.len[0]);
+	} else {
+		info->stats.tx_bytes +=3D skb->len;
+		info->stats.tx_packets++;
+	}
+}
+
+static int unused_peer(const struct lguest_net peer[], unsigned int num)
+{
+	return peer[num].mac[0] =3D=3D 0;
+}
+
+static int lguestnet_start_xmit(struct sk_buff *skb, struct net_device *de=
v)
+{
+	unsigned int i;
+	int broadcast;
+	struct lguestnet_info *info =3D dev->priv;
+	const unsigned char *dest =3D ((struct ethhdr *)skb->data)->h_dest;
+
+	pr_debug("%s: xmit %02x:%02x:%02x:%02x:%02x:%02x\n",
+		 dev->name, dest[0],dest[1],dest[2],dest[3],dest[4],dest[5]);
+
+	broadcast =3D is_multicast_ether_addr(dest);
+	for (i =3D 0; i < info->mapsize/sizeof(struct lguest_net); i++) {
+		if (i =3D=3D info->me || unused_peer(info->peer, i))
+			continue;
+
+		if (!broadcast && !promisc(info, i) && !mac_eq(dest, info, i))
+			continue;
+
+		pr_debug("lguestnet %s: sending from %i to %i\n",
+			 dev->name, info->me, i);
+		transfer_packet(dev, skb, i);
+	}
+	dev_kfree_skb(skb);
+	return 0;
+}
+
+/* Find a new skb to put in this slot in shared mem. */
+static int fill_slot(struct net_device *dev, unsigned int slot)
+{
+	struct lguestnet_info *info =3D dev->priv;
+	/* Try to create and register a new one. */
+	info->skb[slot] =3D netdev_alloc_skb(dev, ETH_HLEN + ETH_DATA_LEN);
+	if (!info->skb[slot]) {
+		printk("%s: could not fill slot %i\n", dev->name, slot);
+		return -ENOMEM;
+	}
+
+	skb_to_dma(info->skb[slot], ETH_HLEN + ETH_DATA_LEN, &info->dma[slot]);
+	wmb();
+	/* Now we tell hypervisor it can use the slot. */
+	info->dma[slot].used_len =3D 0;
+	return 0;
+}
+
+static irqreturn_t lguestnet_rcv(int irq, void *dev_id)
+{
+	struct net_device *dev =3D dev_id;
+	struct lguestnet_info *info =3D dev->priv;
+	unsigned int i, done =3D 0;
+
+	for (i =3D 0; i < ARRAY_SIZE(info->dma); i++) {
+		unsigned int length;
+		struct sk_buff *skb;
+
+		length =3D info->dma[i].used_len;
+		if (length =3D=3D 0)
+			continue;
+
+		done++;
+		skb =3D info->skb[i];
+		fill_slot(dev, i);
+
+		if (length < ETH_HLEN || length > ETH_HLEN + ETH_DATA_LEN) {
+			pr_debug(KERN_WARNING "%s: unbelievable skb len: %i\n",
+				 dev->name, length);
+			dev_kfree_skb(skb);
+			continue;
+		}
+
+		skb_put(skb, length);
+		skb->protocol =3D eth_type_trans(skb, dev);
+		/* This is a reliable transport. */
+		if (dev->features & NETIF_F_NO_CSUM)
+			skb->ip_summed =3D CHECKSUM_UNNECESSARY;
+		pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
+			 ntohs(skb->protocol), skb->len, skb->pkt_type);
+
+		info->stats.rx_bytes +=3D skb->len;
+		info->stats.rx_packets++;
+		netif_rx(skb);
+	}
+	return done ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static int lguestnet_open(struct net_device *dev)
+{
+	int i;
+	struct lguestnet_info *info =3D dev->priv;
+
+	/* Set up our MAC address */
+	memcpy(info->peer[info->me].mac, dev->dev_addr, ETH_ALEN);
+
+	/* Turn on promisc mode if needed */
+	lguestnet_set_multicast(dev);
+
+	for (i =3D 0; i < ARRAY_SIZE(info->dma); i++) {
+		if (fill_slot(dev, i) !=3D 0)
+			goto cleanup;
+	}
+	if (!hcall(LHCALL_BIND_DMA, peer_key(info, info->me), __pa(info->dma),
+		   (NUM_SKBS << 8) | dev->irq))
+		goto cleanup;
+	return 0;
+
+cleanup:
+	while (--i >=3D 0)
+		dev_kfree_skb(info->skb[i]);
+	return -ENOMEM;
+}
+
+static int lguestnet_close(struct net_device *dev)
+{
+	unsigned int i;
+	struct lguestnet_info *info =3D dev->priv;
+
+	/* Clear all trace: others might deliver packets, we'll ignore it. */
+	memset(&info->peer[info->me], 0xFF, sizeof(info->peer[info->me]));
+
+	/* Deregister sg lists. */
+	hcall(LHCALL_BIND_DMA, peer_key(info, info->me), __pa(info->dma), 0);
+	for (i =3D 0; i < ARRAY_SIZE(info->dma); i++)
+		dev_kfree_skb(info->skb[i]);
+	return 0;
+}
+
+static struct net_device_stats *lguestnet_get_stats(struct net_device *dev)
+{
+	struct lguestnet_info *info =3D dev->priv;
+
+	return &info->stats;
+}
+
+static int lguestnet_probe(struct lguest_device *lgdev)
+{
+	int err, irqf =3D IRQF_SHARED;
+	struct net_device *dev;
+	struct lguestnet_info *info;
+	struct lguest_device_desc *desc =3D &lguest_devices[lgdev->index];
+
+	pr_debug("lguest_net: probing for device %i\n", lgdev->index);
+
+	dev =3D alloc_etherdev(sizeof(struct lguestnet_info));
+	if (!dev)
+		return -ENOMEM;
+
+	SET_MODULE_OWNER(dev);
+
+	/* Ethernet defaults with some changes */
+	ether_setup(dev);
+	dev->set_mac_address =3D NULL;
+
+	dev->dev_addr[0] =3D 0x02; /* set local assignment bit (IEEE802) */
+	dev->dev_addr[1] =3D 0x00;
+	memcpy(&dev->dev_addr[2], &lguest_data.guestid, 2);
+	dev->dev_addr[4] =3D 0x00;
+	dev->dev_addr[5] =3D 0x00;
+
+	dev->open =3D lguestnet_open;
+	dev->stop =3D lguestnet_close;
+	dev->hard_start_xmit =3D lguestnet_start_xmit;
+	dev->get_stats =3D lguestnet_get_stats;
+
+	/* Turning on/off promisc will call dev->set_multicast_list.
+	 * We don't actually support multicast yet */
+	dev->set_multicast_list =3D lguestnet_set_multicast;
+	dev->mem_start =3D ((unsigned long)desc->pfn << PAGE_SHIFT);
+	dev->mem_end =3D dev->mem_start + PAGE_SIZE * desc->num_pages;
+	dev->irq =3D lgdev->index+1;
+	dev->features =3D NETIF_F_SG;
+	if (desc->features & LGUEST_NET_F_NOCSUM)
+		dev->features |=3D NETIF_F_NO_CSUM;
+
+	info =3D dev->priv;
+	info->mapsize =3D PAGE_SIZE * desc->num_pages;
+	info->peer_phys =3D ((unsigned long)desc->pfn << PAGE_SHIFT);
+	info->peer =3D (void *)ioremap(info->peer_phys, info->mapsize);
+	/* This stores our peerid (upper bits reserved for future). */
+	info->me =3D (desc->features & (info->mapsize-1));
+
+	err =3D register_netdev(dev);
+	if (err) {
+		pr_debug("lguestnet: registering device failed\n");
+		goto free;
+	}
+
+	if (lguest_devices[lgdev->index].features & LGUEST_DEVICE_F_RANDOMNESS)
+		irqf |=3D IRQF_SAMPLE_RANDOM;
+	if (request_irq(dev->irq, lguestnet_rcv, irqf, "lguestnet", dev) !=3D 0) {
+		pr_debug("lguestnet: could not get net irq %i\n", dev->irq);
+		goto unregister;
+	}
+
+	pr_debug("lguestnet: registered device %s\n", dev->name);
+	lgdev->private =3D dev;
+	return 0;
+
+unregister:
+	unregister_netdev(dev);
+free:
+	free_netdev(dev);
+	return err;
+}
+
+static struct lguest_driver lguestnet_drv =3D {
+	.name =3D "lguestnet",
+	.owner =3D THIS_MODULE,
+	.device_type =3D LGUEST_DEVICE_T_NET,
+	.probe =3D lguestnet_probe,
+};
+
+static __init int lguestnet_init(void)
+{
+	return register_lguest_driver(&lguestnet_drv);
+}
+module_init(lguestnet_init);
+
+MODULE_DESCRIPTION("Lguest network driver");
+MODULE_LICENSE("GPL");
