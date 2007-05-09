From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [patch 7/9] lguest: the net driver
Date: Wed, 09 May 2007 08:28:21 -0400
Message-ID: <4641BE65.3030807@garzik.org>
References: <200705090951.l499pdOr020406@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757907AbXEIM2j@vger.kernel.org>
In-Reply-To: <200705090951.l499pdOr020406@shell0.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, ak@suse.de, jmorris@namei.org
List-Id: virtualization@lists.linuxfoundation.org

akpm@linux-foundation.org wrote:
> +static void transfer_packet(struct net_device *dev,
> +			    struct sk_buff *skb,
> +			    unsigned int peernum)
> +{
> +	struct lguestnet_info *info = dev->priv;
> +	struct lguest_dma dma;
> +
> +	skb_to_dma(skb, skb_headlen(skb), &dma);
> +	pr_debug("xfer length %04x (%u)\n", htons(skb->len), skb->len);
> +
> +	hcall(LHCALL_SEND_DMA, peer_key(info,peernum), __pa(&dma), 0);

__pa() should not be used in any driver.

At the very least, lguest helper code should wrap this.



> +static irqreturn_t lguestnet_rcv(int irq, void *dev_id)
> +{
> +	struct net_device *dev = dev_id;
> +	struct lguestnet_info *info = dev->priv;
> +	unsigned int i, done = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(info->dma); i++) {
> +		unsigned int length;
> +		struct sk_buff *skb;
> +
> +		length = info->dma[i].used_len;
> +		if (length == 0)
> +			continue;
> +
> +		done++;
> +		skb = info->skb[i];
> +		fill_slot(dev, i);
> +
> +		if (length < ETH_HLEN || length > ETH_HLEN + ETH_DATA_LEN) {
> +			pr_debug(KERN_WARNING "%s: unbelievable skb len: %i\n",
> +				 dev->name, length);
> +			dev_kfree_skb(skb);
> +			continue;
> +		}
> +
> +		skb_put(skb, length);
> +		skb->protocol = eth_type_trans(skb, dev);
> +		/* This is a reliable transport. */
> +		if (dev->features & NETIF_F_NO_CSUM)
> +			skb->ip_summed = CHECKSUM_UNNECESSARY;
> +		pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
> +			 ntohs(skb->protocol), skb->len, skb->pkt_type);
> +
> +		dev->stats.rx_bytes += skb->len;
> +		dev->stats.rx_packets++;
> +		netif_rx(skb);
> +	}
> +	return done ? IRQ_HANDLED : IRQ_NONE;

Using NAPI would be preferable...



> +static int lguestnet_probe(struct lguest_device *lgdev)
> +{
> +	int err, irqf = IRQF_SHARED;
> +	struct net_device *dev;
> +	struct lguestnet_info *info;
> +	struct lguest_device_desc *desc = &lguest_devices[lgdev->index];
> +
> +	pr_debug("lguest_net: probing for device %i\n", lgdev->index);
> +
> +	dev = alloc_etherdev(sizeof(struct lguestnet_info));
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	SET_MODULE_OWNER(dev);
> +
> +	/* Ethernet defaults with some changes */
> +	ether_setup(dev);
> +	dev->set_mac_address = NULL;

why NULL?


> +	dev->dev_addr[0] = 0x02; /* set local assignment bit (IEEE802) */
> +	dev->dev_addr[1] = 0x00;
> +	memcpy(&dev->dev_addr[2], &lguest_data.guestid, 2);
> +	dev->dev_addr[4] = 0x00;
> +	dev->dev_addr[5] = 0x00;
> +
> +	dev->open = lguestnet_open;
> +	dev->stop = lguestnet_close;
> +	dev->hard_start_xmit = lguestnet_start_xmit;
> +
> +	/* Turning on/off promisc will call dev->set_multicast_list.
> +	 * We don't actually support multicast yet */
> +	dev->set_multicast_list = lguestnet_set_multicast;
> +	dev->mem_start = ((unsigned long)desc->pfn << PAGE_SHIFT);
> +	dev->mem_end = dev->mem_start + PAGE_SIZE * desc->num_pages;
> +	dev->irq = lgdev->index+1;

don't fill in mem_start, mem_end and irq.  they are useless, and for 
lguest, misleading.


> +	dev->features = NETIF_F_SG;
> +	if (desc->features & LGUEST_NET_F_NOCSUM)
> +		dev->features |= NETIF_F_NO_CSUM;

do not set SG without an accompanying csum bitflag


> +	info = dev->priv;

use netdev_priv()


> +	info->mapsize = PAGE_SIZE * desc->num_pages;
> +	info->peer_phys = ((unsigned long)desc->pfn << PAGE_SHIFT);
> +	info->peer = (void *)ioremap(info->peer_phys, info->mapsize);

check for NULL


> +	/* This stores our peerid (upper bits reserved for future). */
> +	info->me = (desc->features & (info->mapsize-1));
> +
> +	err = register_netdev(dev);
> +	if (err) {
> +		pr_debug("lguestnet: registering device failed\n");
> +		goto free;
> +	}
> +
> +	if (lguest_devices[lgdev->index].features & LGUEST_DEVICE_F_RANDOMNESS)
> +		irqf |= IRQF_SAMPLE_RANDOM;
> +	if (request_irq(dev->irq, lguestnet_rcv, irqf, "lguestnet", dev) != 0) {
> +		pr_debug("lguestnet: could not get net irq %i\n", dev->irq);
> +		goto unregister;
> +	}
> +
> +	pr_debug("lguestnet: registered device %s\n", dev->name);
> +	lgdev->private = dev;
> +	return 0;
> +
> +unregister:
> +	unregister_netdev(dev);
> +free:
> +	free_netdev(dev);

missing iounmap() on error


> +static struct lguest_driver lguestnet_drv = {
> +	.name = "lguestnet",
> +	.owner = THIS_MODULE,
> +	.device_type = LGUEST_DEVICE_T_NET,
> +	.probe = lguestnet_probe,
> +};

You are distinctly missing module remove support

	Jeff
