From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Subject: Re: [PATCH v7 net-next 2/4] net: Introduce generic failover module
Date: Mon, 23 Apr 2018 10:21:45 -0700
Message-ID: <c252fc18-51fb-e92c-c37b-55e91b42fdbc@intel.com>
References: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
	<1524188524-28411-3-git-send-email-sridhar.samudrala@intel.com>
	<20180422200259-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180422200259-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: alexander.h.duyck@intel.com, virtio-dev@lists.oasis-open.org, jiri@resnulli.us, kubakici@wp.pl, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, loseweigh@gmail.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

On 4/22/2018 10:06 AM, Michael S. Tsirkin wrote:
> On Thu, Apr 19, 2018 at 06:42:02PM -0700, Sridhar Samudrala wrote:
>> +#if IS_ENABLED(CONFIG_NET_FAILOVER)
>> +
>> +int failover_create(struct net_device *standby_dev,
>> +		    struct failover **pfailover);
> Should we rename all these structs net_failover?
> It's possible to extend the concept to storage I think.

We could, the only downside is that the names become longer. i think we need
to change the filenames and the function names also to be consistent.


>
>> +void failover_destroy(struct failover *failover);
>> +
>> +int failover_register(struct net_device *standby_dev, struct failover_ops *ops,
>> +		      struct failover **pfailover);
>> +void failover_unregister(struct failover *failover);
>> +
>> +int failover_slave_unregister(struct net_device *slave_dev);
>> +
>> +#else
>> +
>> +static inline
>> +int failover_create(struct net_device *standby_dev,
>> +		    struct failover **pfailover);
>> +{
>> +	return 0;
> Does this make callers do something sane?
> Shouldn't these return an error?

Yes. i think i should return -EOPNOTSUPP here, so that we fail
when CONFIG_NET_FAILOVER is not enabled and the virtio-net driver is trying
to create a failover device.


>> +}
>> +
>> +static inline
>> +void failover_destroy(struct failover *failover)
>> +{
>> +}
>> +
>> +static inline
>> +int failover_register(struct net_device *standby_dev, struct failover_ops *ops,
>> +		      struct pfailover **pfailover);
>> +{
>> +	return 0;
>> +}
> struct pfailover seems like a typo.

yes. will also change the return to -EOPNOTSUPP

>
>> +
>> +static inline
>> +void failover_unregister(struct failover *failover)
>> +{
>> +}
>> +
>> +static inline
>> +int failover_slave_unregister(struct net_device *slave_dev)
>> +{
>> +	return 0;
>> +}
> Does anyone test return value of unregister?
> should this be void?

yes. can be changed to void.


>
>> +
>> +#endif
>> +
>> +#endif /* _NET_FAILOVER_H */
