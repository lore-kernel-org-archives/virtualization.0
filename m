From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net v8] failover: allow name change on IFF_UP slave
	interfaces
Date: Tue, 9 Apr 2019 12:13:05 -0400
Message-ID: <20190409121252-mutt-send-email-mst__46265.7012439863$1554826401$gmane$org@kernel.org>
References: <1554767127-32576-1-git-send-email-si-wei.liu@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1554767127-32576-1-git-send-email-si-wei.liu@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jiri@resnulli.us, kubakici@wp.pl, sridhar.samudrala@intel.com, alexander.duyck@gmail.com, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, netdev@vger.kernel.org, boris.ostrovsky@oracle.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Apr 08, 2019 at 07:45:27PM -0400, Si-Wei Liu wrote:
> When a netdev appears through hot plug then gets enslaved by a failover
> master that is already up and running, the slave will be opened
> right away after getting enslaved. Today there's a race that userspace
> (udev) may fail to rename the slave if the kernel (net_failover)
> opens the slave earlier than when the userspace rename happens.
> Unlike bond or team, the primary slave of failover can't be renamed by
> userspace ahead of time, since the kernel initiated auto-enslavement is
> unable to, or rather, is never meant to be synchronized with the rename
> request from userspace.
> 
> As the failover slave interfaces are not designed to be operated
> directly by userspace apps: IP configuration, filter rules with
> regard to network traffic passing and etc., should all be done on master
> interface. In general, userspace apps only care about the
> name of master interface, while slave names are less important as long
> as admin users can see reliable names that may carry
> other information describing the netdev. For e.g., they can infer that
> "ens3nsby" is a standby slave of "ens3", while for a
> name like "eth0" they can't tell which master it belongs to.
> 
> Historically the name of IFF_UP interface can't be changed because
> there might be admin script or management software that is already
> relying on such behavior and assumes that the slave name can't be
> changed once UP. But failover is special: with the in-kernel
> auto-enslavement mechanism, the userspace expectation for device
> enumeration and bring-up order is already broken. Previously initramfs
> and various userspace config tools were modified to bypass failover
> slaves because of auto-enslavement and duplicate MAC address. Similarly,
> in case that users care about seeing reliable slave name, the new type
> of failover slaves needs to be taken care of specifically in userspace
> anyway.
> 
> It's less risky to lift up the rename restriction on failover slave
> which is already UP. Although it's possible this change may potentially
> break userspace component (most likely configuration scripts or
> management software) that assumes slave name can't be changed while
> UP, it's relatively a limited and controllable set among all userspace
> components, which can be fixed specifically to listen for the rename
> events on failover slaves. Userspace component interacting with slaves
> is expected to be changed to operate on failover master interface
> instead, as the failover slave is dynamic in nature which may come and
> go at any point.  The goal is to make the role of failover slaves less
> relevant, and userspace components should only deal with failover master
> in the long run.
> 
> Fixes: 30c8bd5aa8b2 ("net: Introduce generic failover module")
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Reviewed-by: Liran Alon <liran.alon@oracle.com>


OK let's start with that. We can always add more events.

> --
> v1 -> v2:
> - Drop configurable module parameter (Sridhar)
> 
> v2 -> v3:
> - Drop additional IFF_SLAVE_RENAME_OK flag (Sridhar)
> - Send down and up events around rename (Michael S. Tsirkin)
> 
> v3 -> v4:
> - Simplify notification to be sent (Stephen Hemminger)
> 
> v4 -> v5:
> - Sync up code with latest net-next (Sridhar)
> - Use proper structure initialization (Stephen, Jiri)
> 
> v5 -> v6:
> - Make the property of live name change a generic flag (Stephen)
> 
> v6 -> v7:
> - Remove NETDEV_CHANGE notification that is deemed unnecessary
>   (Stephen)
> 
> v7 -> v8:
> - Fix commit message that references link up/down events still
>   (Michael)
> ---
>  include/linux/netdevice.h |  3 +++
>  net/core/dev.c            | 16 +++++++++++++++-
>  net/core/failover.c       |  6 +++---
>  3 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 78f5ec4e..ea9a63f 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1498,6 +1498,7 @@ struct net_device_ops {
>   * @IFF_FAILOVER: device is a failover master device
>   * @IFF_FAILOVER_SLAVE: device is lower dev of a failover master device
>   * @IFF_L3MDEV_RX_HANDLER: only invoke the rx handler of L3 master device
> + * @IFF_LIVE_RENAME_OK: rename is allowed while device is up and running
>   */
>  enum netdev_priv_flags {
>  	IFF_802_1Q_VLAN			= 1<<0,
> @@ -1530,6 +1531,7 @@ enum netdev_priv_flags {
>  	IFF_FAILOVER			= 1<<27,
>  	IFF_FAILOVER_SLAVE		= 1<<28,
>  	IFF_L3MDEV_RX_HANDLER		= 1<<29,
> +	IFF_LIVE_RENAME_OK		= 1<<30,
>  };
>  
>  #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
> @@ -1561,6 +1563,7 @@ enum netdev_priv_flags {
>  #define IFF_FAILOVER			IFF_FAILOVER
>  #define IFF_FAILOVER_SLAVE		IFF_FAILOVER_SLAVE
>  #define IFF_L3MDEV_RX_HANDLER		IFF_L3MDEV_RX_HANDLER
> +#define IFF_LIVE_RENAME_OK		IFF_LIVE_RENAME_OK
>  
>  /**
>   *	struct net_device - The DEVICE structure.
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 9823b77..1622d88 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1185,7 +1185,21 @@ int dev_change_name(struct net_device *dev, const char *newname)
>  	BUG_ON(!dev_net(dev));
>  
>  	net = dev_net(dev);
> -	if (dev->flags & IFF_UP)
> +
> +	/* Some auto-enslaved devices e.g. failover slaves are
> +	 * special, as userspace might rename the device after
> +	 * the interface had been brought up and running since
> +	 * the point kernel initiated auto-enslavement. Allow
> +	 * live name change even when these slave devices are
> +	 * up and running.
> +	 *
> +	 * Typically, users of these auto-enslaving devices
> +	 * don't actually care about slave name change, as
> +	 * they are supposed to operate on master interface
> +	 * directly.
> +	 */
> +	if (dev->flags & IFF_UP &&
> +	    likely(!(dev->priv_flags & IFF_LIVE_RENAME_OK)))
>  		return -EBUSY;
>  
>  	write_seqcount_begin(&devnet_rename_seq);
> diff --git a/net/core/failover.c b/net/core/failover.c
> index 4a92a98..b5cd3c7 100644
> --- a/net/core/failover.c
> +++ b/net/core/failover.c
> @@ -80,14 +80,14 @@ static int failover_slave_register(struct net_device *slave_dev)
>  		goto err_upper_link;
>  	}
>  
> -	slave_dev->priv_flags |= IFF_FAILOVER_SLAVE;
> +	slave_dev->priv_flags |= (IFF_FAILOVER_SLAVE | IFF_LIVE_RENAME_OK);
>  
>  	if (fops && fops->slave_register &&
>  	    !fops->slave_register(slave_dev, failover_dev))
>  		return NOTIFY_OK;
>  
>  	netdev_upper_dev_unlink(slave_dev, failover_dev);
> -	slave_dev->priv_flags &= ~IFF_FAILOVER_SLAVE;
> +	slave_dev->priv_flags &= ~(IFF_FAILOVER_SLAVE | IFF_LIVE_RENAME_OK);
>  err_upper_link:
>  	netdev_rx_handler_unregister(slave_dev);
>  done:
> @@ -121,7 +121,7 @@ int failover_slave_unregister(struct net_device *slave_dev)
>  
>  	netdev_rx_handler_unregister(slave_dev);
>  	netdev_upper_dev_unlink(slave_dev, failover_dev);
> -	slave_dev->priv_flags &= ~IFF_FAILOVER_SLAVE;
> +	slave_dev->priv_flags &= ~(IFF_FAILOVER_SLAVE | IFF_LIVE_RENAME_OK);
>  
>  	if (fops && fops->slave_unregister &&
>  	    !fops->slave_unregister(slave_dev, failover_dev))
> -- 
> 1.8.3.1
