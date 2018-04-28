From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v9 2/4] net: Introduce generic failover module
Date: Sat, 28 Apr 2018 11:06:01 +0200
Message-ID: <20180428090601.GL5632@nanopsycho.orion>
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
	<1524848820-42258-3-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1524848820-42258-3-git-send-email-sridhar.samudrala@intel.com>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, aaron.f.brown@intel.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Fri, Apr 27, 2018 at 07:06:58PM CEST, sridhar.samudrala@intel.com wrote:
>This provides a generic interface for paravirtual drivers to listen
>for netdev register/unregister/link change events from pci ethernet
>devices with the same MAC and takeover their datapath. The notifier and
>event handling code is based on the existing netvsc implementation.
>
>It exposes 2 sets of interfaces to the paravirtual drivers.
>1. For paravirtual drivers like virtio_net that use 3 netdev model, the
>   the failover module provides interfaces to create/destroy additional
>   master netdev and all the slave events are managed internally.
>        net_failover_create()
>        net_failover_destroy()
>   A failover netdev is created that acts a master device and controls 2
>   slave devices. The original virtio_net netdev is registered as 'standby'
>   netdev and a passthru/vf device with the same MAC gets registered as
>   'primary' netdev. Both 'standby' and 'primary' netdevs are associated
>   with the same 'pci' device.  The user accesses the network interface via
>   'failover' netdev. The 'failover' netdev chooses 'primary' netdev as
>   default for transmits when it is available with link up and running.
>2. For existing netvsc driver that uses 2 netdev model, no master netdev
>   is created. The paravirtual driver registers each instance of netvsc
>   as a 'failover' netdev  along with a set of ops to manage the slave
>   events. There is no 'standby' netdev in this model. A passthru/vf device
>   with the same MAC gets registered as 'primary' netdev.
>        net_failover_register()
>        net_failover_unregister()
>

First of all, I like this v9 very much. Nice progress!
Couple of notes inlined.


>Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>---
> include/linux/netdevice.h  |  16 +
> include/net/net_failover.h |  62 ++++
> net/Kconfig                |  10 +
> net/core/Makefile          |   1 +
> net/core/net_failover.c    | 892 +++++++++++++++++++++++++++++++++++++++++++++
> 5 files changed, 981 insertions(+)
> create mode 100644 include/net/net_failover.h
> create mode 100644 net/core/net_failover.c

[...]


>+static int net_failover_slave_register(struct net_device *slave_dev)
>+{
>+	struct net_failover_info *nfo_info;
>+	struct net_failover_ops *nfo_ops;
>+	struct net_device *failover_dev;
>+	bool slave_is_standby;
>+	u32 orig_mtu;
>+	int err;
>+
>+	ASSERT_RTNL();
>+
>+	failover_dev = net_failover_get_bymac(slave_dev->perm_addr, &nfo_ops);
>+	if (!failover_dev)
>+		goto done;
>+
>+	if (failover_dev->type != slave_dev->type)
>+		goto done;
>+
>+	if (nfo_ops && nfo_ops->slave_register)
>+		return nfo_ops->slave_register(slave_dev, failover_dev);
>+
>+	nfo_info = netdev_priv(failover_dev);
>+	slave_is_standby = (slave_dev->dev.parent == failover_dev->dev.parent);

No parentheses needed.


>+	if (slave_is_standby ? rtnl_dereference(nfo_info->standby_dev) :
>+			rtnl_dereference(nfo_info->primary_dev)) {
>+		netdev_err(failover_dev, "%s attempting to register as slave dev when %s already present\n",
>+			   slave_dev->name,
>+			   slave_is_standby ? "standby" : "primary");
>+		goto done;
>+	}
>+
>+	/* We want to allow only a direct attached VF device as a primary
>+	 * netdev. As there is no easy way to check for a VF device, restrict
>+	 * this to a pci device.
>+	 */
>+	if (!slave_is_standby && (!slave_dev->dev.parent ||
>+				  !dev_is_pci(slave_dev->dev.parent)))

Yeah, this is good for now.


>+		goto done;
>+
>+	if (failover_dev->features & NETIF_F_VLAN_CHALLENGED &&
>+	    vlan_uses_dev(failover_dev)) {
>+		netdev_err(failover_dev, "Device %s is VLAN challenged and failover device has VLAN set up\n",
>+			   failover_dev->name);
>+		goto done;
>+	}
>+
>+	/* Align MTU of slave with failover dev */
>+	orig_mtu = slave_dev->mtu;
>+	err = dev_set_mtu(slave_dev, failover_dev->mtu);
>+	if (err) {
>+		netdev_err(failover_dev, "unable to change mtu of %s to %u register failed\n",
>+			   slave_dev->name, failover_dev->mtu);
>+		goto done;
>+	}
>+
>+	dev_hold(slave_dev);
>+
>+	if (netif_running(failover_dev)) {
>+		err = dev_open(slave_dev);
>+		if (err && (err != -EBUSY)) {
>+			netdev_err(failover_dev, "Opening slave %s failed err:%d\n",
>+				   slave_dev->name, err);
>+			goto err_dev_open;
>+		}
>+	}
>+
>+	netif_addr_lock_bh(failover_dev);
>+	dev_uc_sync_multiple(slave_dev, failover_dev);
>+	dev_uc_sync_multiple(slave_dev, failover_dev);
>+	netif_addr_unlock_bh(failover_dev);
>+
>+	err = vlan_vids_add_by_dev(slave_dev, failover_dev);
>+	if (err) {
>+		netdev_err(failover_dev, "Failed to add vlan ids to device %s err:%d\n",
>+			   slave_dev->name, err);
>+		goto err_vlan_add;
>+	}
>+
>+	err = netdev_rx_handler_register(slave_dev, net_failover_handle_frame,
>+					 failover_dev);
>+	if (err) {
>+		netdev_err(slave_dev, "can not register failover rx handler (err = %d)\n",
>+			   err);
>+		goto err_handler_register;
>+	}
>+
>+	err = netdev_upper_dev_link(slave_dev, failover_dev, NULL);

Please use netdev_master_upper_dev_link().



>+	if (err) {
>+		netdev_err(slave_dev, "can not set failover device %s (err = %d)\n",
>+			   failover_dev->name, err);
>+		goto err_upper_link;
>+	}
>+
>+	slave_dev->priv_flags |= IFF_FAILOVER_SLAVE;
>+
>+	if (slave_is_standby) {
>+		rcu_assign_pointer(nfo_info->standby_dev, slave_dev);
>+		dev_get_stats(nfo_info->standby_dev, &nfo_info->standby_stats);
>+	} else {
>+		rcu_assign_pointer(nfo_info->primary_dev, slave_dev);
>+		dev_get_stats(nfo_info->primary_dev, &nfo_info->primary_stats);
>+		failover_dev->min_mtu = slave_dev->min_mtu;
>+		failover_dev->max_mtu = slave_dev->max_mtu;
>+	}
>+
>+	net_failover_compute_features(failover_dev);
>+
>+	call_netdevice_notifiers(NETDEV_JOIN, slave_dev);
>+
>+	netdev_info(failover_dev, "failover %s slave:%s registered\n",
>+		    slave_is_standby ? "standby" : "primary", slave_dev->name);

I wonder if noise like this is needed in dmesg...


>+
>+	goto done;
>+
>+err_upper_link:
>+	netdev_rx_handler_unregister(slave_dev);
>+err_handler_register:
>+	vlan_vids_del_by_dev(slave_dev, failover_dev);
>+err_vlan_add:
>+	dev_uc_unsync(slave_dev, failover_dev);
>+	dev_mc_unsync(slave_dev, failover_dev);
>+	dev_close(slave_dev);
>+err_dev_open:
>+	dev_put(slave_dev);
>+	dev_set_mtu(slave_dev, orig_mtu);
>+done:
>+	return NOTIFY_DONE;
>+}
>+
>+int net_failover_slave_unregister(struct net_device *slave_dev)
>+{
>+	struct net_device *standby_dev, *primary_dev;
>+	struct net_failover_info *nfo_info;
>+	struct net_failover_ops *nfo_ops;
>+	struct net_device *failover_dev;
>+	bool slave_is_standby;
>+
>+	if (!netif_is_failover_slave(slave_dev))
>+		goto done;
>+
>+	ASSERT_RTNL();
>+
>+	failover_dev = net_failover_get_bymac(slave_dev->perm_addr, &nfo_ops);
>+	if (!failover_dev)
>+		goto done;
>+
>+	if (nfo_ops && nfo_ops->slave_unregister)
>+		return nfo_ops->slave_unregister(slave_dev, failover_dev);
>+
>+	nfo_info = netdev_priv(failover_dev);
>+	primary_dev = rtnl_dereference(nfo_info->primary_dev);
>+	standby_dev = rtnl_dereference(nfo_info->standby_dev);
>+
>+	if (slave_dev != primary_dev && slave_dev != standby_dev)
>+		goto done;
>+
>+	slave_is_standby = (slave_dev->dev.parent == failover_dev->dev.parent);
>+
>+	netdev_rx_handler_unregister(slave_dev);
>+	netdev_upper_dev_unlink(slave_dev, failover_dev);
>+	vlan_vids_del_by_dev(slave_dev, failover_dev);
>+	dev_uc_unsync(slave_dev, failover_dev);
>+	dev_mc_unsync(slave_dev, failover_dev);
>+	dev_close(slave_dev);
>+	slave_dev->priv_flags &= ~IFF_FAILOVER_SLAVE;
>+
>+	nfo_info = netdev_priv(failover_dev);
>+	net_failover_get_stats(failover_dev, &nfo_info->failover_stats);
>+
>+	if (slave_is_standby) {
>+		RCU_INIT_POINTER(nfo_info->standby_dev, NULL);
>+	} else {
>+		RCU_INIT_POINTER(nfo_info->primary_dev, NULL);
>+		if (standby_dev) {
>+			failover_dev->min_mtu = standby_dev->min_mtu;
>+			failover_dev->max_mtu = standby_dev->max_mtu;
>+		}
>+	}
>+
>+	dev_put(slave_dev);
>+
>+	net_failover_compute_features(failover_dev);
>+
>+	netdev_info(failover_dev, "failover %s slave:%s unregistered\n",
>+		    slave_is_standby ? "standby" : "primary", slave_dev->name);
>+
>+done:
>+	return NOTIFY_DONE;
>+}
>+EXPORT_SYMBOL_GPL(net_failover_slave_unregister);
>+
>+static int net_failover_slave_link_change(struct net_device *slave_dev)
>+{
>+	struct net_device *failover_dev, *primary_dev, *standby_dev;
>+	struct net_failover_info *nfo_info;
>+	struct net_failover_ops *nfo_ops;
>+
>+	if (!netif_is_failover_slave(slave_dev))
>+		goto done;
>+
>+	ASSERT_RTNL();
>+
>+	failover_dev = net_failover_get_bymac(slave_dev->perm_addr, &nfo_ops);
>+	if (!failover_dev)
>+		goto done;
>+
>+	if (nfo_ops && nfo_ops->slave_link_change)
>+		return nfo_ops->slave_link_change(slave_dev, failover_dev);
>+
>+	if (!netif_running(failover_dev))
>+		return 0;
>+
>+	nfo_info = netdev_priv(failover_dev);
>+
>+	primary_dev = rtnl_dereference(nfo_info->primary_dev);
>+	standby_dev = rtnl_dereference(nfo_info->standby_dev);
>+
>+	if (slave_dev != primary_dev && slave_dev != standby_dev)
>+		goto done;
>+
>+	if ((primary_dev && net_failover_xmit_ready(primary_dev)) ||
>+	    (standby_dev && net_failover_xmit_ready(standby_dev))) {
>+		netif_carrier_on(failover_dev);
>+		netif_tx_wake_all_queues(failover_dev);
>+	} else {
>+		net_failover_get_stats(failover_dev, &nfo_info->failover_stats);
>+		netif_carrier_off(failover_dev);
>+		netif_tx_stop_all_queues(failover_dev);
>+	}
>+
>+done:
>+	return NOTIFY_DONE;
>+}
>+
>+static int
>+net_failover_event(struct notifier_block *this, unsigned long event, void *ptr)
>+{
>+	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
>+
>+	/* Skip parent events */
>+	if (netif_is_failover(event_dev))
>+		return NOTIFY_DONE;
>+
>+	switch (event) {
>+	case NETDEV_REGISTER:
>+		return net_failover_slave_register(event_dev);
>+	case NETDEV_UNREGISTER:
>+		return net_failover_slave_unregister(event_dev);
>+	case NETDEV_UP:
>+	case NETDEV_DOWN:
>+	case NETDEV_CHANGE:
>+		return net_failover_slave_link_change(event_dev);
>+	default:
>+		return NOTIFY_DONE;
>+	}
>+}
>+
>+static struct notifier_block net_failover_notifier = {
>+	.notifier_call = net_failover_event,
>+};
>+
>+static void nfo_register_existing_slave(struct net_device *failover_dev)

Please maintain the same function prefixes withing the whole code.

Also, to be consistent with the rest of the code, have "_register" as a
suffix.


>+{
>+	struct net *net = dev_net(failover_dev);
>+	struct net_device *dev;
>+
>+	rtnl_lock();
>+	for_each_netdev(net, dev) {
>+		if (netif_is_failover(dev))
>+			continue;
>+		if (ether_addr_equal(failover_dev->perm_addr, dev->perm_addr))
>+			net_failover_slave_register(dev);
>+	}
>+	rtnl_unlock();
>+}
>+


For every exported function, please provide documentation in format:

/**
 *	net_failover_register - Register net failover device
 *
 *	@dev: netdevice the failover is registerd for
 *	@ops: failover ops
 *
 *	Describe what the function does, what are expected inputs and
 *	outputs, etc. Don't hesistate to be verbose. Mention the 2/3netdev
 *	model here. Then you don't need the comment in the header file
 *	for there functions.
 */

>+int net_failover_register(struct net_device *dev, struct net_failover_ops *ops,
>+			  struct net_failover **pfailover)

Just return "struct net_failover *" instead of arg ** and use ERR_PTR
macro to propagate an error.


>+{
>+	struct net_failover *failover;
>+
>+	failover = kzalloc(sizeof(*failover), GFP_KERNEL);
>+	if (!failover)
>+		return -ENOMEM;
>+
>+	rcu_assign_pointer(failover->ops, ops);
>+	dev_hold(dev);
>+	dev->priv_flags |= IFF_FAILOVER;
>+	rcu_assign_pointer(failover->failover_dev, dev);
>+
>+	spin_lock(&net_failover_lock);
>+	list_add_tail(&failover->list, &net_failover_list);
>+	spin_unlock(&net_failover_lock);
>+
>+	netdev_info(dev, "failover master:%s registered\n", dev->name);
>+
>+	nfo_register_existing_slave(dev);
>+
>+	*pfailover = failover;
>+
>+	return 0;
>+}
>+EXPORT_SYMBOL_GPL(net_failover_register);
>+
>+void net_failover_unregister(struct net_failover *failover)
>+{
>+	struct net_device *failover_dev;
>+
>+	failover_dev = rcu_dereference(failover->failover_dev);
>+
>+	netdev_info(failover_dev, "failover master:%s unregistered\n",
>+		    failover_dev->name);
>+
>+	failover_dev->priv_flags &= ~IFF_FAILOVER;
>+	dev_put(failover_dev);
>+
>+	spin_lock(&net_failover_lock);
>+	list_del(&failover->list);
>+	spin_unlock(&net_failover_lock);
>+
>+	kfree(failover);
>+}
>+EXPORT_SYMBOL_GPL(net_failover_unregister);
>+
>+int net_failover_create(struct net_device *standby_dev,
>+			struct net_failover **pfailover)

Same here, just return "struct net_failover *"


>+{
>+	struct device *dev = standby_dev->dev.parent;
>+	struct net_device *failover_dev;
>+	int err;
>+
>+	/* Alloc at least 2 queues, for now we are going with 16 assuming
>+	 * that VF devices being enslaved won't have too many queues.
>+	 */
>+	failover_dev = alloc_etherdev_mq(sizeof(struct net_failover_info), 16);
>+	if (!failover_dev) {
>+		dev_err(dev, "Unable to allocate failover_netdev!\n");
>+		return -ENOMEM;
>+	}
>+
>+	dev_net_set(failover_dev, dev_net(standby_dev));
>+	SET_NETDEV_DEV(failover_dev, dev);
>+
>+	failover_dev->netdev_ops = &failover_dev_ops;
>+	failover_dev->ethtool_ops = &failover_ethtool_ops;
>+
>+	/* Initialize the device options */
>+	failover_dev->priv_flags |= IFF_UNICAST_FLT | IFF_NO_QUEUE;
>+	failover_dev->priv_flags &= ~(IFF_XMIT_DST_RELEASE |
>+				       IFF_TX_SKB_SHARING);
>+
>+	/* don't acquire failover netdev's netif_tx_lock when transmitting */
>+	failover_dev->features |= NETIF_F_LLTX;
>+
>+	/* Don't allow failover devices to change network namespaces. */
>+	failover_dev->features |= NETIF_F_NETNS_LOCAL;
>+
>+	failover_dev->hw_features = FAILOVER_VLAN_FEATURES |
>+				    NETIF_F_HW_VLAN_CTAG_TX |
>+				    NETIF_F_HW_VLAN_CTAG_RX |
>+				    NETIF_F_HW_VLAN_CTAG_FILTER;
>+
>+	failover_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
>+	failover_dev->features |= failover_dev->hw_features;
>+
>+	memcpy(failover_dev->dev_addr, standby_dev->dev_addr,
>+	       failover_dev->addr_len);
>+
>+	failover_dev->min_mtu = standby_dev->min_mtu;
>+	failover_dev->max_mtu = standby_dev->max_mtu;
>+
>+	err = register_netdev(failover_dev);
>+	if (err < 0) {

if (err)
is enough


>+		dev_err(dev, "Unable to register failover_dev!\n");
>+		goto err_register_netdev;
>+	}
>+
>+	netif_carrier_off(failover_dev);
>+
>+	err = net_failover_register(failover_dev, NULL, pfailover);
>+	if (err < 0)

if (err)
is enough


>+		goto err_failover_register;
>+
>+	return 0;
>+
>+err_failover_register:
>+	unregister_netdev(failover_dev);
>+err_register_netdev:
>+	free_netdev(failover_dev);
>+
>+	return err;
>+}
>+EXPORT_SYMBOL_GPL(net_failover_create);

[...]
