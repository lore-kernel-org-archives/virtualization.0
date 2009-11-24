From: Patrick McHardy <kaber@trash.net>
Subject: Re: [PATCH 1/4] veth: move loopback logic to common location
Date: Tue, 24 Nov 2009 10:51:19 +0100
Message-ID: <4B0BAC97.6010000__36580.3878791214$1259056672$gmane$org@trash.net>
References: <1259024166-28158-1-git-send-email-arnd@arndb.de>
	<1259024166-28158-2-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259024166-28158-2-git-send-email-arnd@arndb.de>
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
> +int dev_forward_skb(struct net_device *dev, struct sk_buff *skb)
> +{
> +	skb_orphan(skb);
> +
> +	if (!(dev->flags & IFF_UP))
> +		return NET_RX_DROP;
> +
> +	if (skb->len > (dev->mtu + dev->hard_header_len))
> +		return NET_RX_DROP;
> +
> +	skb_dst_drop(skb);
> +	skb->tstamp.tv64 = 0;
> +	skb->pkt_type = PACKET_HOST;
> +	skb->protocol = eth_type_trans(skb, dev);
> +	skb->mark = 0;

skb->mark clearing should stay private to veth since its usually
supposed to stay intact. The only exception is packets crossing
namespaces, where they should appear like a freshly received skbs.

> +	secpath_reset(skb);
> +	nf_reset(skb);
> +	return netif_rx(skb);
> +}
> +EXPORT_SYMBOL_GPL(dev_forward_skb);
