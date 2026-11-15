Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794728577;
	b=AG7ELtfXGb/4mduRseYk78Lj60dzEW5u+QhR7Ga+rrnoJmitHd4OFk3jvTtK2K97DEgJ
	 BfTuaHTsYIsslsu7ZqvcR596UwFKlz7c5XNLLaz+8q0ksjskqFOoZIyLYeCzksv68pNJu
	 DVDbsjN55v74i6ECCQkcApcE8nRCnnUthR20ce+JfsMmIr3A6Gae0kzCS6tVARuFdhRK1
	 0hzarw6lmoLNR6tXy/AuySdt2/0tAKNnwFEmbmGZicIpVkh06jFeG4T0ad8uQrjToZiQD
	 us7eMQyNgG6M9LIYFyKLxSgZT51LA8d1asQzcTXPj4+d4taSWwqPDuUoTEzHvf3hudQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794728577;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GPVorwWextWqTeqhLKlgJWaB2HerQm/MmIfhM1PDl2w=;
	b=fWLRDBTizf14awtzL/Eop6M0KMkMFmjENe8oYbTD016RqdrWrSYKoa68z1KZkx+kuMlp
	 4gEPmUpROyrRrA4X1Cf5wyqRNAlG4X9rsib2kT0fshB78kZ73qoVuMgasVixdkTQNHU96
	 2qQIJYUa2eiB7TiqIos/7Q17wJECWgAgLGKI2Lq88MXwPUK0jB3GtZKgefaYEQWuMQdsm
	 Fts1bO7Tx/DKIfkyhEonrHhVkVxPD24TY7dO/F7Tvv7ccmD8UKoMShN4VS+TBtsN1njka
	 QlVyzld5k3J8gFlopjODrdf9YGa2CKcsBsyb9elV90LbItB1uyfgGnOI6O5JMW3Ogfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KA9hFhdc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B5E606A31A;
	Sun, 15 Nov 2026 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KA9hFhdc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5371A1F000C4;
	Sun, 15 Nov 2026 07:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794728577;
	bh=GPVorwWextWqTeqhLKlgJWaB2HerQm/MmIfhM1PDl2w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KA9hFhdck9Pu0lR2PrmhwtsDEAvpYWSx2ULFs9xe8v42JnsLvlTL9VTH1YD/0KQzI
	 ejzUQnKFBhTpv5vIhRvfiNJ9gw9oB1RbSmj0/PiJNo96TBXhWcyd1S9v+VjtdEoROI
	 tV9z87/AmMV0mu4Oh1b1WfE9BNi7icrFg3Lik9P2pgTigu09OWkEUb1cWrt4qP0TN1
	 fBAm2VusjA6VVhBK1yKmGJ/ugo58sBzS7eTruLD6k8kqWoC617h0FxWiPmrbAJ08Ry
	 7/EkBoBNjj6wqNa5V6u8WYH9UGKp0dnNoDnZbRHY9whoItb6Vq/B4VjtKFkXQDK3Ho
	 GX/F/bWX8u1zg==
Subject: Re: [PATCH net v5 1/2] tun: bound the NAPI receive queue
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
 eperezma@redhat.com, shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 maheshb@google.com, peterpenkov96@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org
Date: Sun, 15 Nov 2026 07:42:55 +0000
Message-ID: <179472857592.2199510.16416804582528441222@kernel.org>
In-Reply-To: <20261111014208.1795777-2-antonio@mandelbit.com>
References: <20261111014208.1795777-2-antonio@mandelbit.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new bound is a packet count on each tun_file's
  sk_write_queue, compared against net_hotdata.max_backlog (default…
- [Low] The new full-queue check runs before every XDP hook, in both
  paths the patch changes.
- [Low] The new comment in tun_napi_receive() says it takes "at most
  budget skbs, so that the queue never looks emptier to writers than it…

--

tun: bound the NAPI receive queue

In IFF_NAPI mode, this patch drops new packets in tun_get_user() and
tun_xdp_one() once the tfile's sk_write_queue holds more than
netdev_max_backlog packets, and counts them as rx_dropped. It also changes
tun_napi_receive() to take at most budget skbs from the queue instead of
splicing out the whole queue and putting the rest back.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 3b292bce4438c..e2fda570b90f6 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -227,6 +228,16 @@ struct veth {
>  static void tun_flow_init(struct tun_struct *tun);
>  static void tun_flow_uninit(struct tun_struct *tun);
>  
> +/* In IFF_NAPI mode written packets wait in the tfile's sk_write_queue for the
> + * NAPI poll, which may run later in a kthread or ksoftirqd. Bound that queue
> + * like the per-CPU backlog of netif_rx().
> + */
> +static bool tun_napi_queue_full(const struct sk_buff_head *queue)
> +{
> +	return skb_queue_len_lockless(queue) >
> +	       READ_ONCE(net_hotdata.max_backlog);
> +}

[Severity: High]
Does a per-queue packet count bound the uncharged memory that an
unprivileged user can pin?

This limit is about 1000 packets on one tfile's sk_write_queue. It has no
byte accounting and no limit across tfiles. The same user who can run the
reproducer can also open IFF_MULTI_QUEUE devices. tun_set_iff() only checks
CAP_NET_ADMIN in the user's own user namespace:

    int queues = ifr->ifr_flags & IFF_MULTI_QUEUE ?
                 MAX_TAP_QUEUES : 1;

    if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
        return -EPERM;

That gives up to 256 queues per device, and as many devices as
RLIMIT_NOFILE allows. Each tfile still has sk_sndbuf = INT_MAX from
tun_chr_open(), and its queued skbs are not charged to the writer's memcg.
The only admission check on the write path is this one in tun_get_user()
and tun_xdp_one().

The commit message says:

    Still open: the limit counts packets rather than bytes and applies per
    queue, so with large packets and many queues (IFF_MULTI_QUEUE works in a
    user namespace too) the queued skbs, which are not charged to the
    writer's memcg, can still add up to an OOM. This is hard to reach in
    practice: with large packets the writer's copy is slower than the NAPI
    poll, so the queue does not fill.

That argument covers large packets only. The reproducer itself shows
1400-byte writes outrunning threaded NAPI. All queues drain on the same
CPUs, so if the writer cycles small packets through every queue fd, can
each queue reach max_backlog?

With roughly 2.3 KB of truesize per 1400-byte skb, about 1000 tfiles (the
default soft RLIMIT_NOFILE) would pin around 2.3 GB, and a higher fd limit
pins more. Does that still allow the global OOM from a memcg-limited user
that this patch is meant to fix?

A bound that does not scale with the number of tfiles would close this.
Two options would be charging queued skb truesize to the socket or memcg on
every enqueue path, or a per-device or per-netns aggregate limit. Either
would replace the per-queue packet count.

> +
>  static int tun_napi_receive(struct napi_struct *napi, int budget)
>  {
>  	struct tun_file *tfile = container_of(napi, struct tun_file, napi);
> @@ -237,21 +248,24 @@ static int tun_napi_receive(struct napi_struct *napi, int budget)
>  
>  	__skb_queue_head_init(&process_queue);
>  
> +	/* Take at most budget skbs, so that the queue never looks emptier to
> +	 * writers than it is.
> +	 */
>  	spin_lock(&queue->lock);
> -	skb_queue_splice_tail_init(queue, &process_queue);
> +	if (skb_queue_len(queue) <= budget) {
> +		skb_queue_splice_tail_init(queue, &process_queue);
> +	} else {
> +		while (skb_queue_len(&process_queue) < budget &&
> +		       (skb = __skb_dequeue(queue)))
> +			__skb_queue_tail(&process_queue, skb);
> +	}
>  	spin_unlock(&queue->lock);
>  
> -	while (received < budget && (skb = __skb_dequeue(&process_queue))) {
> +	while ((skb = __skb_dequeue(&process_queue))) {
>  		napi_gro_receive(napi, skb);
>  		++received;
>  	}

[Severity: Low]
Is the "never looks emptier to writers than it is" part of this comment
accurate?

When skb_queue_len(queue) <= budget, skb_queue_splice_tail_init() resets
the queue's qlen to 0. Otherwise each __skb_dequeue() lowers qlen by one,
for up to budget skbs.

In both cases, while napi_gro_receive() works through process_queue,
possibly on another CPU with threaded NAPI, tun_napi_queue_full() sees up to
budget fewer pending skbs than are really pending. The real bound comes out
to about max_backlog + budget, plus one per concurrent lockless writer.

This is much better than hiding the whole backlog as before. Could the
comment say the queue looks emptier by at most budget, so later code does
not rely on a strict invariant?

[ ... ]

> @@ -2561,6 +2593,17 @@ static int tun_xdp_one(struct tun_struct *tun,
>  		return -EIO;
>  	}
>  
> +	/* NAPI queue full: drop, and schedule NAPI so that it drains even if
> +	 * nothing in this batch gets queued
> +	 */
> +	if (tfile->napi_enabled &&
> +	    unlikely(tun_napi_queue_full(&tfile->sk.sk_write_queue))) {
> +		napi_schedule(&tfile->napi);
> +		put_page(virt_to_head_page(xdp->data));
> +		dev_core_stats_rx_dropped_inc(tun->dev);
> +		return 0;
> +	}
> +
>  	xdp_prog = rcu_dereference(tun->xdp_prog);

[Severity: Low]
Should this check come after the XDP program runs?

Here it sits before rcu_dereference(tun->xdp_prog) and bpf_prog_run_xdp().
In tun_get_user() the new check also comes before tun_build_skb(), which
runs native XDP and returns NULL when the program consumes the packet, and
before do_xdp_generic().

Packets the program would REDIRECT, TX or DROP never reach sk_write_queue.
They add nothing to the queue being bounded.

Once XDP_PASS traffic fills the queue past netdev_max_backlog, those packets
are dropped without the program seeing them. They are also counted in
rx_dropped. Would redirected or XDP_TX flows on that tfile stall whenever
the stack path is congested?

The commit message only says packets are dropped "before allocating and
copying them". If this trade-off is intended, could the commit message
mention the effect on XDP?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111014208.1795777-1-antonio%40mandelbit.com
