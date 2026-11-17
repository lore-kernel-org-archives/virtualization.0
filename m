Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953831;
	b=0Ws0xBA5bAaf2UypqJ1Jq15Z6FHLDP2YwgPmhVjlNgFZ21Y2hIWFhYAfyGYH6BI4l0s7
	 K8wF0ZfgpBSb3JCMkuB5Tw47QbbLHOKL7WXTy4G5tZaFMLdZN9bwVmBmVBI6cDp1B9L1z
	 j2pegGw/ogZLkvofeo/nj7qIHFDu0FsKxkzK0GOYZ0Ezw+ebc1qYoM+CwbKX4UZhqWSAG
	 8ZjkuK5OiqGOqSnheAxB8p8UR2xeiN4/lRqcvOWy9ZIq5vBnm202YYtKdZwKrQjkRTxo7
	 s0yHD2sUzzJqcu+hHKLkM5KpG22JVZvGhcZpFI2MaFKI9+l0Dz9htE5RLJZSLj6h08Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953831;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xHRE9E4kUeSUu0ldu7480MyA58NVe2YNRMOD410PWX4=;
	b=1HnPguYsGRuopeDB/acZX0chit9sD+fD/1LRoqhhT8Hy6wSuC9E425Xx9BjzuqI3EUfw
	 nfAQudeKAqqRNChjza7xA+36VdDanbdWElj63H7oCCKuikEgbxwP7mPJvpL0/A1pBkHBH
	 4cBssHeGi3KbgSmXRvV1vrVXOCD9VKkL1x07K3U5yq/QXneiUAZzkAwiyemzW5u0OlRLn
	 KRZ1SES42r0T8P0LC+1dp8Gik1aOaaLVf8mbu1bTzrPy2dhSI6uSvnaA5VT/shBn0wGmu
	 Xvtyivu8MoIvOKvpIYy9GwOHmwJGjF41xoVIwbEpdAhPGIp09pxILVLZ/fvz06gE1zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MkW+Hfmw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61F8606A31C;
	Tue, 17 Nov 2026 22:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MkW+Hfmw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301521F000C4;
	Tue, 17 Nov 2026 22:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794953830;
	bh=xHRE9E4kUeSUu0ldu7480MyA58NVe2YNRMOD410PWX4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MkW+Hfmw8cY74j5E/DqHDCuAFVp4xdsJqjkPbrIyzZwZY6/y10nwSmJS47bbAxkly
	 ZgeQj5IT8L3Lbhrx3To10mI4wbac3C2ssli0FBo8Vwqdxifwg0XUcJ2Zlk09HZGHVu
	 NoEWeQRENreIXCk7PYvNbYUEaO/ebtP4nEcNrIZk5nRwTTPuqreG9KjS/w6v1MuVbD
	 0O1aylWY9nmCW+UlUsRWNBFe3f8WjkgUe3Um8RiCjSNQtH2uGSOKTS/H7lsXeQQecH
	 NYa90NVH3iHH/1kUDUFz8gNAyimQfDzHO3CUpubQmtuOd/uYHxy6ZKlZC6NPkiyHr4
	 AOiG9LrCWqsSw==
Subject: Re: [PATCH net v6 1/2] tun: bound the NAPI receive queue
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
Date: Tue, 17 Nov 2026 22:17:08 +0000
Message-ID: <179495382870.3136.12445611217339402319@kernel.org>
In-Reply-To: <20261113212237.1742984-2-antonio@mandelbit.com>
References: <20261113212237.1742984-2-antonio@mandelbit.com>
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

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new bound does not close the OOM it is meant to fix.
- [Medium] The queue-full drop is checked before the code decides whether
  the packet will be queued at all, so it also drops traffic that never…
- [Low] The new comment in tun_napi_receive() (drivers/net/tun.c:251-253)
  says the poll takes 'at most budget skbs, so that the queue never…

--

tun: bound the NAPI receive queue

This patch puts a limit on the IFF_NAPI sk_write_queue in tun. Once more
than netdev_max_backlog packets are queued, tun_get_user() and
tun_xdp_one() drop new packets and schedule NAPI. The poll now takes at
most budget skbs at a time, instead of splicing out the whole queue.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 86fd44e107550..73f13684722ea 100644
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

Does this limit prevent the global OOM described in the commit message?
The only limit is a per-tfile packet count against the global
net_hotdata.max_backlog. The queued skbs are still not charged to the
writer's memcg.

An unprivileged user in its own user and network namespace can multiply
this cap. tun_set_iff() only needs CAP_NET_ADMIN in the user namespace to
create a multi-queue device:

drivers/net/tun.c:tun_set_iff() {
    ...
		int queues = ifr->ifr_flags & IFF_MULTI_QUEUE ?
			     MAX_TAP_QUEUES : 1;

		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
			return -EPERM;
    ...
}

That allows up to 256 queues per device, plus more devices and more
namespaces. netdev_max_backlog itself can only be changed from init_net.

Each queue can hold about max_backlog + budget + one skb per concurrent
writer. The reproducer sends 1400-byte TUN packets, with a truesize of
about 2.3 KB. That works out to about 2.3 MB per queue and about 600 MB
for one 256-queue device. A few such devices would reach several GB of
uncharged memory, whatever the memcg limit is.

The commit message says:

  "This is hard to reach in practice: with large packets the writer's
  copy is slower than the NAPI poll, so the queue does not fill."

That covers large packets on a single queue. Does it also cover small
packets spread over many queues, which is the reproducer's own traffic
pattern?

The writer also controls the per-packet poll cost through the number of
iptables rules. So larger packets can fill each queue too, at about
64 MB per queue with 64 KB packets.

Would this need byte or memcg accounting of the queued skbs, or a
per-owner limit, instead of a per-queue packet count?

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
> +	spin_lock(&queue->lock);
> -	skb_queue_splice_tail_init(queue, &process_queue);
> +	if (skb_queue_len(queue) <= budget) {
> +		skb_queue_splice_tail_init(queue, &process_queue);
> +	} else {
> +		while (skb_queue_len(&process_queue) < budget &&
> +		       (skb = __skb_dequeue(queue)))
> +			__skb_queue_tail(&process_queue, skb);
> +	}
>  	spin_unlock(&queue->lock);

[Severity: Low]

This isn't a bug, but is this comment accurate? The poll still moves up
to budget skbs from sk_write_queue into the local process_queue. It then
drops the lock and calls napi_gro_receive() on them.

tun_napi_queue_full() only reads the qlen of sk_write_queue. So while
the poll runs, writers can see a queue up to budget skbs shorter than
the real backlog.

Would "at most budget emptier" be a better description? The effective
limit would then be about max_backlog + budget + one skb per concurrent
writer.

[ ... ]

> @@ -1862,6 +1876,20 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  			zerocopy = true;
>  	}
>  
> +	/* NAPI queue full: drop before allocating, and schedule NAPI, which a
> +	 * MSG_MORE sender may not have done yet. Lockless: concurrent writers
> +	 * can each still add one.
> +	 */
> +	if (tfile->napi_enabled &&
> +	    unlikely(tun_napi_queue_full(&tfile->sk.sk_write_queue))) {
> +		local_bh_disable();
> +		napi_schedule(&tfile->napi);
> +		local_bh_enable();
> +		net_zcopy_put(msg_control);
> +		dev_core_stats_rx_dropped_inc(tun->dev);
> +		return total_len;
> +	}
> +
>  	if (!frags && tun_can_build_skb(tun, tfile, len, noblock, zerocopy)) {

[ ... ]

> @@ -2568,6 +2596,17 @@ static int tun_xdp_one(struct tun_struct *tun,
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

[Severity: Medium]

Could these checks drop traffic that would never be queued on
sk_write_queue?

In tun_xdp_one() the check runs before the attached XDP program. Frames
the program would XDP_REDIRECT or XDP_TX return early and never reach
__skb_queue_tail(). They are now dropped and counted as rx_dropped
whenever the NAPI queue is over the limit.

The check in tun_get_user() runs before tun_build_skb(). That is where
native XDP runs for the TAP build_skb path, and non-PASS verdicts return
there without building or queueing an skb:

drivers/net/tun.c:tun_build_skb() {
    ...
		if (err == XDP_REDIRECT)
			xdp_do_flush();
		if (err != XDP_PASS)
			goto out;
    ...
}

It also runs before the generic do_xdp_generic() call.

With IFF_NAPI_FRAGS, tun_get_user() passes the skb directly to
napi_gro_frags() and never touches sk_write_queue. The check is gated
only on tfile->napi_enabled, which is also set in frags mode.

tun_xdp_one() still queues into sk_write_queue whenever napi_enabled is
set. So small packets batched by vhost-net can fill the queue, and then
the larger packets that go through tun_get_user() and the frags path are
dropped as well.

Take a vhost-net/XDP setup where most traffic is redirected and only
some goes to the local stack. Would the redirected traffic start
dropping as soon as the local stack path backs up?

The commit message says this works "like enqueue_to_backlog()", but
enqueue_to_backlog() only drops skbs it would actually enqueue. Could
the check move to the places where the skb is actually queued? If not,
could the commit message mention this side effect?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113212237.1742984-1-antonio%40mandelbit.com
