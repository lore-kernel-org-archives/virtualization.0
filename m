From: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [RFC PATCH net-next v6 2/4] net: Introduce generic bypass module
Date: Wed, 18 Apr 2018 11:25:15 +0200
Message-ID: <20180418092515.GB1989__8347.57752386413$1524043423$gmane$org@nanopsycho>
References: <1523386790-12396-1-git-send-email-sridhar.samudrala@intel.com>
	<1523386790-12396-3-git-send-email-sridhar.samudrala@intel.com>
	<20180411155127.GQ2028@nanopsycho>
	<6a8c1ff5-153a-e40a-91b3-48532b8d3a38@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <6a8c1ff5-153a-e40a-91b3-48532b8d3a38@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, mst@redhat.com, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Wed, Apr 11, 2018 at 09:13:52PM CEST, sridhar.samudrala@intel.com wrote:
>On 4/11/2018 8:51 AM, Jiri Pirko wrote:
>> Tue, Apr 10, 2018 at 08:59:48PM CEST, sridhar.samudrala@intel.com wrote:
>> > This provides a generic interface for paravirtual drivers to listen
>> > for netdev register/unregister/link change events from pci ethernet
>> > devices with the same MAC and takeover their datapath. The notifier and
>> > event handling code is based on the existing netvsc implementation.
>> > =

>> > It exposes 2 sets of interfaces to the paravirtual drivers.
>> > 1. existing netvsc driver that uses 2 netdev model. In this model, no
>> > master netdev is created. The paravirtual driver registers each bypass
>> > instance along with a set of ops to manage the slave events.
>> >      bypass_master_register()
>> >      bypass_master_unregister()
>> > 2. new virtio_net based solution that uses 3 netdev model. In this mod=
el,
>> > the bypass module provides interfaces to create/destroy additional mas=
ter
>> > netdev and all the slave events are managed internally.
>> >       bypass_master_create()
>> >       bypass_master_destroy()
>> > =

>> > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> > ---
>> > include/linux/netdevice.h |  14 +
>> > include/net/bypass.h      |  96 ++++++
>> > net/Kconfig               |  18 +
>> > net/core/Makefile         |   1 +
>> > net/core/bypass.c         | 844 ++++++++++++++++++++++++++++++++++++++=
++++++++
>> > 5 files changed, 973 insertions(+)
>> > create mode 100644 include/net/bypass.h
>> > create mode 100644 net/core/bypass.c
>> > =

>> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> > index cf44503ea81a..587293728f70 100644
>> > --- a/include/linux/netdevice.h
>> > +++ b/include/linux/netdevice.h
>> > @@ -1430,6 +1430,8 @@ enum netdev_priv_flags {
>> > 	IFF_PHONY_HEADROOM		=3D 1<<24,
>> > 	IFF_MACSEC			=3D 1<<25,
>> > 	IFF_NO_RX_HANDLER		=3D 1<<26,
>> > +	IFF_BYPASS			=3D 1 << 27,
>> > +	IFF_BYPASS_SLAVE		=3D 1 << 28,
>> I wonder, why you don't follow the existing coding style... Also, please
>> add these to into the comment above.
>
>To avoid checkpatch warnings. If it is OK to ignore these warnings, I can =
switch back
>to the existing coding style to be consistent.

Please do.


>
>> =

>> =

>> > };
>> > =

>> > #define IFF_802_1Q_VLAN			IFF_802_1Q_VLAN
>> > @@ -1458,6 +1460,8 @@ enum netdev_priv_flags {
>> > #define IFF_RXFH_CONFIGURED		IFF_RXFH_CONFIGURED
>> > #define IFF_MACSEC			IFF_MACSEC
>> > #define IFF_NO_RX_HANDLER		IFF_NO_RX_HANDLER
>> > +#define IFF_BYPASS			IFF_BYPASS
>> > +#define IFF_BYPASS_SLAVE		IFF_BYPASS_SLAVE
>> > =

>> > /**
>> >   *	struct net_device - The DEVICE structure.
>> > @@ -4308,6 +4312,16 @@ static inline bool netif_is_rxfh_configured(con=
st struct net_device *dev)
>> > 	return dev->priv_flags & IFF_RXFH_CONFIGURED;
>> > }
>> > =

>> > +static inline bool netif_is_bypass_master(const struct net_device *de=
v)
>> > +{
>> > +	return dev->priv_flags & IFF_BYPASS;
>> > +}
>> > +
>> > +static inline bool netif_is_bypass_slave(const struct net_device *dev)
>> > +{
>> > +	return dev->priv_flags & IFF_BYPASS_SLAVE;
>> > +}
>> > +
>> > /* This device needs to keep skb dst for qdisc enqueue or ndo_start_xm=
it() */
>> > static inline void netif_keep_dst(struct net_device *dev)
>> > {
>> > diff --git a/include/net/bypass.h b/include/net/bypass.h
>> > new file mode 100644
>> > index 000000000000..86b02cb894cf
>> > --- /dev/null
>> > +++ b/include/net/bypass.h
>> > @@ -0,0 +1,96 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +/* Copyright (c) 2018, Intel Corporation. */
>> > +
>> > +#ifndef _NET_BYPASS_H
>> > +#define _NET_BYPASS_H
>> > +
>> > +#include <linux/netdevice.h>
>> > +
>> > +struct bypass_ops {
>> > +	int (*slave_pre_register)(struct net_device *slave_netdev,
>> > +				  struct net_device *bypass_netdev);
>> > +	int (*slave_join)(struct net_device *slave_netdev,
>> > +			  struct net_device *bypass_netdev);
>> > +	int (*slave_pre_unregister)(struct net_device *slave_netdev,
>> > +				    struct net_device *bypass_netdev);
>> > +	int (*slave_release)(struct net_device *slave_netdev,
>> > +			     struct net_device *bypass_netdev);
>> > +	int (*slave_link_change)(struct net_device *slave_netdev,
>> > +				 struct net_device *bypass_netdev);
>> > +	rx_handler_result_t (*handle_frame)(struct sk_buff **pskb);
>> > +};
>> > +
>> > +struct bypass_master {
>> > +	struct list_head list;
>> > +	struct net_device __rcu *bypass_netdev;
>> > +	struct bypass_ops __rcu *ops;
>> > +};
>> > +
>> > +/* bypass state */
>> > +struct bypass_info {
>> > +	/* passthru netdev with same MAC */
>> > +	struct net_device __rcu *active_netdev;
>> You still use "active"/"backup" names which is highly misleading as
>> it has completely different meaning that in bond for example.
>> I noted that in my previous review already. Please change it.
>
>I guess the issue is with only the 'active'=A0 name. 'backup' should be fi=
ne as it also
>matches with the BACKUP feature bit we are adding to virtio_net.

I think that "backup" is also misleading. Both "active" and "backup"
mean a *state* of slaves. This should be named differently.



>
>With regards to alternate names for 'active', you suggested 'stolen', but i
>am not too happy with it.
>netvsc uses vf_netdev, are you OK with this? Or another option is 'passthr=
u'

No. The netdev could be any netdevice. It does not have to be a "VF".
I think "stolen" is quite appropriate since it describes the modus
operandi. The bypass master steals some netdevice according to some
match.

But I don't insist on "stolen". Just sounds right.



>
>
>
>> =

>> =

>> > +
>> > +	/* virtio_net netdev */
>> > +	struct net_device __rcu *backup_netdev;
>> > +
>> > +	/* active netdev stats */
>> > +	struct rtnl_link_stats64 active_stats;
>> > +
>> > +	/* backup netdev stats */
>> > +	struct rtnl_link_stats64 backup_stats;
>> > +
>> > +	/* aggregated stats */
>> > +	struct rtnl_link_stats64 bypass_stats;
>> > +
>> > +	/* spinlock while updating stats */
>> > +	spinlock_t stats_lock;
>> > +};
>> > +
>> > +#if IS_ENABLED(CONFIG_NET_BYPASS)
>> > +
>> > +int bypass_master_create(struct net_device *backup_netdev,
>> > +			 struct bypass_master **pbypass_master);
>> > +void bypass_master_destroy(struct bypass_master *bypass_master);
>> > +
>> > +int bypass_master_register(struct net_device *dev, struct bypass_ops =
*ops,
>> > +			   struct bypass_master **pbypass_master);
>> > +void bypass_master_unregister(struct bypass_master *bypass_master);
>> > +
>> > +int bypass_slave_unregister(struct net_device *slave_netdev);
>> > +
>> > +#else
>> > +
>> > +static inline
>> > +int bypass_master_create(struct net_device *backup_netdev,
>> > +			 struct bypass_master **pbypass_master);
>> > +{
>> > +	return 0;
>> > +}
>> > +
>> > +static inline
>> > +void bypass_master_destroy(struct bypass_master *bypass_master)
>> > +{
>> > +}
>> > +
>> > +static inline
>> > +int bypass_master_register(struct net_device *dev, struct bypass_ops =
*ops,
>> > +			   struct pbypass_master **pbypass_master);
>> > +{
>> > +	return 0;
>> > +}
>> > +
>> > +static inline
>> > +void bypass_master_unregister(struct bypass_master *bypass_master)
>> > +{
>> > +}
>> > +
>> > +static inline
>> > +int bypass_slave_unregister(struct net_device *slave_netdev)
>> > +{
>> > +	return 0;
>> > +}
>> > +
>> > +#endif
>> > +
>> > +#endif /* _NET_BYPASS_H */
>> > diff --git a/net/Kconfig b/net/Kconfig
>> > index 0428f12c25c2..994445f4a96a 100644
>> > --- a/net/Kconfig
>> > +++ b/net/Kconfig
>> > @@ -423,6 +423,24 @@ config MAY_USE_DEVLINK
>> > 	  on MAY_USE_DEVLINK to ensure they do not cause link errors when
>> > 	  devlink is a loadable module and the driver using it is built-in.
>> > =

>> > +config NET_BYPASS
>> > +	tristate "Bypass interface"
>> > +	---help---
>> > +	  This provides a generic interface for paravirtual drivers to listen
>> > +	  for netdev register/unregister/link change events from pci ethernet
>> > +	  devices with the same MAC and takeover their datapath. This also
>> > +	  enables live migration of a VM with direct attached VF by failing
>> > +	  over to the paravirtual datapath when the VF is unplugged.
>> > +
>> > +config MAY_USE_BYPASS
>> > +	tristate
>> > +	default m if NET_BYPASS=3Dm
>> > +	default y if NET_BYPASS=3Dy || NET_BYPASS=3Dn
>> > +	help
>> > +	  Drivers using the bypass infrastructure should have a dependency
>> > +	  on MAY_USE_BYPASS to ensure they do not cause link errors when
>> > +	  bypass is a loadable module and the driver using it is built-in.
>> > +
>> > endif   # if NET
>> > =

>> > # Used by archs to tell that they support BPF JIT compiler plus which =
flavour.
>> > diff --git a/net/core/Makefile b/net/core/Makefile
>> > index 6dbbba8c57ae..a9727ed1c8fc 100644
>> > --- a/net/core/Makefile
>> > +++ b/net/core/Makefile
>> > @@ -30,3 +30,4 @@ obj-$(CONFIG_DST_CACHE) +=3D dst_cache.o
>> > obj-$(CONFIG_HWBM) +=3D hwbm.o
>> > obj-$(CONFIG_NET_DEVLINK) +=3D devlink.o
>> > obj-$(CONFIG_GRO_CELLS) +=3D gro_cells.o
>> > +obj-$(CONFIG_NET_BYPASS) +=3D bypass.o
>> > diff --git a/net/core/bypass.c b/net/core/bypass.c
>> > new file mode 100644
>> > index 000000000000..b5b9cb554c3f
>> > --- /dev/null
>> > +++ b/net/core/bypass.c
>> > @@ -0,0 +1,844 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +/* Copyright (c) 2018, Intel Corporation. */
>> > +
>> > +/* A common module to handle registrations and notifications for para=
virtual
>> > + * drivers to enable accelerated datapath and support VF live migrati=
on.
>> > + *
>> > + * The notifier and event handling code is based on netvsc driver.
>> > + */
>> > +
>> > +#include <linux/netdevice.h>
>> > +#include <linux/etherdevice.h>
>> > +#include <linux/ethtool.h>
>> > +#include <linux/module.h>
>> > +#include <linux/slab.h>
>> > +#include <linux/netdevice.h>
>> > +#include <linux/netpoll.h>
>> > +#include <linux/rtnetlink.h>
>> > +#include <linux/if_vlan.h>
>> > +#include <linux/pci.h>
>> > +#include <net/sch_generic.h>
>> > +#include <uapi/linux/if_arp.h>
>> > +#include <net/bypass.h>
>> > +
>> > +static LIST_HEAD(bypass_master_list);
>> > +static DEFINE_SPINLOCK(bypass_lock);
>> > +
>> > +static int bypass_slave_pre_register(struct net_device *slave_netdev,
>> > +				     struct net_device *bypass_netdev,
>> > +				     struct bypass_ops *bypass_ops)
>> > +{
>> > +	struct bypass_info *bi;
>> > +	bool backup;
>> > +
>> > +	if (bypass_ops) {
>> > +		if (!bypass_ops->slave_pre_register)
>> > +			return -EINVAL;
>> > +
>> > +		return bypass_ops->slave_pre_register(slave_netdev,
>> > +						      bypass_netdev);
>> > +	}
>> > +
>> > +	bi =3D netdev_priv(bypass_netdev);
>> > +	backup =3D (slave_netdev->dev.parent =3D=3D bypass_netdev->dev.paren=
t);
>> > +	if (backup ? rtnl_dereference(bi->backup_netdev) :
>> > +			rtnl_dereference(bi->active_netdev)) {
>> > +		netdev_err(bypass_netdev, "%s attempting to register as slave dev w=
hen %s already present\n",
>> > +			   slave_netdev->name, backup ? "backup" : "active");
>> > +		return -EEXIST;
>> > +	}
>> > +
>> > +	/* Avoid non pci devices as active netdev */
>> > +	if (!backup && (!slave_netdev->dev.parent ||
>> > +			!dev_is_pci(slave_netdev->dev.parent)))
>> > +		return -EINVAL;
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +static int bypass_slave_join(struct net_device *slave_netdev,
>> > +			     struct net_device *bypass_netdev,
>> > +			     struct bypass_ops *bypass_ops)
>> > +{
>> > +	struct bypass_info *bi;
>> > +	bool backup;
>> > +
>> > +	if (bypass_ops) {
>> > +		if (!bypass_ops->slave_join)
>> > +			return -EINVAL;
>> > +
>> > +		return bypass_ops->slave_join(slave_netdev, bypass_netdev);
>> > +	}
>> > +
>> > +	bi =3D netdev_priv(bypass_netdev);
>> > +	backup =3D (slave_netdev->dev.parent =3D=3D bypass_netdev->dev.paren=
t);
>> > +
>> > +	dev_hold(slave_netdev);
>> > +
>> > +	if (backup) {
>> > +		rcu_assign_pointer(bi->backup_netdev, slave_netdev);
>> > +		dev_get_stats(bi->backup_netdev, &bi->backup_stats);
>> > +	} else {
>> > +		rcu_assign_pointer(bi->active_netdev, slave_netdev);
>> > +		dev_get_stats(bi->active_netdev, &bi->active_stats);
>> > +		bypass_netdev->min_mtu =3D slave_netdev->min_mtu;
>> > +		bypass_netdev->max_mtu =3D slave_netdev->max_mtu;
>> > +	}
>> > +
>> > +	netdev_info(bypass_netdev, "bypass slave:%s joined\n",
>> > +		    slave_netdev->name);
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +/* Called when slave dev is injecting data into network stack.
>> > + * Change the associated network device from lower dev to virtio.
>> > + * note: already called with rcu_read_lock
>> > + */
>> > +static rx_handler_result_t bypass_handle_frame(struct sk_buff **pskb)
>> > +{
>> > +	struct sk_buff *skb =3D *pskb;
>> > +	struct net_device *ndev =3D rcu_dereference(skb->dev->rx_handler_dat=
a);
>> > +
>> > +	skb->dev =3D ndev;
>> > +
>> > +	return RX_HANDLER_ANOTHER;
>> > +}
>> > +
>> > +static struct net_device *bypass_master_get_bymac(u8 *mac,
>> > +						  struct bypass_ops **ops)
>> > +{
>> > +	struct bypass_master *bypass_master;
>> > +	struct net_device *bypass_netdev;
>> > +
>> > +	spin_lock(&bypass_lock);
>> > +	list_for_each_entry(bypass_master, &bypass_master_list, list) {
>> As I wrote the last time, you don't need this list, spinlock.
>> You can do just something like:
>>          for_each_net(net) {
>>                  for_each_netdev(net, dev) {
>> 			if (netif_is_bypass_master(dev)) {
>
>This function returns the upper netdev as well as the ops associated
>with that netdev.
>bypass_master_list is a list of 'struct bypass_master' that associates

Well, can't you have it in netdev priv?


>'bypass_netdev' with 'bypass_ops' and gets added via bypass_master_registe=
r().
>We need 'ops' only to support the 2 netdev model of netvsc. ops will be
>NULL for 3-netdev model.

I see :(


>
>
>> =

>> =

>> =

>> =

>> > +		bypass_netdev =3D rcu_dereference(bypass_master->bypass_netdev);
>> > +		if (ether_addr_equal(bypass_netdev->perm_addr, mac)) {
>> > +			*ops =3D rcu_dereference(bypass_master->ops);
>> I don't see how rcu_dereference is ok here.
>> 1) I don't see rcu_read_lock taken
>> 2) Looks like bypass_master->ops has the same value across the whole
>>     existence.
>
>We hold rtnl_lock(), i think i need to change this to rtnl_dereference.
>Yes. ops doesn't change.

If it does not change, you can just access it directly.


>
>> =

>> =

>> > +			spin_unlock(&bypass_lock);
>> > +			return bypass_netdev;
>> > +		}
>> > +	}
>> > +	spin_unlock(&bypass_lock);
>> > +	return NULL;
>> > +}
>> > +
>> > +static int bypass_slave_register(struct net_device *slave_netdev)
>> > +{
>> > +	struct net_device *bypass_netdev;
>> > +	struct bypass_ops *bypass_ops;
>> > +	int ret, orig_mtu;
>> > +
>> > +	ASSERT_RTNL();
>> > +
>> > +	bypass_netdev =3D bypass_master_get_bymac(slave_netdev->perm_addr,
>> > +						&bypass_ops);
>> For master, could you use word "master" in the variables so it is clear?
>> Also, "dev" is fine instead of "netdev".
>> Something like "bpmaster_dev"
>
>bypass_master is of=A0 type struct bypass_master,=A0 bypass_netdev is of t=
ype struct net_device.

I was trying to point out, that "bypass_netdev" represents a "master"
netdev, yet it does not say master. That is why I suggested
"bpmaster_dev"


>I can change all _netdev suffixes to _dev to make the names shorter.

ok.


>
>
>> =

>> =

>> > +	if (!bypass_netdev)
>> > +		goto done;
>> > +
>> > +	ret =3D bypass_slave_pre_register(slave_netdev, bypass_netdev,
>> > +					bypass_ops);
>> > +	if (ret !=3D 0)
>> 	Just "if (ret)" will do. You have this on more places.
>
>OK.
>
>
>> =

>> =

>> > +		goto done;
>> > +
>> > +	ret =3D netdev_rx_handler_register(slave_netdev,
>> > +					 bypass_ops ? bypass_ops->handle_frame :
>> > +					 bypass_handle_frame, bypass_netdev);
>> > +	if (ret !=3D 0) {
>> > +		netdev_err(slave_netdev, "can not register bypass rx handler (err =
=3D %d)\n",
>> > +			   ret);
>> > +		goto done;
>> > +	}
>> > +
>> > +	ret =3D netdev_upper_dev_link(slave_netdev, bypass_netdev, NULL);
>> > +	if (ret !=3D 0) {
>> > +		netdev_err(slave_netdev, "can not set master device %s (err =3D %d)=
\n",
>> > +			   bypass_netdev->name, ret);
>> > +		goto upper_link_failed;
>> > +	}
>> > +
>> > +	slave_netdev->priv_flags |=3D IFF_BYPASS_SLAVE;
>> > +
>> > +	if (netif_running(bypass_netdev)) {
>> > +		ret =3D dev_open(slave_netdev);
>> > +		if (ret && (ret !=3D -EBUSY)) {
>> > +			netdev_err(bypass_netdev, "Opening slave %s failed ret:%d\n",
>> > +				   slave_netdev->name, ret);
>> > +			goto err_interface_up;
>> > +		}
>> > +	}
>> > +
>> > +	/* Align MTU of slave with master */
>> > +	orig_mtu =3D slave_netdev->mtu;
>> > +	ret =3D dev_set_mtu(slave_netdev, bypass_netdev->mtu);
>> > +	if (ret !=3D 0) {
>> > +		netdev_err(bypass_netdev, "unable to change mtu of %s to %u registe=
r failed\n",
>> > +			   slave_netdev->name, bypass_netdev->mtu);
>> > +		goto err_set_mtu;
>> > +	}
>> > +
>> > +	ret =3D bypass_slave_join(slave_netdev, bypass_netdev, bypass_ops);
>> > +	if (ret !=3D 0)
>> > +		goto err_join;
>> > +
>> > +	call_netdevice_notifiers(NETDEV_JOIN, slave_netdev);
>> > +
>> > +	netdev_info(bypass_netdev, "bypass slave:%s registered\n",
>> > +		    slave_netdev->name);
>> > +
>> > +	goto done;
>> > +
>> > +err_join:
>> > +	dev_set_mtu(slave_netdev, orig_mtu);
>> > +err_set_mtu:
>> > +	dev_close(slave_netdev);
>> > +err_interface_up:
>> > +	netdev_upper_dev_unlink(slave_netdev, bypass_netdev);
>> > +	slave_netdev->priv_flags &=3D ~IFF_BYPASS_SLAVE;
>> > +upper_link_failed:
>> > +	netdev_rx_handler_unregister(slave_netdev);
>> > +done:
>> > +	return NOTIFY_DONE;
>> > +}
>> > +
>> > +static int bypass_slave_pre_unregister(struct net_device *slave_netde=
v,
>> > +				       struct net_device *bypass_netdev,
>> > +				       struct bypass_ops *bypass_ops)
>> > +{
>> > +	struct net_device *backup_netdev, *active_netdev;
>> > +	struct bypass_info *bi;
>> > +
>> > +	if (bypass_ops) {
>> > +		if (!bypass_ops->slave_pre_unregister)
>> > +			return -EINVAL;
>> > +
>> > +		return bypass_ops->slave_pre_unregister(slave_netdev,
>> > +							bypass_netdev);
>> > +	}
>> > +
>> > +	bi =3D netdev_priv(bypass_netdev);
>> > +	active_netdev =3D rtnl_dereference(bi->active_netdev);
>> > +	backup_netdev =3D rtnl_dereference(bi->backup_netdev);
>> > +
>> > +	if (slave_netdev !=3D active_netdev && slave_netdev !=3D backup_netd=
ev)
>> > +		return -EINVAL;
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +static int bypass_slave_release(struct net_device *slave_netdev,
>> > +				struct net_device *bypass_netdev,
>> > +				struct bypass_ops *bypass_ops)
>> > +{
>> > +	struct net_device *backup_netdev, *active_netdev;
>> > +	struct bypass_info *bi;
>> > +
>> > +	if (bypass_ops) {
>> > +		if (!bypass_ops->slave_release)
>> > +			return -EINVAL;
>> I think it would be good to make the API to the driver more strict and
>> have a separate set of ops for "active" and "backup" netdevices.
>> That should stop people thinking about extending this to more slaves in
>> the future.
>
>We have checks in slave_pre_register() that allows only 1 'backup' and 1
>'active' slave.

I'm very well aware of that. I just thought that explicit ops for the
two slaves would make this more clear.


>
>
>> =

>> =

>> =

>> > +
>> > +		return bypass_ops->slave_release(slave_netdev, bypass_netdev);
>> > +	}
>> > +
>> > +	bi =3D netdev_priv(bypass_netdev);
>> > +	active_netdev =3D rtnl_dereference(bi->active_netdev);
>> > +	backup_netdev =3D rtnl_dereference(bi->backup_netdev);
>> > +
>> > +	if (slave_netdev =3D=3D backup_netdev) {
>> > +		RCU_INIT_POINTER(bi->backup_netdev, NULL);
>> > +	} else {
>> > +		RCU_INIT_POINTER(bi->active_netdev, NULL);
>> > +		if (backup_netdev) {
>> > +			bypass_netdev->min_mtu =3D backup_netdev->min_mtu;
>> > +			bypass_netdev->max_mtu =3D backup_netdev->max_mtu;
>> > +		}
>> > +	}
>> > +
>> > +	dev_put(slave_netdev);
>> > +
>> > +	netdev_info(bypass_netdev, "bypass slave:%s released\n",
>> > +		    slave_netdev->name);
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +int bypass_slave_unregister(struct net_device *slave_netdev)
>> > +{
>> > +	struct net_device *bypass_netdev;
>> > +	struct bypass_ops *bypass_ops;
>> > +	int ret;
>> > +
>> > +	if (!netif_is_bypass_slave(slave_netdev))
>> > +		goto done;
>> > +
>> > +	ASSERT_RTNL();
>> > +
>> > +	bypass_netdev =3D bypass_master_get_bymac(slave_netdev->perm_addr,
>> > +						&bypass_ops);
>> > +	if (!bypass_netdev)
>> > +		goto done;
>> > +
>> > +	ret =3D bypass_slave_pre_unregister(slave_netdev, bypass_netdev,
>> > +					  bypass_ops);
>> > +	if (ret !=3D 0)
>> > +		goto done;
>> > +
>> > +	netdev_rx_handler_unregister(slave_netdev);
>> > +	netdev_upper_dev_unlink(slave_netdev, bypass_netdev);
>> > +	slave_netdev->priv_flags &=3D ~IFF_BYPASS_SLAVE;
>> > +
>> > +	bypass_slave_release(slave_netdev, bypass_netdev, bypass_ops);
>> > +
>> > +	netdev_info(bypass_netdev, "bypass slave:%s unregistered\n",
>> > +		    slave_netdev->name);
>> > +
>> > +done:
>> > +	return NOTIFY_DONE;
>> > +}
>> > +EXPORT_SYMBOL_GPL(bypass_slave_unregister);
>> > +
>> > +static bool bypass_xmit_ready(struct net_device *dev)
>> > +{
>> > +	return netif_running(dev) && netif_carrier_ok(dev);
>> > +}
>> > +
>> > +static int bypass_slave_link_change(struct net_device *slave_netdev)
>> > +{
>> > +	struct net_device *bypass_netdev, *active_netdev, *backup_netdev;
>> > +	struct bypass_ops *bypass_ops;
>> > +	struct bypass_info *bi;
>> > +
>> > +	if (!netif_is_bypass_slave(slave_netdev))
>> > +		goto done;
>> > +
>> > +	ASSERT_RTNL();
>> > +
>> > +	bypass_netdev =3D bypass_master_get_bymac(slave_netdev->perm_addr,
>> > +						&bypass_ops);
>> > +	if (!bypass_netdev)
>> > +		goto done;
>> > +
>> > +	if (bypass_ops) {
>> > +		if (!bypass_ops->slave_link_change)
>> > +			goto done;
>> > +
>> > +		return bypass_ops->slave_link_change(slave_netdev,
>> > +						     bypass_netdev);
>> > +	}
>> > +
>> > +	if (!netif_running(bypass_netdev))
>> > +		return 0;
>> > +
>> > +	bi =3D netdev_priv(bypass_netdev);
>> > +
>> > +	active_netdev =3D rtnl_dereference(bi->active_netdev);
>> > +	backup_netdev =3D rtnl_dereference(bi->backup_netdev);
>> > +
>> > +	if (slave_netdev !=3D active_netdev && slave_netdev !=3D backup_netd=
ev)
>> > +		goto done;
>> You don't need this check. "if (!netif_is_bypass_slave(slave_netdev))"
>> above is enough.
>
>I think we need this check to not allow events from a slave that is not
>attached to this master but has the same MAC.

Why do we need such events? Seems wrong to me. Consider:

bp1      bp2
a1 b1    a2 b2


a1 and a2 have the same mac and bp1 and bp2 have the same mac.
Now bypass_master_get_bymac() will return always bp1 or bp2 - depending on
the order of creation.
Let's say it will return bp1. Then when we have event for a2, the
bypass_ops->slave_link_change is called with (a2, bp1). That is wrong.


You cannot use bypass_master_get_bymac() here.



>
>> =

>> =

>> > +
>> > +	if ((active_netdev && bypass_xmit_ready(active_netdev)) ||
>> > +	    (backup_netdev && bypass_xmit_ready(backup_netdev))) {
>> > +		netif_carrier_on(bypass_netdev);
>> > +		netif_tx_wake_all_queues(bypass_netdev);
>> > +	} else {
>> > +		netif_carrier_off(bypass_netdev);
>> > +		netif_tx_stop_all_queues(bypass_netdev);
>> > +	}
>> > +
>> > +done:
>> > +	return NOTIFY_DONE;
>> > +}
>> > +
>> > +static bool bypass_validate_event_dev(struct net_device *dev)
>> > +{
>> > +	/* Skip parent events */
>> > +	if (netif_is_bypass_master(dev))
>> > +		return false;
>> > +
>> > +	/* Avoid non-Ethernet type devices */
>> > +	if (dev->type !=3D ARPHRD_ETHER)
>> > +		return false;
>> > +
>> > +	/* Avoid Vlan dev with same MAC registering as VF */
>> > +	if (is_vlan_dev(dev))
>> > +		return false;
>> > +
>> > +	/* Avoid Bonding master dev with same MAC registering as slave dev */
>> > +	if ((dev->priv_flags & IFF_BONDING) && (dev->flags & IFF_MASTER))
>> Yeah, this is certainly incorrect. One thing is, you should be using the
>> helpers netif_is_bond_master().
>> But what about the rest? macsec, macvlan, team, bridge, ovs and others?
>> =

>> You need to do it not by blacklisting, but with whitelisting. You need
>> to whitelist VF devices. My port flavours patchset might help with this.
>
>May be i can use netdev_has_lower_dev() helper to make sure that the slave

I don't see such function in the code.


>device is not an upper dev.
>Can you point to your port flavours patchset? Is it upstream?

I sent rfc couple of weeks ago:
[patch net-next RFC 00/12] devlink: introduce port flavours and common phys=
_port_name generation


>
>> =

>> =

>> > +		return false;
>> > +
>> > +	return true;
>> > +}
>> > +
>> > +static int
>> > +bypass_event(struct notifier_block *this, unsigned long event, void *=
ptr)
>> > +{
>> > +	struct net_device *event_dev =3D netdev_notifier_info_to_dev(ptr);
>> > +
>> > +	if (!bypass_validate_event_dev(event_dev))
>> > +		return NOTIFY_DONE;
>> > +
>> > +	switch (event) {
>> > +	case NETDEV_REGISTER:
>> > +		return bypass_slave_register(event_dev);
>> > +	case NETDEV_UNREGISTER:
>> > +		return bypass_slave_unregister(event_dev);
>> > +	case NETDEV_UP:
>> > +	case NETDEV_DOWN:
>> > +	case NETDEV_CHANGE:
>> > +		return bypass_slave_link_change(event_dev);
>> > +	default:
>> > +		return NOTIFY_DONE;
>> > +	}
>> > +}
>> > +
>> > +static struct notifier_block bypass_notifier =3D {
>> > +	.notifier_call =3D bypass_event,
>> > +};
>> > +
>> > +int bypass_open(struct net_device *dev)
>> > +{
>> > +	struct bypass_info *bi =3D netdev_priv(dev);
>> > +	struct net_device *active_netdev, *backup_netdev;
>> > +	int err;
>> > +
>> > +	netif_carrier_off(dev);
>> > +	netif_tx_wake_all_queues(dev);
>> > +
>> > +	active_netdev =3D rtnl_dereference(bi->active_netdev);
>> > +	if (active_netdev) {
>> > +		err =3D dev_open(active_netdev);
>> > +		if (err)
>> > +			goto err_active_open;
>> > +	}
>> > +
>> > +	backup_netdev =3D rtnl_dereference(bi->backup_netdev);
>> > +	if (backup_netdev) {
>> > +		err =3D dev_open(backup_netdev);
>> > +		if (err)
>> > +			goto err_backup_open;
>> > +	}
>> > +
>> > +	return 0;
>> > +
>> > +err_backup_open:
>> > +	dev_close(active_netdev);
>> > +err_active_open:
>> > +	netif_tx_disable(dev);
>> > +	return err;
>> > +}
>> > +EXPORT_SYMBOL_GPL(bypass_open);
>> > +
>> > +int bypass_close(struct net_device *dev)
>> > +{
>> > +	struct bypass_info *vi =3D netdev_priv(dev);
>> This should be probably "bi"
>
>Yes.
>
>
>> =

>> =

>> > +	struct net_device *slave_netdev;
>> > +
>> > +	netif_tx_disable(dev);
>> > +
>> > +	slave_netdev =3D rtnl_dereference(vi->active_netdev);
>> > +	if (slave_netdev)
>> > +		dev_close(slave_netdev);
>> > +
>> > +	slave_netdev =3D rtnl_dereference(vi->backup_netdev);
>> > +	if (slave_netdev)
>> > +		dev_close(slave_netdev);
>> > +
>> > +	return 0;
>> > +}
>> > +EXPORT_SYMBOL_GPL(bypass_close);
>> > +
>> > +static netdev_tx_t bypass_drop_xmit(struct sk_buff *skb, struct net_d=
evice *dev)
>> > +{
>> > +	atomic_long_inc(&dev->tx_dropped);
>> > +	dev_kfree_skb_any(skb);
>> > +	return NETDEV_TX_OK;
>> > +}
>> > +
>> > +netdev_tx_t bypass_start_xmit(struct sk_buff *skb, struct net_device =
*dev)
>> > +{
>> > +	struct bypass_info *bi =3D netdev_priv(dev);
>> If you rename the other variable to "bpmaster_dev", it would be nice to
>> rename this to bpinfo or something more descriptive. "bi" is too short
>> to know what that is right away.
>
>Will rename bypass_netdev to bypass_dev. bypass indicates that it is
>an upper master dev.
>
>
>> =

>> =

>> > +	struct net_device *xmit_dev;
>> Don't mix "dev" and "netdev" in one .c file. Just use "dev" for all.
>
>OK.
>
>
>> =

>> =

>> =

>> > +
>> > +	/* Try xmit via active netdev followed by backup netdev */
>> > +	xmit_dev =3D rcu_dereference_bh(bi->active_netdev);
>> > +	if (!xmit_dev || !bypass_xmit_ready(xmit_dev)) {
>> > +		xmit_dev =3D rcu_dereference_bh(bi->backup_netdev);
>> > +		if (!xmit_dev || !bypass_xmit_ready(xmit_dev))
>> > +			return bypass_drop_xmit(skb, dev);
>> > +	}
>> > +
>> > +	skb->dev =3D xmit_dev;
>> > +	skb->queue_mapping =3D qdisc_skb_cb(skb)->slave_dev_queue_mapping;
>> > +
>> > +	return dev_queue_xmit(skb);
>> > +}
>> > +EXPORT_SYMBOL_GPL(bypass_start_xmit);
>> > +
>> > +u16 bypass_select_queue(struct net_device *dev, struct sk_buff *skb,
>> > +			void *accel_priv, select_queue_fallback_t fallback)
>> > +{
>> > +	/* This helper function exists to help dev_pick_tx get the correct
>> > +	 * destination queue.  Using a helper function skips a call to
>> > +	 * skb_tx_hash and will put the skbs in the queue we expect on their
>> > +	 * way down to the bonding driver.
>> > +	 */
>> > +	u16 txq =3D skb_rx_queue_recorded(skb) ? skb_get_rx_queue(skb) : 0;
>> > +
>> > +	/* Save the original txq to restore before passing to the driver */
>> > +	qdisc_skb_cb(skb)->slave_dev_queue_mapping =3D skb->queue_mapping;
>> > +
>> > +	if (unlikely(txq >=3D dev->real_num_tx_queues)) {
>> > +		do {
>> > +			txq -=3D dev->real_num_tx_queues;
>> > +		} while (txq >=3D dev->real_num_tx_queues);
>> > +	}
>> > +
>> > +	return txq;
>> > +}
>> > +EXPORT_SYMBOL_GPL(bypass_select_queue);
>> > +
>> > +/* fold stats, assuming all rtnl_link_stats64 fields are u64, but
>> > + * that some drivers can provide 32bit values only.
>> > + */
>> > +static void bypass_fold_stats(struct rtnl_link_stats64 *_res,
>> > +			      const struct rtnl_link_stats64 *_new,
>> > +			      const struct rtnl_link_stats64 *_old)
>> > +{
>> > +	const u64 *new =3D (const u64 *)_new;
>> > +	const u64 *old =3D (const u64 *)_old;
>> > +	u64 *res =3D (u64 *)_res;
>> > +	int i;
>> > +
>> > +	for (i =3D 0; i < sizeof(*_res) / sizeof(u64); i++) {
>> > +		u64 nv =3D new[i];
>> > +		u64 ov =3D old[i];
>> > +		s64 delta =3D nv - ov;
>> > +
>> > +		/* detects if this particular field is 32bit only */
>> > +		if (((nv | ov) >> 32) =3D=3D 0)
>> > +			delta =3D (s64)(s32)((u32)nv - (u32)ov);
>> > +
>> > +		/* filter anomalies, some drivers reset their stats
>> > +		 * at down/up events.
>> > +		 */
>> > +		if (delta > 0)
>> > +			res[i] +=3D delta;
>> > +	}
>> > +}
>> > +
>> > +void bypass_get_stats(struct net_device *dev, struct rtnl_link_stats6=
4 *stats)
>> > +{
>> > +	struct bypass_info *bi =3D netdev_priv(dev);
>> You can WARN_ON and return in case the dev is not bypass master, just
>> to catch buggy drivers. Same with other helpers.
>
>I can make this static and not export this helper as well as all
>bypass_netdev ops.

Ok.


>
>> =

>> =

>> > +	const struct rtnl_link_stats64 *new;
>> > +	struct rtnl_link_stats64 temp;
>> > +	struct net_device *slave_netdev;
>> > +
>> > +	spin_lock(&bi->stats_lock);
>> > +	memcpy(stats, &bi->bypass_stats, sizeof(*stats));
>> > +
>> > +	rcu_read_lock();
>> > +
>> > +	slave_netdev =3D rcu_dereference(bi->active_netdev);
>> > +	if (slave_netdev) {
>> > +		new =3D dev_get_stats(slave_netdev, &temp);
>> > +		bypass_fold_stats(stats, new, &bi->active_stats);
>> > +		memcpy(&bi->active_stats, new, sizeof(*new));
>> > +	}
>> > +
>> > +	slave_netdev =3D rcu_dereference(bi->backup_netdev);
>> > +	if (slave_netdev) {
>> > +		new =3D dev_get_stats(slave_netdev, &temp);
>> > +		bypass_fold_stats(stats, new, &bi->backup_stats);
>> > +		memcpy(&bi->backup_stats, new, sizeof(*new));
>> > +	}
>> > +
>> > +	rcu_read_unlock();
>> > +
>> > +	memcpy(&bi->bypass_stats, stats, sizeof(*stats));
>> > +	spin_unlock(&bi->stats_lock);
>> > +}
>> > +EXPORT_SYMBOL_GPL(bypass_get_stats);
>> > +
>> > +int bypass_change_mtu(struct net_device *dev, int new_mtu)
>> > +{
>> > +	struct bypass_info *bi =3D netdev_priv(dev);
>> > +	struct net_device *active_netdev, *backup_netdev;
>> > +	int ret =3D 0;
>> Pointless initialization.
>> =

>> =

>> > +
>> > +	active_netdev =3D rcu_dereference(bi->active_netdev);
>> > +	if (active_netdev) {
>> > +		ret =3D dev_set_mtu(active_netdev, new_mtu);
>> > +		if (ret)
>> > +			return ret;
>> > +	}
>> > +
>> > +	backup_netdev =3D rcu_dereference(bi->backup_netdev);
>> > +	if (backup_netdev) {
>> > +		ret =3D dev_set_mtu(backup_netdev, new_mtu);
>> > +		if (ret) {
>> > +			dev_set_mtu(active_netdev, dev->mtu);
>> > +			return ret;
>> > +		}
>> > +	}
>> > +
>> > +	dev->mtu =3D new_mtu;
>> > +	return 0;
>> > +}
>> > +EXPORT_SYMBOL_GPL(bypass_change_mtu);
>> > +
>> > +void bypass_set_rx_mode(struct net_device *dev)
>> > +{
>> > +	struct bypass_info *bi =3D netdev_priv(dev);
>> > +	struct net_device *slave_netdev;
>> > +
>> > +	rcu_read_lock();
>> > +
>> > +	slave_netdev =3D rcu_dereference(bi->active_netdev);
>> > +	if (slave_netdev) {
>> > +		dev_uc_sync_multiple(slave_netdev, dev);
>> > +		dev_mc_sync_multiple(slave_netdev, dev);
>> > +	}
>> > +
>> > +	slave_netdev =3D rcu_dereference(bi->backup_netdev);
>> > +	if (slave_netdev) {
>> > +		dev_uc_sync_multiple(slave_netdev, dev);
>> > +		dev_mc_sync_multiple(slave_netdev, dev);
>> > +	}
>> > +
>> > +	rcu_read_unlock();
>> > +}
>> > +EXPORT_SYMBOL_GPL(bypass_set_rx_mode);
>> > +
>> > +static const struct net_device_ops bypass_netdev_ops =3D {
>> > +	.ndo_open		=3D bypass_open,
>> > +	.ndo_stop		=3D bypass_close,
>> > +	.ndo_start_xmit		=3D bypass_start_xmit,
>> > +	.ndo_select_queue	=3D bypass_select_queue,
>> > +	.ndo_get_stats64	=3D bypass_get_stats,
>> > +	.ndo_change_mtu		=3D bypass_change_mtu,
>> > +	.ndo_set_rx_mode	=3D bypass_set_rx_mode,
>> > +	.ndo_validate_addr	=3D eth_validate_addr,
>> > +	.ndo_features_check	=3D passthru_features_check,
>> > +};
>> > +
>> > +#define BYPASS_DRV_NAME "bypass"
>> > +#define BYPASS_DRV_VERSION "0.1"
>> > +
>> > +static void bypass_ethtool_get_drvinfo(struct net_device *dev,
>> > +				       struct ethtool_drvinfo *drvinfo)
>> > +{
>> > +	strlcpy(drvinfo->driver, BYPASS_DRV_NAME, sizeof(drvinfo->driver));
>> > +	strlcpy(drvinfo->version, BYPASS_DRV_VERSION, sizeof(drvinfo->versio=
n));
>> > +}
>> > +
>> > +int bypass_ethtool_get_link_ksettings(struct net_device *dev,
>> > +				      struct ethtool_link_ksettings *cmd)
>> > +{
>> > +	struct bypass_info *bi =3D netdev_priv(dev);
>> > +	struct net_device *slave_netdev;
>> > +
>> > +	slave_netdev =3D rtnl_dereference(bi->active_netdev);
>> > +	if (!slave_netdev || !bypass_xmit_ready(slave_netdev)) {
>> > +		slave_netdev =3D rtnl_dereference(bi->backup_netdev);
>> > +		if (!slave_netdev || !bypass_xmit_ready(slave_netdev)) {
>> > +			cmd->base.duplex =3D DUPLEX_UNKNOWN;
>> > +			cmd->base.port =3D PORT_OTHER;
>> > +			cmd->base.speed =3D SPEED_UNKNOWN;
>> > +
>> > +			return 0;
>> > +		}
>> > +	}
>> > +
>> > +	return __ethtool_get_link_ksettings(slave_netdev, cmd);
>> > +}
>> > +EXPORT_SYMBOL_GPL(bypass_ethtool_get_link_ksettings);
>> > +
>> > +static const struct ethtool_ops bypass_ethtool_ops =3D {
>> > +	.get_drvinfo            =3D bypass_ethtool_get_drvinfo,
>> > +	.get_link               =3D ethtool_op_get_link,
>> > +	.get_link_ksettings     =3D bypass_ethtool_get_link_ksettings,
>> > +};
>> > +
>> > +static void bypass_register_existing_slave(struct net_device *bypass_=
netdev)
>> > +{
>> > +	struct net *net =3D dev_net(bypass_netdev);
>> > +	struct net_device *dev;
>> > +
>> > +	rtnl_lock();
>> > +	for_each_netdev(net, dev) {
>> > +		if (dev =3D=3D bypass_netdev)
>> > +			continue;
>> > +		if (!bypass_validate_event_dev(dev))
>> > +			continue;
>> > +		if (ether_addr_equal(bypass_netdev->perm_addr, dev->perm_addr))
>> > +			bypass_slave_register(dev);
>> > +	}
>> > +	rtnl_unlock();
>> > +}
>> > +
>> > +int bypass_master_register(struct net_device *dev, struct bypass_ops =
*ops,
>> > +			   struct bypass_master **pbypass_master)
>> > +{
>> > +	struct bypass_master *bypass_master;
>> > +
>> > +	bypass_master =3D kzalloc(sizeof(*bypass_master), GFP_KERNEL);
>> > +	if (!bypass_master)
>> > +		return -ENOMEM;
>> > +
>> > +	rcu_assign_pointer(bypass_master->ops, ops);
>> > +	dev_hold(dev);
>> > +	dev->priv_flags |=3D IFF_BYPASS;
>> > +	rcu_assign_pointer(bypass_master->bypass_netdev, dev);
>> > +
>> > +	spin_lock(&bypass_lock);
>> > +	list_add_tail(&bypass_master->list, &bypass_master_list);
>> > +	spin_unlock(&bypass_lock);
>> > +
>> > +	bypass_register_existing_slave(dev);
>> > +
>> > +	*pbypass_master =3D bypass_master;
>> > +	return 0;
>> > +}
>> > +EXPORT_SYMBOL_GPL(bypass_master_register);
>> > +
>> > +void bypass_master_unregister(struct bypass_master *bypass_master)
>> > +{
>> > +	struct net_device *bypass_netdev;
>> > +
>> > +	bypass_netdev =3D rcu_dereference(bypass_master->bypass_netdev);
>> > +
>> > +	bypass_netdev->priv_flags &=3D ~IFF_BYPASS;
>> > +	dev_put(bypass_netdev);
>> > +
>> > +	spin_lock(&bypass_lock);
>> > +	list_del(&bypass_master->list);
>> > +	spin_unlock(&bypass_lock);
>> > +
>> > +	kfree(bypass_master);
>> > +}
>> > +EXPORT_SYMBOL_GPL(bypass_master_unregister);
>> > +
>> > +int bypass_master_create(struct net_device *backup_netdev,
>> > +			 struct bypass_master **pbypass_master)
>> > +{
>> > +	struct device *dev =3D backup_netdev->dev.parent;
>> > +	struct net_device *bypass_netdev;
>> > +	int err;
>> > +
>> > +	/* Alloc at least 2 queues, for now we are going with 16 assuming
>> > +	 * that most devices being bonded won't have too many queues.
>> > +	 */
>> > +	bypass_netdev =3D alloc_etherdev_mq(sizeof(struct bypass_info), 16);
>> > +	if (!bypass_netdev) {
>> > +		dev_err(dev, "Unable to allocate bypass_netdev!\n");
>> > +		return -ENOMEM;
>> > +	}
>> > +
>> > +	dev_net_set(bypass_netdev, dev_net(backup_netdev));
>> > +	SET_NETDEV_DEV(bypass_netdev, dev);
>> > +
>> > +	bypass_netdev->netdev_ops =3D &bypass_netdev_ops;
>> > +	bypass_netdev->ethtool_ops =3D &bypass_ethtool_ops;
>> > +
>> > +	/* Initialize the device options */
>> > +	bypass_netdev->priv_flags |=3D IFF_UNICAST_FLT | IFF_NO_QUEUE;
>> > +	bypass_netdev->priv_flags &=3D ~(IFF_XMIT_DST_RELEASE |
>> > +				       IFF_TX_SKB_SHARING);
>> > +
>> > +	/* don't acquire bypass netdev's netif_tx_lock when transmitting */
>> > +	bypass_netdev->features |=3D NETIF_F_LLTX;
>> > +
>> > +	/* Don't allow bypass devices to change network namespaces. */
>> > +	bypass_netdev->features |=3D NETIF_F_NETNS_LOCAL;
>> > +
>> > +	bypass_netdev->hw_features =3D NETIF_F_HW_CSUM | NETIF_F_SG |
>> > +				     NETIF_F_FRAGLIST | NETIF_F_ALL_TSO |
>> > +				     NETIF_F_HIGHDMA | NETIF_F_LRO;
>> > +
>> > +	bypass_netdev->hw_features |=3D NETIF_F_GSO_ENCAP_ALL;
>> > +	bypass_netdev->features |=3D bypass_netdev->hw_features;
>> > +
>> > +	memcpy(bypass_netdev->dev_addr, backup_netdev->dev_addr,
>> > +	       bypass_netdev->addr_len);
>> > +
>> > +	bypass_netdev->min_mtu =3D backup_netdev->min_mtu;
>> > +	bypass_netdev->max_mtu =3D backup_netdev->max_mtu;
>> > +
>> > +	err =3D register_netdev(bypass_netdev);
>> > +	if (err < 0) {
>> > +		dev_err(dev, "Unable to register bypass_netdev!\n");
>> > +		goto err_register_netdev;
>> > +	}
>> > +
>> > +	netif_carrier_off(bypass_netdev);
>> > +
>> > +	err =3D bypass_master_register(bypass_netdev, NULL, pbypass_master);
>> > +	if (err < 0)
>> just "if (err)" would do.
>
>OK
>
>> =

>> =

>> > +		goto err_bypass;
>> > +
>> > +	return 0;
>> > +
>> > +err_bypass:
>> > +	unregister_netdev(bypass_netdev);
>> > +err_register_netdev:
>> > +	free_netdev(bypass_netdev);
>> > +
>> > +	return err;
>> > +}
>> > +EXPORT_SYMBOL_GPL(bypass_master_create);
>> > +
>> > +void bypass_master_destroy(struct bypass_master *bypass_master)
>> > +{
>> > +	struct net_device *bypass_netdev;
>> > +	struct net_device *slave_netdev;
>> > +	struct bypass_info *bi;
>> > +
>> > +	if (!bypass_master)
>> > +		return;
>> > +
>> > +	bypass_netdev =3D rcu_dereference(bypass_master->bypass_netdev);
>> > +	bi =3D netdev_priv(bypass_netdev);
>> > +
>> > +	netif_device_detach(bypass_netdev);
>> > +
>> > +	rtnl_lock();
>> > +
>> > +	slave_netdev =3D rtnl_dereference(bi->active_netdev);
>> > +	if (slave_netdev)
>> > +		bypass_slave_unregister(slave_netdev);
>> > +
>> > +	slave_netdev =3D rtnl_dereference(bi->backup_netdev);
>> > +	if (slave_netdev)
>> > +		bypass_slave_unregister(slave_netdev);
>> > +
>> > +	bypass_master_unregister(bypass_master);
>> > +
>> > +	unregister_netdevice(bypass_netdev);
>> > +
>> > +	rtnl_unlock();
>> > +
>> > +	free_netdev(bypass_netdev);
>> > +}
>> > +EXPORT_SYMBOL_GPL(bypass_master_destroy);
>> > +
>> > +static __init int
>> > +bypass_init(void)
>> > +{
>> > +	register_netdevice_notifier(&bypass_notifier);
>> > +
>> > +	return 0;
>> > +}
>> > +module_init(bypass_init);
>> > +
>> > +static __exit
>> > +void bypass_exit(void)
>> > +{
>> > +	unregister_netdevice_notifier(&bypass_notifier);
>> > +}
>> > +module_exit(bypass_exit);
>> > +
>> > +MODULE_DESCRIPTION("Bypass infrastructure/interface for Paravirtual d=
rivers");
>> > +MODULE_LICENSE("GPL v2");
>> > -- =

>> > 2.14.3
>> > =

>
