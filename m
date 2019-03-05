From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH net-next] failover: allow name change on IFF_UP slave
	interfaces
Date: Tue, 5 Mar 2019 15:28:20 -0500
Message-ID: <20190305152740-mutt-send-email-mst__29954.0276917227$1551818595$gmane$org@kernel.org>
References: <1551747059-11831-1-git-send-email-si-wei.liu@oracle.com>
	<20190304213032-mutt-send-email-mst@kernel.org>
	<e3b34115-39ca-ac5f-7d53-8bf9e69c910d@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <e3b34115-39ca-ac5f-7d53-8bf9e69c910d@oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: si-wei liu <si-wei.liu@oracle.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kubakici@wp.pl>, Sridhar Samudrala <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, liran.alon@oracle.com, Netdev <netdev@vger.kernel.org>, boris.ostrovsky@oracle.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 05, 2019 at 11:19:32AM -0800, si-wei liu wrote:
> 
> 
> On 3/4/2019 6:33 PM, Michael S. Tsirkin wrote:
> > On Mon, Mar 04, 2019 at 07:50:59PM -0500, Si-Wei Liu wrote:
> > > When a netdev appears through hot plug then gets enslaved by a failover
> > > master that is already up and running, the slave will be opened
> > > right away after getting enslaved. Today there's a race that userspace
> > > (udev) may fail to rename the slave if the kernel (net_failover)
> > > opens the slave earlier than when the userspace rename happens.
> > > Unlike bond or team, the primary slave of failover can't be renamed by
> > > userspace ahead of time, since the kernel initiated auto-enslavement is
> > > unable to, or rather, is never meant to be synchronized with the rename
> > > request from userspace.
> > > 
> > > As the failover slave interfaces are not designed to be operated
> > > directly by userspace apps: IP configuration, filter rules with
> > > regard to network traffic passing and etc., should all be done on master
> > > interface. In general, userspace apps only care about the
> > > name of master interface, while slave names are less important as long
> > > as admin users can see reliable names that may carry
> > > other information describing the netdev. For e.g., they can infer that
> > > "ens3nsby" is a standby slave of "ens3", while for a
> > > name like "eth0" they can't tell which master it belongs to.
> > > 
> > > Historically the name of IFF_UP interface can't be changed because
> > > there might be admin script or management software that is already
> > > relying on such behavior and assumes that the slave name can't be
> > > changed once UP. But failover is special: with the in-kernel
> > > auto-enslavement mechanism, the userspace expectation for device
> > > enumeration and bring-up order is already broken. Previously initramfs
> > > and various userspace config tools were modified to bypass failover
> > > slaves because of auto-enslavement and duplicate MAC address. Similarly,
> > > in case that users care about seeing reliable slave name, the new type
> > > of failover slaves needs to be taken care of specifically in userspace
> > > anyway.
> > > 
> > > For that to work, now introduce a module-level tunable,
> > > "slave_rename_ok" that allows users to lift up the rename restriction on
> > > failover slave which is already UP. Although it's possible this change
> > > potentially break userspace component (most likely configuration scripts
> > > or management software) that assumes slave name can't be changed while
> > > UP, it's relatively a limited and controllable set among all userspace
> > > components, which can be fixed specifically to work with the new naming
> > > behavior of the failover slave. Userspace component interacting with
> > > slaves should be changed to operate on failover master instead, as the
> > > failover slave is dynamic in nature which may come and go at any point.
> > > The goal is to make the role of failover slaves less relevant, and
> > > all userspace should only deal with master in the long run. The default
> > > for the "slave_rename_ok" is set to true(1). If userspace doesn't have
> > > the right support in place meanwhile users don't care about reliable
> > > userspace naming, the value can be set to false(0).
> > > 
> > > Signed-off-by: Si-Wei.Liu@oracle.com
> > > Reviewed-by: Liran Alon <liran.alon@oracle.com>
> > Not sure which of the versions I should reply to.
> Sorry for multiple copies sent. It's fine to reply to this one.
> 
> > 
> > I have a vague idea: would it work to *not* set
> > IFF_UP on slave devices at all?
> Hmm, I ever thought about this option, and it appears this solution is more
> invasive than required to convert existing scripts, despite the controversy
> of introducing internal netdev state to differentiate user visible state.
> Either we disallow slave to be brought up by user, or to not set IFF_UP flag
> but instead use the internal one, could end up with substantial behavioral
> change that breaks scripts. Consider any admin script that does `ip link set
> dev ... up' successfully just assumes the link is up and subsequent
> operation can be done as usual. While it *may* work for dracut (yet to be
> verified), I'm a bit concerned that there are more scripts to be converted
> than those that don't follow volatile failover slave names. It's technically
> doable, but may not worth the effort (in terms of porting existing
> scripts/apps).
> 
> Thanks
> -Siwei


Right. Advantage could be that we prevent all kind of
misconfigurations e.g. when one has a route on a slave.

> > 
> > Would this reduce the chances of existing scripts such as dracut being
> > confused?
> > 
> > And this leaves open the option for scripts to address
> > slaves by checking some custom attribute.
> > 
> > > ---
> > >   include/linux/netdevice.h |  3 +++
> > >   net/core/dev.c            |  3 ++-
> > >   net/core/failover.c       | 11 +++++++++--
> > >   3 files changed, 14 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > > index 857f8ab..6d9e4e0 100644
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -1487,6 +1487,7 @@ struct net_device_ops {
> > >    * @IFF_NO_RX_HANDLER: device doesn't support the rx_handler hook
> > >    * @IFF_FAILOVER: device is a failover master device
> > >    * @IFF_FAILOVER_SLAVE: device is lower dev of a failover master device
> > > + * @IFF_SLAVE_RENAME_OK: rename is allowed while slave device is running
> > >    */
> > >   enum netdev_priv_flags {
> > >   	IFF_802_1Q_VLAN			= 1<<0,
> > > @@ -1518,6 +1519,7 @@ enum netdev_priv_flags {
> > >   	IFF_NO_RX_HANDLER		= 1<<26,
> > >   	IFF_FAILOVER			= 1<<27,
> > >   	IFF_FAILOVER_SLAVE		= 1<<28,
> > > +	IFF_SLAVE_RENAME_OK		= 1<<29,
> > >   };
> > >   #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
> > > @@ -1548,6 +1550,7 @@ enum netdev_priv_flags {
> > >   #define IFF_NO_RX_HANDLER		IFF_NO_RX_HANDLER
> > >   #define IFF_FAILOVER			IFF_FAILOVER
> > >   #define IFF_FAILOVER_SLAVE		IFF_FAILOVER_SLAVE
> > > +#define IFF_SLAVE_RENAME_OK		IFF_SLAVE_RENAME_OK
> > >   /**
> > >    *	struct net_device - The DEVICE structure.
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 722d50d..ae070de 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -1180,7 +1180,8 @@ int dev_change_name(struct net_device *dev, const char *newname)
> > >   	BUG_ON(!dev_net(dev));
> > >   	net = dev_net(dev);
> > > -	if (dev->flags & IFF_UP)
> > > +	if (dev->flags & IFF_UP &&
> > > +	    !(dev->priv_flags & IFF_SLAVE_RENAME_OK))
> > >   		return -EBUSY;
> > >   	write_seqcount_begin(&devnet_rename_seq);
> > > diff --git a/net/core/failover.c b/net/core/failover.c
> > > index 4a92a98..1fd8bbb 100644
> > > --- a/net/core/failover.c
> > > +++ b/net/core/failover.c
> > > @@ -16,6 +16,11 @@
> > >   static LIST_HEAD(failover_list);
> > >   static DEFINE_SPINLOCK(failover_lock);
> > > +static bool slave_rename_ok = true;
> > > +
> > > +module_param(slave_rename_ok, bool, (S_IRUGO | S_IWUSR));
> > > +MODULE_PARM_DESC(slave_rename_ok,
> > > +		 "If set allow renaming the slave when failover master is up");
> > >   static struct net_device *failover_get_bymac(u8 *mac, struct failover_ops **ops)
> > >   {
> > > @@ -81,13 +86,15 @@ static int failover_slave_register(struct net_device *slave_dev)
> > >   	}
> > >   	slave_dev->priv_flags |= IFF_FAILOVER_SLAVE;
> > > +	if (slave_rename_ok)
> > > +		slave_dev->priv_flags |= IFF_SLAVE_RENAME_OK;
> > >   	if (fops && fops->slave_register &&
> > >   	    !fops->slave_register(slave_dev, failover_dev))
> > >   		return NOTIFY_OK;
> > >   	netdev_upper_dev_unlink(slave_dev, failover_dev);
> > > -	slave_dev->priv_flags &= ~IFF_FAILOVER_SLAVE;
> > > +	slave_dev->priv_flags &= ~(IFF_FAILOVER_SLAVE | IFF_SLAVE_RENAME_OK);
> > >   err_upper_link:
> > >   	netdev_rx_handler_unregister(slave_dev);
> > >   done:
> > > @@ -121,7 +128,7 @@ int failover_slave_unregister(struct net_device *slave_dev)
> > >   	netdev_rx_handler_unregister(slave_dev);
> > >   	netdev_upper_dev_unlink(slave_dev, failover_dev);
> > > -	slave_dev->priv_flags &= ~IFF_FAILOVER_SLAVE;
> > > +	slave_dev->priv_flags &= ~(IFF_FAILOVER_SLAVE | IFF_SLAVE_RENAME_OK);
> > >   	if (fops && fops->slave_unregister &&
> > >   	    !fops->slave_unregister(slave_dev, failover_dev))
> > > -- 
> > > 1.8.3.1
