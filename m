From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] virtio_net: Extend virtio to use VF datapath when
	available
Date: Thu, 21 Dec 2017 02:14:46 +0200
Message-ID: <20171221021155-mutt-send-email-mst__33310.8011204333$1513815187$gmane$org@kernel.org>
References: <1513644036-45230-1-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1513644036-45230-1-git-send-email-sridhar.samudrala@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Dec 18, 2017 at 04:40:36PM -0800, Sridhar Samudrala wrote:
> This patch enables virtio to switch over to a VF datapath when a VF netdev
> is present with the same MAC address.

I prefer saying "a passthrough device" here. Does not have to be a VF at
all.

>  It allows live migration of a VM
> with a direct attached VF without the need to setup a bond/team between a
> VF and virtio net device in the guest.
> 
> The hypervisor needs to unplug the VF device from the guest on the source
> host and reset the MAC filter of the VF to initiate failover of datapath to
> virtio before starting the migration. After the migration is completed, the
> destination hypervisor sets the MAC filter on the VF and plugs it back to
> the guest to switch over to VF datapath.
> 
> It is entirely based on netvsc implementation and it should be possible to
> make this code generic and move it to a common location that can be shared
> by netvsc and virtio.
> 
> Also, i think we should make this a negotiated feature that is off by
> default via a new feature bit.

So please include this. A copy needs to go to virtio TC
to reserve the bit. Enabling this by default risks breaking
too many configurations.

> 
> This patch is based on the discussion initiated by Jesse on this thread.
> https://marc.info/?l=linux-virtualization&m=151189725224231&w=2
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/virtio_net.c | 341 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 339 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 559b215c0169..a34c717bb15b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -31,6 +31,8 @@
>  #include <linux/average.h>
>  #include <linux/filter.h>
>  #include <net/route.h>
> +#include <linux/netdevice.h>
> +#include <linux/netpoll.h>
>  
>  static int napi_weight = NAPI_POLL_WEIGHT;
>  module_param(napi_weight, int, 0444);
> @@ -56,6 +58,8 @@ module_param(napi_tx, bool, 0644);
>   */
>  DECLARE_EWMA(pkt_len, 0, 64)
>  
> +#define VF_TAKEOVER_INT	(HZ / 10)
> +
>  #define VIRTNET_DRIVER_VERSION "1.0.0"
>  
>  static const unsigned long guest_offloads[] = {
> @@ -117,6 +121,15 @@ struct receive_queue {
>  	char name[40];
>  };
>  
> +struct virtnet_vf_pcpu_stats {
> +	u64	rx_packets;
> +	u64	rx_bytes;
> +	u64	tx_packets;
> +	u64	tx_bytes;
> +	struct u64_stats_sync   syncp;
> +	u32	tx_dropped;
> +};
> +
>  struct virtnet_info {
>  	struct virtio_device *vdev;
>  	struct virtqueue *cvq;
> @@ -179,6 +192,11 @@ struct virtnet_info {
>  	u32 speed;
>  
>  	unsigned long guest_offloads;
> +
> +	/* State to manage the associated VF interface. */
> +	struct net_device __rcu *vf_netdev;
> +	struct virtnet_vf_pcpu_stats __percpu *vf_stats;
> +	struct delayed_work vf_takeover;
>  };
>  
>  struct padded_vnet_hdr {
> @@ -1300,16 +1318,51 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
>  	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
>  }
>  
> +/* Send skb on the slave VF device. */
> +static int virtnet_vf_xmit(struct net_device *dev, struct net_device *vf_netdev,
> +			   struct sk_buff *skb)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +	unsigned int len = skb->len;
> +	int rc;
> +
> +	skb->dev = vf_netdev;
> +	skb->queue_mapping = qdisc_skb_cb(skb)->slave_dev_queue_mapping;
> +
> +	rc = dev_queue_xmit(skb);
> +	if (likely(rc == NET_XMIT_SUCCESS || rc == NET_XMIT_CN)) {
> +		struct virtnet_vf_pcpu_stats *pcpu_stats
> +			= this_cpu_ptr(vi->vf_stats);
> +
> +		u64_stats_update_begin(&pcpu_stats->syncp);
> +		pcpu_stats->tx_packets++;
> +		pcpu_stats->tx_bytes += len;
> +		u64_stats_update_end(&pcpu_stats->syncp);
> +	} else {
> +		this_cpu_inc(vi->vf_stats->tx_dropped);
> +	}
> +
> +	return rc;
> +}
> +
>  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int qnum = skb_get_queue_mapping(skb);
>  	struct send_queue *sq = &vi->sq[qnum];
> +	struct net_device *vf_netdev;
>  	int err;
>  	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
>  	bool kick = !skb->xmit_more;
>  	bool use_napi = sq->napi.weight;
>  
> +	/* if VF is present and up then redirect packets
> +	 * called with rcu_read_lock_bh
> +	 */
> +	vf_netdev = rcu_dereference_bh(vi->vf_netdev);
> +	if (vf_netdev && netif_running(vf_netdev) && !netpoll_tx_running(dev))
> +		return virtnet_vf_xmit(dev, vf_netdev, skb);
> +
>  	/* Free up any pending old buffers before queueing new ones. */
>  	free_old_xmit_skbs(sq);
>  
> @@ -1456,10 +1509,41 @@ static int virtnet_set_mac_address(struct net_device *dev, void *p)
>  	return ret;
>  }
>  
> +static void virtnet_get_vf_stats(struct net_device *dev,
> +				 struct virtnet_vf_pcpu_stats *tot)
> +{
> +	struct virtnet_info *vi = netdev_priv(dev);
> +	int i;
> +
> +	memset(tot, 0, sizeof(*tot));
> +
> +	for_each_possible_cpu(i) {
> +		const struct virtnet_vf_pcpu_stats *stats
> +				= per_cpu_ptr(vi->vf_stats, i);
> +		u64 rx_packets, rx_bytes, tx_packets, tx_bytes;
> +		unsigned int start;
> +
> +		do {
> +			start = u64_stats_fetch_begin_irq(&stats->syncp);
> +			rx_packets = stats->rx_packets;
> +			tx_packets = stats->tx_packets;
> +			rx_bytes = stats->rx_bytes;
> +			tx_bytes = stats->tx_bytes;
> +		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
> +
> +		tot->rx_packets += rx_packets;
> +		tot->tx_packets += tx_packets;
> +		tot->rx_bytes   += rx_bytes;
> +		tot->tx_bytes   += tx_bytes;
> +		tot->tx_dropped += stats->tx_dropped;
> +	}
> +}
> +
>  static void virtnet_stats(struct net_device *dev,
>  			  struct rtnl_link_stats64 *tot)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> +	struct virtnet_vf_pcpu_stats vf_stats;
>  	int cpu;
>  	unsigned int start;
>  
> @@ -1490,6 +1574,13 @@ static void virtnet_stats(struct net_device *dev,
>  	tot->rx_dropped = dev->stats.rx_dropped;
>  	tot->rx_length_errors = dev->stats.rx_length_errors;
>  	tot->rx_frame_errors = dev->stats.rx_frame_errors;
> +
> +	virtnet_get_vf_stats(dev, &vf_stats);
> +	tot->rx_packets += vf_stats.rx_packets;
> +	tot->tx_packets += vf_stats.tx_packets;
> +	tot->rx_bytes += vf_stats.rx_bytes;
> +	tot->tx_bytes += vf_stats.tx_bytes;
> +	tot->tx_dropped += vf_stats.tx_dropped;
>  }
>  
>  #ifdef CONFIG_NET_POLL_CONTROLLER
> @@ -2508,6 +2599,47 @@ static int virtnet_validate(struct virtio_device *vdev)
>  	return 0;
>  }
>  
> +static void __virtnet_vf_setup(struct net_device *ndev,
> +			       struct net_device *vf_netdev)
> +{
> +	int ret;
> +
> +	/* Align MTU of VF with master */
> +	ret = dev_set_mtu(vf_netdev, ndev->mtu);
> +	if (ret)
> +		netdev_warn(vf_netdev,
> +			    "unable to change mtu to %u\n", ndev->mtu);
> +
> +	if (netif_running(ndev)) {
> +		ret = dev_open(vf_netdev);
> +		if (ret)
> +			netdev_warn(vf_netdev,
> +				    "unable to open: %d\n", ret);
> +	}
> +}
> +
> +/* Setup VF as slave of the virtio device.
> + * Runs in workqueue to avoid recursion in netlink callbacks.
> + */
> +static void virtnet_vf_setup(struct work_struct *w)
> +{
> +	struct virtnet_info *vi
> +		= container_of(w, struct virtnet_info, vf_takeover.work);
> +	struct net_device *ndev = vi->dev;
> +	struct net_device *vf_netdev;
> +
> +	if (!rtnl_trylock()) {
> +		schedule_delayed_work(&vi->vf_takeover, 0);
> +		return;
> +	}
> +
> +	vf_netdev = rtnl_dereference(vi->vf_netdev);
> +	if (vf_netdev)
> +		__virtnet_vf_setup(ndev, vf_netdev);
> +
> +	rtnl_unlock();
> +}
> +
>  static int virtnet_probe(struct virtio_device *vdev)
>  {
>  	int i, err;
> @@ -2600,6 +2732,11 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	}
>  
>  	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> +	INIT_DELAYED_WORK(&vi->vf_takeover, virtnet_vf_setup);
> +
> +	vi->vf_stats = netdev_alloc_pcpu_stats(struct virtnet_vf_pcpu_stats);
> +	if (!vi->vf_stats)
> +		goto free_stats;
>  
>  	/* If we can receive ANY GSO packets, we must allocate large ones. */
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> @@ -2634,7 +2771,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  			 */
>  			dev_err(&vdev->dev, "device MTU appears to have changed "
>  				"it is now %d < %d", mtu, dev->min_mtu);
> -			goto free_stats;
> +			goto free_vf_stats;
>  		}
>  
>  		dev->mtu = mtu;
> @@ -2658,7 +2795,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	/* Allocate/initialize the rx/tx queues, and invoke find_vqs */
>  	err = init_vqs(vi);
>  	if (err)
> -		goto free_stats;
> +		goto free_vf_stats;
>  
>  #ifdef CONFIG_SYSFS
>  	if (vi->mergeable_rx_bufs)
> @@ -2712,6 +2849,8 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	cancel_delayed_work_sync(&vi->refill);
>  	free_receive_page_frags(vi);
>  	virtnet_del_vqs(vi);
> +free_vf_stats:
> +	free_percpu(vi->vf_stats);
>  free_stats:
>  	free_percpu(vi->stats);
>  free:
> @@ -2733,19 +2872,178 @@ static void remove_vq_common(struct virtnet_info *vi)
>  	virtnet_del_vqs(vi);
>  }
>  
> +static struct net_device *get_virtio_bymac(const u8 *mac)
> +{
> +	struct net_device *dev;
> +
> +	ASSERT_RTNL();
> +
> +	for_each_netdev(&init_net, dev) {
> +		if (dev->netdev_ops != &virtnet_netdev)
> +			continue;       /* not a virtio_net device */
> +
> +		if (ether_addr_equal(mac, dev->perm_addr))
> +			return dev;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct net_device *get_virtio_byref(struct net_device *vf_netdev)
> +{
> +	struct net_device *dev;
> +
> +	ASSERT_RTNL();
> +
> +	for_each_netdev(&init_net, dev) {
> +		struct virtnet_info *vi;
> +
> +		if (dev->netdev_ops != &virtnet_netdev)
> +			continue;	/* not a virtio_net device */
> +
> +		vi = netdev_priv(dev);
> +		if (rtnl_dereference(vi->vf_netdev) == vf_netdev)
> +			return dev;	/* a match */
> +	}
> +
> +	return NULL;
> +}
> +
> +/* Called when VF is injecting data into network stack.
> + * Change the associated network device from VF to virtio.
> + * note: already called with rcu_read_lock
> + */
> +static rx_handler_result_t virtnet_vf_handle_frame(struct sk_buff **pskb)
> +{
> +	struct sk_buff *skb = *pskb;
> +	struct net_device *ndev = rcu_dereference(skb->dev->rx_handler_data);
> +	struct virtnet_info *vi = netdev_priv(ndev);
> +	struct virtnet_vf_pcpu_stats *pcpu_stats =
> +				this_cpu_ptr(vi->vf_stats);
> +
> +	skb->dev = ndev;
> +
> +	u64_stats_update_begin(&pcpu_stats->syncp);
> +	pcpu_stats->rx_packets++;
> +	pcpu_stats->rx_bytes += skb->len;
> +	u64_stats_update_end(&pcpu_stats->syncp);
> +
> +	return RX_HANDLER_ANOTHER;
> +}
> +
> +static int virtnet_vf_join(struct net_device *vf_netdev,
> +			   struct net_device *ndev)
> +{
> +	struct virtnet_info *vi = netdev_priv(ndev);
> +	int ret;
> +
> +	ret = netdev_rx_handler_register(vf_netdev,
> +					 virtnet_vf_handle_frame, ndev);
> +	if (ret != 0) {
> +		netdev_err(vf_netdev,
> +			   "can not register virtio VF receive handler (err = %d)\n",
> +			   ret);
> +		goto rx_handler_failed;
> +	}
> +
> +	ret = netdev_upper_dev_link(vf_netdev, ndev, NULL);
> +	if (ret != 0) {
> +		netdev_err(vf_netdev,
> +			   "can not set master device %s (err = %d)\n",
> +			   ndev->name, ret);
> +		goto upper_link_failed;
> +	}
> +
> +	/* set slave flag before open to prevent IPv6 addrconf */
> +	vf_netdev->flags |= IFF_SLAVE;
> +
> +	schedule_delayed_work(&vi->vf_takeover, VF_TAKEOVER_INT);
> +
> +	call_netdevice_notifiers(NETDEV_JOIN, vf_netdev);
> +
> +	netdev_info(vf_netdev, "joined to %s\n", ndev->name);
> +	return 0;
> +
> +upper_link_failed:
> +	netdev_rx_handler_unregister(vf_netdev);
> +rx_handler_failed:
> +	return ret;
> +}
> +
> +static int virtnet_register_vf(struct net_device *vf_netdev)
> +{
> +	struct net_device *ndev;
> +	struct virtnet_info *vi;
> +
> +	if (vf_netdev->addr_len != ETH_ALEN)
> +		return NOTIFY_DONE;
> +
> +	/* We will use the MAC address to locate the virtio_net interface to
> +	 * associate with the VF interface. If we don't find a matching
> +	 * virtio interface, move on.
> +	 */
> +	ndev = get_virtio_bymac(vf_netdev->perm_addr);
> +	if (!ndev)
> +		return NOTIFY_DONE;
> +
> +	vi = netdev_priv(ndev);
> +	if (rtnl_dereference(vi->vf_netdev))
> +		return NOTIFY_DONE;
> +
> +	if (virtnet_vf_join(vf_netdev, ndev) != 0)
> +		return NOTIFY_DONE;
> +
> +	netdev_info(ndev, "VF registering %s\n", vf_netdev->name);
> +
> +	dev_hold(vf_netdev);
> +	rcu_assign_pointer(vi->vf_netdev, vf_netdev);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int virtnet_unregister_vf(struct net_device *vf_netdev)
> +{
> +	struct net_device *ndev;
> +	struct virtnet_info *vi;
> +
> +	ndev = get_virtio_byref(vf_netdev);
> +	if (!ndev)
> +		return NOTIFY_DONE;
> +
> +	vi = netdev_priv(ndev);
> +	cancel_delayed_work_sync(&vi->vf_takeover);
> +
> +	netdev_info(ndev, "VF unregistering %s\n", vf_netdev->name);
> +
> +	netdev_rx_handler_unregister(vf_netdev);
> +	netdev_upper_dev_unlink(vf_netdev, ndev);
> +	RCU_INIT_POINTER(vi->vf_netdev, NULL);
> +	dev_put(vf_netdev);
> +
> +	return NOTIFY_OK;
> +}
> +
>  static void virtnet_remove(struct virtio_device *vdev)
>  {
>  	struct virtnet_info *vi = vdev->priv;
> +	struct net_device *vf_netdev;
>  
>  	virtnet_cpu_notif_remove(vi);
>  
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vi->config_work);
>  
> +	rtnl_lock();
> +	vf_netdev = rtnl_dereference(vi->vf_netdev);
> +	if (vf_netdev)
> +		virtnet_unregister_vf(vf_netdev);
> +	rtnl_unlock();
> +
>  	unregister_netdev(vi->dev);
>  
>  	remove_vq_common(vi);
>  
> +	free_percpu(vi->vf_stats);
>  	free_percpu(vi->stats);
>  	free_netdev(vi->dev);
>  }
> @@ -2823,6 +3121,42 @@ static struct virtio_driver virtio_net_driver = {
>  #endif
>  };
>  
> +static int virtio_netdev_event(struct notifier_block *this,
> +			       unsigned long event, void *ptr)
> +{
> +	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
> +
> +	/* Skip our own events */
> +	if (event_dev->netdev_ops == &virtnet_netdev)
> +		return NOTIFY_DONE;
> +
> +	/* Avoid non-Ethernet type devices */
> +	if (event_dev->type != ARPHRD_ETHER)
> +		return NOTIFY_DONE;
> +
> +	/* Avoid Vlan dev with same MAC registering as VF */
> +	if (is_vlan_dev(event_dev))
> +		return NOTIFY_DONE;
> +
> +	/* Avoid Bonding master dev with same MAC registering as VF */
> +	if ((event_dev->priv_flags & IFF_BONDING) &&
> +	    (event_dev->flags & IFF_MASTER))
> +		return NOTIFY_DONE;
> +
> +	switch (event) {
> +	case NETDEV_REGISTER:
> +		return virtnet_register_vf(event_dev);
> +	case NETDEV_UNREGISTER:
> +		return virtnet_unregister_vf(event_dev);
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +}
> +
> +static struct notifier_block virtio_netdev_notifier = {
> +	.notifier_call = virtio_netdev_event,
> +};
> +
>  static __init int virtio_net_driver_init(void)
>  {
>  	int ret;
> @@ -2841,6 +3175,8 @@ static __init int virtio_net_driver_init(void)
>          ret = register_virtio_driver(&virtio_net_driver);
>  	if (ret)
>  		goto err_virtio;
> +
> +	register_netdevice_notifier(&virtio_netdev_notifier);
>  	return 0;
>  err_virtio:
>  	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
> @@ -2853,6 +3189,7 @@ module_init(virtio_net_driver_init);
>  
>  static __exit void virtio_net_driver_exit(void)
>  {
> +	unregister_netdevice_notifier(&virtio_netdev_notifier);
>  	unregister_virtio_driver(&virtio_net_driver);
>  	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
>  	cpuhp_remove_multi_state(virtionet_online);
> -- 
> 2.14.3
