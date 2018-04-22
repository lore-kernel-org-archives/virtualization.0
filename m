From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v7 net-next 2/4] net: Introduce generic failover module
Date: Sun, 22 Apr 2018 20:06:47 +0300
Message-ID: <20180422200259-mutt-send-email-mst__39079.7211243354$1524416707$gmane$org@kernel.org>
References: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
	<1524188524-28411-3-git-send-email-sridhar.samudrala@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1524188524-28411-3-git-send-email-sridhar.samudrala@intel.com>
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
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 19, 2018 at 06:42:02PM -0700, Sridhar Samudrala wrote:
> +#if IS_ENABLED(CONFIG_NET_FAILOVER)
> +
> +int failover_create(struct net_device *standby_dev,
> +		    struct failover **pfailover);

Should we rename all these structs net_failover?
It's possible to extend the concept to storage I think.

> +void failover_destroy(struct failover *failover);
> +
> +int failover_register(struct net_device *standby_dev, struct failover_ops *ops,
> +		      struct failover **pfailover);
> +void failover_unregister(struct failover *failover);
> +
> +int failover_slave_unregister(struct net_device *slave_dev);
> +
> +#else
> +
> +static inline
> +int failover_create(struct net_device *standby_dev,
> +		    struct failover **pfailover);
> +{
> +	return 0;

Does this make callers do something sane?
Shouldn't these return an error?

> +}
> +
> +static inline
> +void failover_destroy(struct failover *failover)
> +{
> +}
> +
> +static inline
> +int failover_register(struct net_device *standby_dev, struct failover_ops *ops,
> +		      struct pfailover **pfailover);
> +{
> +	return 0;
> +}

struct pfailover seems like a typo.

> +
> +static inline
> +void failover_unregister(struct failover *failover)
> +{
> +}
> +
> +static inline
> +int failover_slave_unregister(struct net_device *slave_dev)
> +{
> +	return 0;
> +}

Does anyone test return value of unregister?
should this be void?

> +
> +#endif
> +
> +#endif /* _NET_FAILOVER_H */
