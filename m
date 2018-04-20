From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 net-next 2/4] net: Introduce generic failover module
Date: Fri, 20 Apr 2018 18:34:27 +0300
Message-ID: <20180420183021-mutt-send-email-mst__29065.6471545391$1524238353$gmane$org@kernel.org>
References: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
	<1524188524-28411-3-git-send-email-sridhar.samudrala@intel.com>
	<20180420045657-mutt-send-email-mst@kernel.org>
	<d1bf0771-751b-85bc-4890-8232283131a2@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <d1bf0771-751b-85bc-4890-8232283131a2@intel.com>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Apr 20, 2018 at 08:21:00AM -0700, Samudrala, Sridhar wrote:
> > > +	finfo = netdev_priv(failover_dev);
> > > +
> > > +	primary_dev = rtnl_dereference(finfo->primary_dev);
> > > +	standby_dev = rtnl_dereference(finfo->standby_dev);
> > > +
> > > +	if (slave_dev != primary_dev && slave_dev != standby_dev)
> > > +		goto done;
> > > +
> > > +	if ((primary_dev && failover_xmit_ready(primary_dev)) ||
> > > +	    (standby_dev && failover_xmit_ready(standby_dev))) {
> > > +		netif_carrier_on(failover_dev);
> > > +		netif_tx_wake_all_queues(failover_dev);
> > > +	} else {
> > > +		netif_carrier_off(failover_dev);
> > > +		netif_tx_stop_all_queues(failover_dev);
> > And I think it's a good idea to get stats from device here too.
> 
> Not sure why we need to get stats from lower devs here?

link down is often indication of a hardware problem.
lower dev might stop responding down the road.

> > > +static const struct net_device_ops failover_dev_ops = {
> > > +	.ndo_open		= failover_open,
> > > +	.ndo_stop		= failover_close,
> > > +	.ndo_start_xmit		= failover_start_xmit,
> > > +	.ndo_select_queue	= failover_select_queue,
> > > +	.ndo_get_stats64	= failover_get_stats,
> > > +	.ndo_change_mtu		= failover_change_mtu,
> > > +	.ndo_set_rx_mode	= failover_set_rx_mode,
> > > +	.ndo_validate_addr	= eth_validate_addr,
> > > +	.ndo_features_check	= passthru_features_check,
> > xdp support?
> 
> I think it should be possible to add it be calling the lower dev ndo_xdp routines
> with proper checks. can we add this later?

I'd be concerned that if you don't xdp userspace will keep poking
at lower devs. Then it will stop working if you add this later.

-- 
MST
