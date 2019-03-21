From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH net v2] failover: allow name change on IFF_UP slave
	interfaces
Date: Thu, 21 Mar 2019 10:04:35 -0400
Message-ID: <20190321100110-mutt-send-email-mst__662.892979902097$1553177094$gmane$org@kernel.org>
References: <1551928112-32109-1-git-send-email-si-wei.liu@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1551928112-32109-1-git-send-email-si-wei.liu@oracle.com>
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
Cc: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, Netdev <netdev@vger.kernel.org>, boris.ostrovsky@oracle.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Mar 06, 2019 at 10:08:32PM -0500, Si-Wei Liu wrote:
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
> components, which can be fixed specifically to work with the new naming
> behavior of failover slaves. Userspace component interacting with
> slaves should be changed to operate on failover master instead, as the
> failover slave is dynamic in nature which may come and go at any point.
> The goal is to make the role of failover slaves less relevant, and
> all userspace should only deal with master in the long run.
> 
> Fixes: 30c8bd5aa8b2 ("net: Introduce generic failover module")
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Reviewed-by: Liran Alon <liran.alon@oracle.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

I worry that userspace might have made a bunch of assumptions
that names never change as long as interface is up.
So listening for up events ensures that interface
is not renamed.

How about sending down and up events around such renames?



> ---
> v1 -> v2:
> - Drop configurable module parameter (Sridhar)
> 
> 
>  include/linux/netdevice.h | 3 +++
>  net/core/dev.c            | 3 ++-
>  net/core/failover.c       | 6 +++---
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 857f8ab..6d9e4e0 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1487,6 +1487,7 @@ struct net_device_ops {
>   * @IFF_NO_RX_HANDLER: device doesn't support the rx_handler hook
>   * @IFF_FAILOVER: device is a failover master device
>   * @IFF_FAILOVER_SLAVE: device is lower dev of a failover master device
> + * @IFF_SLAVE_RENAME_OK: rename is allowed while slave device is running
>   */
>  enum netdev_priv_flags {
>  	IFF_802_1Q_VLAN			= 1<<0,
> @@ -1518,6 +1519,7 @@ enum netdev_priv_flags {
>  	IFF_NO_RX_HANDLER		= 1<<26,
>  	IFF_FAILOVER			= 1<<27,
>  	IFF_FAILOVER_SLAVE		= 1<<28,
> +	IFF_SLAVE_RENAME_OK		= 1<<29,
>  };
>  
>  #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
> @@ -1548,6 +1550,7 @@ enum netdev_priv_flags {
>  #define IFF_NO_RX_HANDLER		IFF_NO_RX_HANDLER
>  #define IFF_FAILOVER			IFF_FAILOVER
>  #define IFF_FAILOVER_SLAVE		IFF_FAILOVER_SLAVE
> +#define IFF_SLAVE_RENAME_OK		IFF_SLAVE_RENAME_OK
>  
>  /**
>   *	struct net_device - The DEVICE structure.
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 722d50d..ae070de 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1180,7 +1180,8 @@ int dev_change_name(struct net_device *dev, const char *newname)
>  	BUG_ON(!dev_net(dev));
>  
>  	net = dev_net(dev);
> -	if (dev->flags & IFF_UP)
> +	if (dev->flags & IFF_UP &&
> +	    !(dev->priv_flags & IFF_SLAVE_RENAME_OK))
>  		return -EBUSY;
>  
>  	write_seqcount_begin(&devnet_rename_seq);
> diff --git a/net/core/failover.c b/net/core/failover.c
> index 4a92a98..34c5c87 100644
> --- a/net/core/failover.c
> +++ b/net/core/failover.c
> @@ -80,14 +80,14 @@ static int failover_slave_register(struct net_device *slave_dev)
>  		goto err_upper_link;
>  	}
>  
> -	slave_dev->priv_flags |= IFF_FAILOVER_SLAVE;
> +	slave_dev->priv_flags |= (IFF_FAILOVER_SLAVE | IFF_SLAVE_RENAME_OK);
>  
>  	if (fops && fops->slave_register &&
>  	    !fops->slave_register(slave_dev, failover_dev))
>  		return NOTIFY_OK;
>  
>  	netdev_upper_dev_unlink(slave_dev, failover_dev);
> -	slave_dev->priv_flags &= ~IFF_FAILOVER_SLAVE;
> +	slave_dev->priv_flags &= ~(IFF_FAILOVER_SLAVE | IFF_SLAVE_RENAME_OK);
>  err_upper_link:
>  	netdev_rx_handler_unregister(slave_dev);
>  done:
> @@ -121,7 +121,7 @@ int failover_slave_unregister(struct net_device *slave_dev)
>  
>  	netdev_rx_handler_unregister(slave_dev);
>  	netdev_upper_dev_unlink(slave_dev, failover_dev);
> -	slave_dev->priv_flags &= ~IFF_FAILOVER_SLAVE;
> +	slave_dev->priv_flags &= ~(IFF_FAILOVER_SLAVE | IFF_SLAVE_RENAME_OK);
>  
>  	if (fops && fops->slave_unregister &&
>  	    !fops->slave_unregister(slave_dev, failover_dev))
> -- 
> 1.8.3.1
