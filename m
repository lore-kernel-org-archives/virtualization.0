From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH net-next v10 2/4] net: Introduce generic failover module
Date: Mon, 7 May 2018 15:39:19 -0700
Message-ID: <460f3d8f-b2ec-2118-e296-03f4f9655c5a__9301.79418433017$1525732690$gmane$org@infradead.org>
References: <1525731046-10989-1-git-send-email-sridhar.samudrala@intel.com>
	<1525731046-10989-3-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1525731046-10989-3-git-send-email-sridhar.samudrala@intel.com>
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
To: Sridhar Samudrala <sridhar.samudrala@intel.com>, mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

On 05/07/2018 03:10 PM, Sridhar Samudrala wrote:
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  MAINTAINERS                |    7 +
>  include/linux/netdevice.h  |   16 +
>  include/net/net_failover.h |   52 +++
>  net/Kconfig                |   10 +
>  net/core/Makefile          |    1 +
>  net/core/net_failover.c    | 1044 ++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 1130 insertions(+)
>  create mode 100644 include/net/net_failover.h
>  create mode 100644 net/core/net_failover.c


> diff --git a/net/Kconfig b/net/Kconfig
> index b62089fb1332..0540856676de 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -429,6 +429,16 @@ config MAY_USE_DEVLINK
>  config PAGE_POOL
>         bool
>  
> +config NET_FAILOVER
> +	tristate "Failover interface"
> +	default m

Need some justification for default m (as opposed to n).

> +	help
> +	  This provides a generic interface for paravirtual drivers to listen
> +	  for netdev register/unregister/link change events from pci ethernet

	                                                         PCI

> +	  devices with the same MAC and takeover their datapath. This also
> +	  enables live migration of a VM with direct attached VF by failing
> +	  over to the paravirtual datapath when the VF is unplugged.
> +
>  endif   # if NET
>  
>  # Used by archs to tell that they support BPF JIT compiler plus which flavour.

> diff --git a/net/core/net_failover.c b/net/core/net_failover.c
> new file mode 100644
> index 000000000000..8d60e74e3034
> --- /dev/null
> +++ b/net/core/net_failover.c
> @@ -0,0 +1,1044 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2018, Intel Corporation. */
> +
> +/* A common module to handle registrations and notifications for paravirtual
> + * drivers to enable accelerated datapath and support VF live migration.
> + *
> + * The notifier and event handling code is based on netvsc driver and failover
> + * netdev management routines are based on bond/team driver.
> + *
> + */


> +/**
> + * net_failover_create - Create and register a failover instance
> + *
> + * @dev: standby netdev

    * @standby_dev: standby netdev

> + *
> + * Creates a failover netdev and registers a failover instance for a standby
> + * netdev. Used by paravirtual drivers that use 3-netdev model.
> + * The failover netdev acts as a master device and controls 2 slave devices -
> + * the original standby netdev and a VF netdev with the same MAC gets
> + * registered as primary netdev.
> + *
> + * Return: pointer to failover instance
> + */
> +struct net_failover *net_failover_create(struct net_device *standby_dev)
> +{
> +	struct device *dev = standby_dev->dev.parent;
> +	struct net_device *failover_dev;
> +	struct net_failover *failover;
> +	int err;
> +
> +	/* Alloc at least 2 queues, for now we are going with 16 assuming
> +	 * that VF devices being enslaved won't have too many queues.
> +	 */
> +	failover_dev = alloc_etherdev_mq(sizeof(struct net_failover_info), 16);
> +	if (!failover_dev) {
> +		dev_err(dev, "Unable to allocate failover_netdev!\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	dev_net_set(failover_dev, dev_net(standby_dev));
> +	SET_NETDEV_DEV(failover_dev, dev);
> +
> +	failover_dev->netdev_ops = &failover_dev_ops;
> +	failover_dev->ethtool_ops = &failover_ethtool_ops;
> +
> +	/* Initialize the device options */
> +	failover_dev->priv_flags |= IFF_UNICAST_FLT | IFF_NO_QUEUE;
> +	failover_dev->priv_flags &= ~(IFF_XMIT_DST_RELEASE |
> +				       IFF_TX_SKB_SHARING);
> +
> +	/* don't acquire failover netdev's netif_tx_lock when transmitting */
> +	failover_dev->features |= NETIF_F_LLTX;
> +
> +	/* Don't allow failover devices to change network namespaces. */
> +	failover_dev->features |= NETIF_F_NETNS_LOCAL;
> +
> +	failover_dev->hw_features = FAILOVER_VLAN_FEATURES |
> +				    NETIF_F_HW_VLAN_CTAG_TX |
> +				    NETIF_F_HW_VLAN_CTAG_RX |
> +				    NETIF_F_HW_VLAN_CTAG_FILTER;
> +
> +	failover_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL;
> +	failover_dev->features |= failover_dev->hw_features;
> +
> +	memcpy(failover_dev->dev_addr, standby_dev->dev_addr,
> +	       failover_dev->addr_len);
> +
> +	failover_dev->min_mtu = standby_dev->min_mtu;
> +	failover_dev->max_mtu = standby_dev->max_mtu;
> +
> +	err = register_netdev(failover_dev);
> +	if (err) {
> +		dev_err(dev, "Unable to register failover_dev!\n");
> +		goto err_register_netdev;
> +	}
> +
> +	netif_carrier_off(failover_dev);
> +
> +	failover = net_failover_register(failover_dev, NULL);
> +	if (IS_ERR(failover))
> +		goto err_failover_register;
> +
> +	return failover;
> +
> +err_failover_register:
> +	unregister_netdev(failover_dev);
> +err_register_netdev:
> +	free_netdev(failover_dev);
> +
> +	return ERR_PTR(err);
> +}
> +EXPORT_SYMBOL_GPL(net_failover_create);



-- 
~Randy
