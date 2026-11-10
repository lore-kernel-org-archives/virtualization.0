Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342065;
	b=xifPGjNLUiY6E4hNdki1oeQ0JotRxydhMVT64c7HusFAN72TtcxqllJSA65rDGKoVnST
	 Lcd+KXpbiJSEMk0jOt8P0MtSQZG0N1UEP8MnTeLF5OGaVl3ouzlofuItQcXGevZbAkFO/
	 AQODG001J5qzMPE/Ug0fpqrq9aFKR4J8bcD2yFQiwhqI/p4V5cpGwTmYLDBp02gjUevtp
	 iVKBT7K+BIOUnwTl7JEsLTmD7xXVum7aW6mJSfKIF7WTVaabqDPkoRy9sKVLB/4kyst9I
	 8570z70o2FEbbqnzYBnw6OdGDJ88KoII1CtLhkaUaa583tZJ1AlB94yOSToR7WcaHcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342065;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SqlNj59/LD+cFzFuhr/JaZoZfxJCEUwbIyR9YZXCuJ0=;
	b=RZwh7mlFoYxrSjM8lZsKnqgzhQjPFSwO19F4rDT/ulHApHv/sZoc3kon5McN0Wiv24kn
	 JmHJXB2Q5lyvVV5ahf/+lM5Z1kjxDhFR6bD57/hZeZQQYEAA4x9sbzicfsN837tz5BWMs
	 uOe5lod/lAn+MnYtX7vvWHaKqf5A6LTVtVmhJ+gemVN55LOr1djy2rEfT5Yn9h3Iw+ZP9
	 9IQIklTenRd61kBrvNtlCbVp0+mTd8ABw2aDeDbrF9+o9Q6LK98TJ1UtXzBlQPQk48bUr
	 Bfu7wpOykB/iZNyuaQ49PU1zXYU4lBoaHzkm90bsdiEejosUSxhCmBFwekkSNoezHuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LY6GHo+T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D687760A3802;
	Tue, 10 Nov 2026 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LY6GHo+T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72211F0089F;
	Tue, 10 Nov 2026 20:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794342064;
	bh=SqlNj59/LD+cFzFuhr/JaZoZfxJCEUwbIyR9YZXCuJ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LY6GHo+TTyy4EaUbKkkEqL30SLaeTagmoGq7Vz/eqnVrwsKvxPQBFKCd1CvqJvX7R
	 PEByaU+7NdJENMktrMuuziii/ffTBxNDMITiCpHCNs4Z33mJqcg/XK6bhQH787vVHj
	 RxpBh2Jj72m8YOgkLu7X+M1RRkWGJbFUIZny01hKvbd2Q2ci2c0DdjcMmCZ/aT0hDS
	 7622TdbaerEx4ucj8KrLmZaESwurPxTiCmCrlPCXUgXv12+utBTQvTaOYW3x8lkLXC
	 MAA1Vb/6CgaAR4Pu0Yz6LiIMEnEsYcAGx0RKU3K6JOmqu1Vrjurp9bsntaylSIfDQE
	 vW+NEn6UND2Cw==
Subject: Re: [PATCH net] virtio_net: skip Rx refill when polled by netpoll
From: netdev-bot+sashiko@kernel.org
To: leitao@debian.org
Cc: mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com,
 xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, vishs@meta.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Date: Tue, 10 Nov 2026 20:21:03 +0000
Message-ID: <179434206326.994134.11181781434786471969@kernel.org>
In-Reply-To: <20261109-virtio-net-netpoll-pp-v1-1-3f004b406d71@debian.org>
References: <20261109-virtio-net-netpoll-pp-v1-1-3f004b406d71@debian.org>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch is incomplete: zero-budget netpoll polling can still
  call page pool APIs, which the commit message itself says must not…
- [Low] The commit message calls the root cause 'the theory' and
  describes two reproducers: a netconsole printk flood that corrupts TCP…

--

virtio_net: skip Rx refill when polled by netpoll

This commit makes virtnet_poll() return right after Tx reclaim when it is
called with a zero budget, which is how netpoll calls it. The goal is to
keep the Rx refill path from allocating from the page pool outside a real
NAPI poll. It targets pp_ref_count underflows and skb corruption seen with
heavy netconsole traffic since page_pool support was added.

> A reproducer on the net tree supports the theory: an 8-CPU arm64 VM with
> QEMU user networking, a netconsole target on the virtio_net device and
> three TCP receivers on other CPUs checking a known byte pattern. A
> printk flood through netconsole corrupted all three streams within about
> three minutes, after which recvmsg() failed with -EFAULT and the same
> warning fired. A test kthread calling netpoll_poll_dev() in a loop, as
> __netpoll_send_skb() does while the Tx queue is busy, corrupts the
> streams within seconds.
>
> Only reclaim Tx when the budget is zero

[Severity: Low]
This isn't a bug, but the message calls the root cause a theory and
describes two reproducers. It never says whether they stop failing with
this patch applied.

Could the message say whether the pp_ref_count underflow, the
napi_consume_skb() faults and the stream corruption no longer reproduce
with this change?

Also, the last sentence "Only reclaim Tx when the budget is zero" is
missing a trailing period.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index dd2c41ef6fbe7..9db5ec875c141 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3037,6 +3037,9 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>  
>  	virtnet_poll_cleantx(rq, budget);
>  
> +	if (unlikely(!budget))
> +		return 0;
> +

[Severity: High]
Does this keep all page pool calls out of the zero-budget path? The early
return comes after virtnet_poll_cleantx(rq, budget), and that still runs
when netpoll calls virtnet_poll() with budget == 0.

When XDP falls back to the shared, locked Tx mode, virtnet_xdp_set() does:

	if (curr_qp + xdp_qp > vi->max_queue_pairs) {
		...
		xdp_qp = 0;
	}

In that mode is_xdp_raw_buffer_queue() is false for every queue. XDP_TX and
redirected frames then land on the same sq that virtnet_poll_cleantx()
reclaims.

The XDP case in __free_old_xmit() does not look at in_napi:

		case VIRTNET_XMIT_TYPE_XDP:
			frame = ptr;
			...
			xdp_return_frame(frame);
			break;

Since 24fbd3967f3f the rxq is registered as MEM_TYPE_PAGE_POOL, so the
call chain becomes:

poll_napi()->poll_one_napi()->virtnet_poll(napi, 0)
  virtnet_poll_cleantx(rq, 0)
    free_old_xmit(sq, txq, false)
      __free_old_xmit()
        xdp_return_frame()
          page_pool_put_unrefed_netmem()

In the usual netconsole case, netpoll runs in process context with IRQs
disabled by __netpoll_send_skb(). page_pool_napi_local() returns false
there. The page then goes through page_pool_recycle_in_ring() and
page_pool_producer_lock(), which call spin_lock_bh() and spin_unlock_bh()
with IRQs off.

Won't that trip lockdep_assert_irqs_enabled() in __local_bh_enable_ip()?

If a softirq is pending, softirqs would also run nested inside netpoll
with IRQs re-enabled. For example, virtnet_tx_wake_queue() on an earlier
queue in the same poll_napi() loop raises NET_TX_SOFTIRQ.

At that point netpoll holds napi->poll_owner and the sq txq lock. Could a
nested napi_poll() of the same rq spin forever in netpoll_poll_lock()?
Could a nested XDP_TX to the same txq spin in __netif_tx_lock()?

Netpoll can also run from a hardirq that interrupted net_rx_action() on
the CPU that owns the source rq's NAPI. For netconsole this happens during
panic. In that case page_pool_napi_local() returns true. The frame is then
pushed into the lockless pool->alloc.cache while the interrupted NAPI may
be using it.

Isn't that the same alloc-cache and pp_ref_count corruption this patch is
trying to fix?

Documentation/networking/napi.rst, which the commit message cites, says no
XDP or page pool APIs may be called when the budget is 0. Should
VIRTNET_XMIT_TYPE_XDP reclaim also be skipped or deferred when budget is 0?

>  	received = virtnet_receive(rq, budget, &xdp_xmit);
>  	rq->packets_in_napi += received;
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109-virtio-net-netpoll-pp-v1-1-3f004b406d71%40debian.org
