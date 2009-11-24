From: Patrick McHardy <kaber@trash.net>
Subject: Re: [PATCH 2/4] macvlan: cleanup rx statistics
Date: Tue, 24 Nov 2009 11:41:38 +0100
Message-ID: <4B0BB862.6070101__34872.7101846181$1259059723$gmane$org@trash.net>
References: <1259024166-28158-1-git-send-email-arnd@arndb.de>
	<1259024166-28158-3-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259024166-28158-3-git-send-email-arnd@arndb.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Eric Dumazet <eric.dumazet@gmail.com>, Anna Fischer <anna.fischer@hp.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Mark Smith <lk-netdev@lk-netdev.nosense.org>, Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Osterkamp <jens@linux.vnet.ibm.com>, Patrick Mullaney <pmullaney@novell.com>, Stephen Hemminger <shemminger@vyatta.com>, Edge Virtual Bridging <evb@yahoogroups.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Arnd Bergmann wrote:
> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
> index ae2b5c7..a0dea23 100644
> --- a/drivers/net/macvlan.c
> +++ b/drivers/net/macvlan.c
> @@ -116,42 +116,53 @@ static int macvlan_addr_busy(const struct macvlan_port *port,
>  	return 0;
>  }
>  
> +static inline void macvlan_count_rx(const struct macvlan_dev *vlan, int length,

Please use unsigned int for length values.

Regarding Eric's comments, I also think it would be more readable to use
if (success) {
	...
} else {
	...
}

> +			     int success, int multicast)
> +{
> +	struct macvlan_rx_stats *rx_stats;
> +
> +	rx_stats = per_cpu_ptr(vlan->rx_stats, smp_processor_id());
> +	rx_stats->rx_packets += success != 0;
> +	rx_stats->rx_bytes   += success ? length : 0;
> +	rx_stats->multicast  += success && multicast;
> +	rx_stats->rx_errors  += !success;
> +}
> +
> +static int macvlan_broadcast_one(struct sk_buff *skb, struct net_device *dev,
> +				 const struct ethhdr *eth)
> +{
> +	if (!skb)
> +		return NET_RX_DROP;
> +
> +	skb->dev = dev;
> +	if (!compare_ether_addr_64bits(eth->h_dest,
> +				       dev->broadcast))

This would fit on one line without reducing readability.

> +		skb->pkt_type = PACKET_BROADCAST;
> +	else
> +		skb->pkt_type = PACKET_MULTICAST;
> +
> +	return netif_rx(skb);
> +}
