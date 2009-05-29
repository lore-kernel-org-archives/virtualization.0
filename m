From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH 1/4] net: skb_orphan on dev_hard_start_xmit
Date: Fri, 29 May 2009 17:11:00 +0200
Message-ID: <4A1FFB04.30305__48049.043727997$1243632008$gmane$org@gmail.com>
References: <200905292344.56814.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200905292344.56814.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: libertas-dev@lists.infradead.org, Dan Williams <dcbw@redhat.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Roland Dreier <rolandd@cisco.com>, Divy Le Ray <divy@chelsio.com>, Pavel Emelianov <xemul@openvz.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell a =E9crit :
> Various drivers do skb_orphan() because they do not free transmitted
> skbs in a timely manner (causing apps which hit their socket limits to
> stall, socket close to hang, etc.).
> =

> DaveM points out that there are advantages to doing it generally (it's
> more likely to be on same CPU than after xmit), and I couldn't find
> any new starvation issues in simple benchmarking here.
> =

>

If really no starvations are possible at all, I really wonder why some
guys added memory accounting to UDP flows. Maybe they dont run "simple
benchmarks" but real apps ? :)

For TCP, I agree your patch is a huge benefit, since its paced by remote AC=
KS
and window control, but an UDP sender will likely be able to saturate a lin=
k.

Maybe we can try to selectively call skb_orphan() only for tcp packets ?

I understand your motivations are the driver simplifications, so you
want all packets being orphaned... hmm...

 This patch adds skb_orphan to the start of dev_hard_start_xmit(): it
> can be premature in the NETDEV_TX_BUSY case, but that's uncommon.
> =

> I removed the drivers' skb_orphan(), though it's harmless.
> =

> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Divy Le Ray <divy@chelsio.com>
> Cc: Roland Dreier <rolandd@cisco.com>
> Cc: Pavel Emelianov <xemul@openvz.org>
> Cc: Dan Williams <dcbw@redhat.com>
> Cc: libertas-dev@lists.infradead.org
> ---
>  drivers/net/cxgb3/sge.c            |   27 ---------------------------
>  drivers/net/loopback.c             |    2 --
>  drivers/net/mlx4/en_tx.c           |    4 ----
>  drivers/net/niu.c                  |    3 +--
>  drivers/net/veth.c                 |    2 --
>  drivers/net/wireless/libertas/tx.c |    3 ---
>  net/core/dev.c                     |   21 +++++----------------
>  7 files changed, 6 insertions(+), 56 deletions(-)
> =

> diff --git a/drivers/net/cxgb3/sge.c b/drivers/net/cxgb3/sge.c
> --- a/drivers/net/cxgb3/sge.c
> +++ b/drivers/net/cxgb3/sge.c
> @@ -1288,33 +1288,6 @@ int t3_eth_xmit(struct sk_buff *skb, str
>  	dev->trans_start =3D jiffies;
>  	spin_unlock(&q->lock);
>  =

> -	/*
> -	 * We do not use Tx completion interrupts to free DMAd Tx packets.
> -	 * This is good for performamce but means that we rely on new Tx
> -	 * packets arriving to run the destructors of completed packets,
> -	 * which open up space in their sockets' send queues.  Sometimes
> -	 * we do not get such new packets causing Tx to stall.  A single
> -	 * UDP transmitter is a good example of this situation.  We have
> -	 * a clean up timer that periodically reclaims completed packets
> -	 * but it doesn't run often enough (nor do we want it to) to prevent
> -	 * lengthy stalls.  A solution to this problem is to run the
> -	 * destructor early, after the packet is queued but before it's DMAd.
> -	 * A cons is that we lie to socket memory accounting, but the amount
> -	 * of extra memory is reasonable (limited by the number of Tx
> -	 * descriptors), the packets do actually get freed quickly by new
> -	 * packets almost always, and for protocols like TCP that wait for
> -	 * acks to really free up the data the extra memory is even less.
> -	 * On the positive side we run the destructors on the sending CPU
> -	 * rather than on a potentially different completing CPU, usually a
> -	 * good thing.  We also run them without holding our Tx queue lock,
> -	 * unlike what reclaim_completed_tx() would otherwise do.
> -	 *
> -	 * Run the destructor before telling the DMA engine about the packet
> -	 * to make sure it doesn't complete and get freed prematurely.
> -	 */
> -	if (likely(!skb_shared(skb)))
> -		skb_orphan(skb);
> -
>  	write_tx_pkt_wr(adap, skb, pi, pidx, gen, q, ndesc, compl);
>  	check_ring_tx_db(adap, q);
>  	return NETDEV_TX_OK;
> diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
> --- a/drivers/net/loopback.c
> +++ b/drivers/net/loopback.c
> @@ -72,8 +72,6 @@ static int loopback_xmit(struct sk_buff =

>  {
>  	struct pcpu_lstats *pcpu_lstats, *lb_stats;
>  =

> -	skb_orphan(skb);
> -
>  	skb->protocol =3D eth_type_trans(skb,dev);
>  =

>  	/* it's OK to use per_cpu_ptr() because BHs are off */
> diff --git a/drivers/net/mlx4/en_tx.c b/drivers/net/mlx4/en_tx.c
> --- a/drivers/net/mlx4/en_tx.c
> +++ b/drivers/net/mlx4/en_tx.c
> @@ -807,10 +807,6 @@ int mlx4_en_xmit(struct sk_buff *skb, st
>  	if (tx_desc =3D=3D (struct mlx4_en_tx_desc *) ring->bounce_buf)
>  		tx_desc =3D mlx4_en_bounce_to_desc(priv, ring, index, desc_size);
>  =

> -	/* Run destructor before passing skb to HW */
> -	if (likely(!skb_shared(skb)))
> -		skb_orphan(skb);
> -
>  	/* Ensure new descirptor hits memory
>  	 * before setting ownership of this descriptor to HW */
>  	wmb();
> diff --git a/drivers/net/niu.c b/drivers/net/niu.c
> --- a/drivers/net/niu.c
> +++ b/drivers/net/niu.c
> @@ -6667,8 +6667,7 @@ static int niu_start_xmit(struct sk_buff
>  		}
>  		kfree_skb(skb);
>  		skb =3D skb_new;
> -	} else
> -		skb_orphan(skb);
> +	}
>  =

>  	align =3D ((unsigned long) skb->data & (16 - 1));
>  	headroom =3D align + sizeof(struct tx_pkt_hdr);
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -155,8 +155,6 @@ static int veth_xmit(struct sk_buff *skb
>  	struct veth_net_stats *stats, *rcv_stats;
>  	int length, cpu;
>  =

> -	skb_orphan(skb);
> -
>  	priv =3D netdev_priv(dev);
>  	rcv =3D priv->peer;
>  	rcv_priv =3D netdev_priv(rcv);
> diff --git a/drivers/net/wireless/libertas/tx.c =

> b/drivers/net/wireless/libertas/tx.c
> --- a/drivers/net/wireless/libertas/tx.c
> +++ b/drivers/net/wireless/libertas/tx.c
> @@ -154,9 +154,6 @@ int lbs_hard_start_xmit(struct sk_buff *
>  	if (priv->monitormode) {
>  		/* Keep the skb to echo it back once Tx feedback is
>  		   received from FW */
> -		skb_orphan(skb);
> -
> -		/* Keep the skb around for when we get feedback */
>  		priv->currenttxskb =3D skb;
>  	} else {
>   free:
> diff --git a/net/core/dev.c b/net/core/dev.c
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -1677,6 +1677,10 @@ int dev_hard_start_xmit(struct sk_buff *
>  	const struct net_device_ops *ops =3D dev->netdev_ops;
>  	int rc;
>  =

> +	/* Call destructor here.  It's SMP-cache-friendly and avoids issues
> +	 * with drivers which can hold transmitted skbs for long times */
> +	skb_orphan(skb);
> +
>  	if (likely(!skb->next)) {
>  		if (!list_empty(&ptype_all))
>  			dev_queue_xmit_nit(skb, dev);
> @@ -1688,22 +1692,7 @@ int dev_hard_start_xmit(struct sk_buff *
>  				goto gso;
>  		}
>  =

> -		rc =3D ops->ndo_start_xmit(skb, dev);
> -		/*
> -		 * TODO: if skb_orphan() was called by
> -		 * dev->hard_start_xmit() (for example, the unmodified
> -		 * igb driver does that; bnx2 doesn't), then
> -		 * skb_tx_software_timestamp() will be unable to send
> -		 * back the time stamp.
> -		 *
> -		 * How can this be prevented? Always create another
> -		 * reference to the socket before calling
> -		 * dev->hard_start_xmit()? Prevent that skb_orphan()
> -		 * does anything in dev->hard_start_xmit() by clearing
> -		 * the skb destructor before the call and restoring it
> -		 * afterwards, then doing the skb_orphan() ourselves?
> -		 */
> -		return rc;
> +		return ops->ndo_start_xmit(skb, dev);
>  	}
>  =

>  gso:
> =

> =
