From: Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [RFC PATCH v3 2/3] virtio_net: Extend virtio to use VF datapath
	when available
Date: Fri, 16 Feb 2018 19:04:55 -0800
Message-ID: <20180216190455.2a0ea023__1990.55321650139$1518836646$gmane$org@cakuba.netronome.com>
References: <1518804682-16881-1-git-send-email-sridhar.samudrala@intel.com>
	<1518804682-16881-3-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1518804682-16881-3-git-send-email-sridhar.samudrala@intel.com>
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
Cc: alexander.h.duyck@intel.com, Or Gerlitz <gerlitz.or@gmail.com>, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 16 Feb 2018 10:11:21 -0800, Sridhar Samudrala wrote:
> This patch enables virtio_net to switch over to a VF datapath when a VF
> netdev is present with the same MAC address. It allows live migration
> of a VM with a direct attached VF without the need to setup a bond/team
> between a VF and virtio net device in the guest.
> 
> The hypervisor needs to enable only one datapath at any time so that
> packets don't get looped back to the VM over the other datapath. When a VF
> is plugged, the virtio datapath link state can be marked as down. The
> hypervisor needs to unplug the VF device from the guest on the source host
> and reset the MAC filter of the VF to initiate failover of datapath to
> virtio before starting the migration. After the migration is completed,
> the destination hypervisor sets the MAC filter on the VF and plugs it back
> to the guest to switch over to VF datapath.
> 
> When BACKUP feature is enabled, an additional netdev(bypass netdev) is
> created that acts as a master device and tracks the state of the 2 lower
> netdevs. The original virtio_net netdev is marked as 'backup' netdev and a
> passthru device with the same MAC is registered as 'active' netdev.
> 
> This patch is based on the discussion initiated by Jesse on this thread.
> https://marc.info/?l=linux-virtualization&m=151189725224231&w=2
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com> 

> +static void
> +virtnet_bypass_get_stats(struct net_device *dev,
> +			 struct rtnl_link_stats64 *stats)
> +{
> +	struct virtnet_bypass_info *vbi = netdev_priv(dev);
> +	const struct rtnl_link_stats64 *new;
> +	struct rtnl_link_stats64 temp;
> +	struct net_device *child_netdev;
> +
> +	spin_lock(&vbi->stats_lock);
> +	memcpy(stats, &vbi->bypass_stats, sizeof(*stats));
> +
> +	rcu_read_lock();
> +
> +	child_netdev = rcu_dereference(vbi->active_netdev);
> +	if (child_netdev) {
> +		new = dev_get_stats(child_netdev, &temp);
> +		virtnet_bypass_fold_stats(stats, new, &vbi->active_stats);
> +		memcpy(&vbi->active_stats, new, sizeof(*new));
> +	}
> +
> +	child_netdev = rcu_dereference(vbi->backup_netdev);
> +	if (child_netdev) {
> +		new = dev_get_stats(child_netdev, &temp);
> +		virtnet_bypass_fold_stats(stats, new, &vbi->backup_stats);
> +		memcpy(&vbi->backup_stats, new, sizeof(*new));
> +	}
> +
> +	rcu_read_unlock();
> +
> +	memcpy(&vbi->bypass_stats, stats, sizeof(*stats));
> +	spin_unlock(&vbi->stats_lock);
> +}
> +
> +static int virtnet_bypass_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	struct virtnet_bypass_info *vbi = netdev_priv(dev);
> +	struct net_device *child_netdev;
> +	int ret = 0;
> +
> +	child_netdev = rcu_dereference(vbi->active_netdev);
> +	if (child_netdev) {
> +		ret = dev_set_mtu(child_netdev, new_mtu);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	child_netdev = rcu_dereference(vbi->backup_netdev);
> +	if (child_netdev) {
> +		ret = dev_set_mtu(child_netdev, new_mtu);
> +		if (ret)
> +			netdev_err(child_netdev,
> +				   "Unexpected failure to set mtu to %d\n",
> +				   new_mtu);

You should probably unwind if set fails on one of the legs.

> +	}
> +
> +	dev->mtu = new_mtu;
> +	return 0;
> +}

nit: stats, mtu, all those mundane things are implemented in team
     already.  If we had this as kernel-internal team mode we wouldn't
     have to reimplement them...  You probably did investigate that
     option, for my edification, would you mind saying what the
     challenges/downsides were?

> +static struct net_device *
> +get_virtnet_bypass_bymac(struct net *net, const u8 *mac)
> +{
> +	struct net_device *dev;
> +
> +	ASSERT_RTNL();
> +
> +	for_each_netdev(net, dev) {
> +		if (dev->netdev_ops != &virtnet_bypass_netdev_ops)
> +			continue;       /* not a virtnet_bypass device */

Is there anything inherently wrong with enslaving another virtio dev
now?  I was expecting something like a hash map to map MAC addr ->
master and then one can check if dev is already enslaved to that master.
Just a random thought, I'm probably missing something...

> +		if (ether_addr_equal(mac, dev->perm_addr))
> +			return dev;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct net_device *
> +get_virtnet_bypass_byref(struct net_device *child_netdev)
> +{
> +	struct net *net = dev_net(child_netdev);
> +	struct net_device *dev;
> +
> +	ASSERT_RTNL();
> +
> +	for_each_netdev(net, dev) {
> +		struct virtnet_bypass_info *vbi;
> +
> +		if (dev->netdev_ops != &virtnet_bypass_netdev_ops)
> +			continue;       /* not a virtnet_bypass device */
> +
> +		vbi = netdev_priv(dev);
> +
> +		if ((rtnl_dereference(vbi->active_netdev) == child_netdev) ||
> +		    (rtnl_dereference(vbi->backup_netdev) == child_netdev))

nit: parens not needed

> +			return dev;	/* a match */
> +	}
> +
> +	return NULL;
> +}

> +static int virtnet_bypass_create(struct virtnet_info *vi)
> +{
> +	struct net_device *backup_netdev = vi->dev;
> +	struct device *dev = &vi->vdev->dev;
> +	struct net_device *bypass_netdev;
> +	int res;
> +
> +	/* Alloc at least 2 queues, for now we are going with 16 assuming
> +	 * that most devices being bonded won't have too many queues.
> +	 */
> +	bypass_netdev = alloc_etherdev_mq(sizeof(struct virtnet_bypass_info),
> +					  16);
> +	if (!bypass_netdev) {
> +		dev_err(dev, "Unable to allocate bypass_netdev!\n");
> +		return -ENOMEM;
> +	}

Maybe it's just me but referring to master as bypass seems slightly
confusing.  I know you don't like team and bond, but perhaps we can
come up with a better name?  For me bypass device is the other leg,
i.e. the VF, not the master.  Perhaps others disagree.

> +	dev_net_set(bypass_netdev, dev_net(backup_netdev));
> +	SET_NETDEV_DEV(bypass_netdev, dev);
> +
> +	bypass_netdev->netdev_ops = &virtnet_bypass_netdev_ops;
> +	bypass_netdev->ethtool_ops = &virtnet_bypass_ethtool_ops;

Thanks!
