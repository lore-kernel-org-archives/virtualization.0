Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795304244;
	b=PpmguAqeVFFiYT5XPOWxfpTe7HgRZpoJUWRGDyF8XXvhG/ZnWVXYrU9cX+k/FXEdOuvU
	 aj9bCMpeOWQVOD98Re8c/w7eu5OXzYDvPKv8KvHnsYHi0iUhwlabN87ykJPhL2QHv4lGZ
	 1KbOSaiXQtT35coQpR1zbAr3gCtwemyrjz7LGNj5lPSYxtf3rBf/yifDCUP3LBpXx5Ind
	 7/6AQZXsXWVJTB63JazJTaIfr8cChstmU0kA133qKyVxPdyXyHyWZGzWv1tHJwmi56jrJ
	 Qfj3IxYrcEPAiaRXlVopx2Xnaa2KG7IVIAsPDg32f1a2hFSVjC79OAAaI1L6EEBvsrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795304244;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4KPjgcwe8LG/IWwYnJ9R321g+N2W83kSLrvRS4eTumE=;
	b=B/ZGA8TVqZVrqGSliT6409/V1J/O5S9SnVySq79CJO8HNpBnSsYk13YnWOEbV3mroRPf
	 +qZyF35O4gJNr4oASe7pYtrQssz9vjo8garNuneNhZG7R4uVC4iaWe4OX1ALsVTkrhA6Y
	 NSsZQOWBG1Bg3lffEZWBM78KAVDfcRv1uVJr1LBOEd2M8zeGfgdwrWSDJRCVHdVxfrcXh
	 SQ+A5IGhpOaXOgG1ZmK5UV6JpZVf6V1SAlqa5QtoNJtHXusZGgHQVRGdd1gsyf0fLNVOW
	 jkJuCV0ZmS4qUfWiENz94yK2ioeePLzHY4Kc6W5DDPDr9G5169CAbSNCGMMY4djU1Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIHFr5AC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0E7606A320;
	Sat, 21 Nov 2026 23:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UIHFr5AC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D120F1F000C0;
	Sat, 21 Nov 2026 23:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795304244;
	bh=4KPjgcwe8LG/IWwYnJ9R321g+N2W83kSLrvRS4eTumE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UIHFr5AC4HfoRTZvYJgLLAXJkU+5szVCiBbgx9r4K+94+Ds+B7yjso9fJ6UxO9NEr
	 i5E2H7b/vZ1qERmmoa2esSnQLSm9XliE1WV6fGDRyvy6hzITvZxlT8AsyjJQXPmc/a
	 ZJx7+Eama47+yuYIMr55ujcUBhgADMCMspwjvc+DsKoccgSTuuliBQH5IigyvvFSyP
	 fOBupnfZfSSAVhdYk3lz/hjOu4fShjlZwLjJfRDk9iUPQcyJkIqI1xqAuxfd3W5QSf
	 d6BPPlDUMUaWFgzb9j86AgUgrQZ3a0Z4in29ek7BKLimqDv2FuVA2OwlS4J6ZkJn1N
	 48y3O526nAozA==
Subject: Re: [PATCH net v7] tun: bound the NAPI receive queue
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
 eperezma@redhat.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, maheshb@google.com,
 peterpenkov96@gmail.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, bpf@vger.kernel.org
Date: Sat, 21 Nov 2026 23:37:22 +0000
Message-ID: <179530424233.3135.6226986969775563090@kernel.org>
In-Reply-To: <20261119153056.353156-1-antonio@mandelbit.com>
References: <20261119153056.353156-1-antonio@mandelbit.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Bounding the IFF_NAPI queue by packet count only
  (net_hotdata.max_backlog skbs per tun_file, ignoring size) does not…
- [Medium] The patch silently changes behaviour for IFF_NAPI users who
  set a finite send buffer with TUNSETSNDBUF, and the commit message…

--

tun: bound the NAPI receive queue

This patch caps the IFF_NAPI sk_write_queue of each tun_file at
net_hotdata.max_backlog packets. Excess packets are dropped and counted as
rx_dropped in tun_get_user() and tun_xdp_one(). It also changes
tun_napi_receive() to take at most budget skbs from the queue, so the rest
stays visible to writers.

> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 86fd44e107550..b7432bd4d3f03 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c

[ ... ]

> @@ -227,6 +228,16 @@ struct veth {
>  static void tun_flow_init(struct tun_struct *tun);
>  static void tun_flow_uninit(struct tun_struct *tun);
>  
> +/* In IFF_NAPI mode written packets wait in the tfile's sk_write_queue for the
> + * NAPI poll, which may run later in a kthread or ksoftirqd. Bound that queue
> + * like the per-CPU backlog.
> + */
> +static bool tun_napi_queue_full(const struct sk_buff_head *queue)
> +{
> +	return skb_queue_len_lockless(queue) >
> +	       READ_ONCE(net_hotdata.max_backlog);
> +}

[Severity: High]
Is a packet count limit in tun_napi_queue_full() enough to prevent the
global OOM described in the commit message?

tun_get_user() takes total_len = iov_iter_count(from) with no upper bound.
tun_alloc_skb() can then build an skb with up to ~544 KB of frags plus a
linear remainder:

drivers/net/tun.c:tun_alloc_skb() {
    ...
	if (len - linear > MAX_SKB_FRAGS * (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
		linear = len - MAX_SKB_FRAGS * (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER);
	skb = sock_alloc_send_pskb(sk, prepad + linear, len - linear, noblock,
				   &err, PAGE_ALLOC_COSTLY_ORDER);
    ...
}

tun_chr_open() sets sk_sndbuf to INT_MAX by default. With that, a single
tun_file can still hold about max_backlog * truesize. That is tens of MB
with 64 KB writes, and much more with multi-MB writes.

The limit is also per tun_file. With IFF_MULTI_QUEUE, tun_set_iff() allows
MAX_TAP_QUEUES (256) queues per device. The only gate is ns_capable() in
the user's own namespace:

	int queues = ifr->ifr_flags & IFF_MULTI_QUEUE ?
		     MAX_TAP_QUEUES : 1;

Even with 1400-byte packets that is roughly 256 * 1000 * ~2.3 KB, or about
590 MB per device. A namespace can also create several devices.

The commit message lists this under "Still open". Even so, the same uid
1000 process limited to a 128 MB memcg looks able to reach a global OOM
with larger writes, more queues or more devices.

Would this need a truesize based limit, or charging the queued skbs to the
writer's memcg, to close the reported DoS?

[ ... ]

> @@ -2043,6 +2055,19 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>  		struct sk_buff_head *queue = &tfile->sk.sk_write_queue;
>  		int queue_len;
>  
> +		/* Queue full: drop, and schedule NAPI, which a MSG_MORE sender
> +		 * may not have done yet. Lockless: concurrent writers can each
> +		 * still add one.
> +		 */
> +		if (unlikely(tun_napi_queue_full(queue))) {
> +			local_bh_disable();
> +			napi_schedule(&tfile->napi);
> +			local_bh_enable();
> +			rcu_read_unlock();
> +			drop_reason = SKB_DROP_REASON_FULL_RING;
> +			goto drop;
> +		}

[Severity: Medium]
Is this behaviour change intended for IFF_NAPI users who set a finite send
buffer with TUNSETSNDBUF?

With a finite sk_sndbuf, tun_can_build_skb() refuses the build_skb path:

	if (tfile->socket.sk->sk_sndbuf != INT_MAX)
		return false;

So every write goes through tun_alloc_skb()->sock_alloc_send_pskb(), which
charges sk_wmem_alloc.

Before this patch, skbs on sk_write_queue kept their wmem charge until the
NAPI poll consumed them. A slow poll made a blocking writer sleep in
sock_alloc_send_pskb(), and gave a non-blocking writer or vhost-net
-EAGAIN.

After this patch, this branch fires first once sndbuf is larger than about
max_backlog * truesize. That is about 2.3 MB for 1400-byte packets with the
default max_backlog of 1000. The skb is freed, which releases its wmem, and
tun_get_user() returns total_len.

The writer then never blocks and never gets -EAGAIN. Lossless backpressure
that the user configured becomes silent packet loss. The commit message
only mentions sndbuf as being INT_MAX by default.

Could this be documented? Or could a full queue block or return -EAGAIN for
writers on the charged path? Exempting finite-sndbuf queues alone would not
be enough, since the same user could set sndbuf to INT_MAX - 1 to get
around the cap.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119153056.353156-1-antonio%40mandelbit.com
