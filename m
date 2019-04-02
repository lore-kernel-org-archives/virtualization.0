From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: [PATCH net v5] failover: allow name change on IFF_UP slave
	interfaces
Date: Tue, 2 Apr 2019 13:03:10 -0700
Message-ID: <c4e91e72-b2ba-7431-1b48-dc2c40123103__28043.2822460838$1554235403$gmane$org@intel.com>
References: <1554159893-29704-1-git-send-email-si-wei.liu@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1554159893-29704-1-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, kubakici@wp.pl, alexander.duyck@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: boris.ostrovsky@oracle.com, liran.alon@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On 4/1/2019 4:04 PM, Si-Wei Liu wrote:
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
> and/or link down/up events on failover slaves. Userspace component
> interacting with slaves is expected to be changed to operate on failover
> master interface instead, as the failover slave is dynamic in nature
> which may come and go at any point.  The goal is to make the role of
> failover slaves less relevant, and userspace components should only
> deal with failover master in the long run.
> 
> Fixes: 30c8bd5aa8b2 ("net: Introduce generic failover module")
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Reviewed-by: Liran Alon <liran.alon@oracle.com>

Acked-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

> 
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
> ---
>   net/core/dev.c | 25 ++++++++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 9823b77..b694184 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1185,7 +1185,21 @@ int dev_change_name(struct net_device *dev, const char *newname)
>   	BUG_ON(!dev_net(dev));
>   
>   	net = dev_net(dev);
> -	if (dev->flags & IFF_UP)
> +
> +	/* Allow failover slave to rename even when
> +	 * it is up and running.
> +	 *
> +	 * Failover slaves are special, since userspace
> +	 * might rename the slave after the interface
> +	 * has been brought up and running due to
> +	 * auto-enslavement.
> +	 *
> +	 * Failover users don't actually care about slave
> +	 * name change, as they are only expected to operate
> +	 * on master interface directly.
> +	 */
> +	if (dev->flags & IFF_UP &&
> +	    likely(!(dev->priv_flags & IFF_FAILOVER_SLAVE)))
>   		return -EBUSY;
>   
>   	write_seqcount_begin(&devnet_rename_seq);
> @@ -1232,6 +1246,15 @@ int dev_change_name(struct net_device *dev, const char *newname)
>   	hlist_add_head_rcu(&dev->name_hlist, dev_name_hash(net, dev->name));
>   	write_unlock_bh(&dev_base_lock);
>   
> +	if (unlikely(dev->flags & IFF_UP)) {
> +		struct netdev_notifier_change_info change_info = {
> +			.info.dev = dev,
> +		};
> +
> +		call_netdevice_notifiers_info(NETDEV_CHANGE,
> +					      &change_info.info);
> +	}
> +
>   	ret = call_netdevice_notifiers(NETDEV_CHANGENAME, dev);
>   	ret = notifier_to_errno(ret);
>   
> 
