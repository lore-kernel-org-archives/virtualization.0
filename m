Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B753939DB;
	Mon,  7 Sep 2026 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813069; cv=none; b=aAKWydf3fSXBr+Z0dDCa53yWGNc4ZOeP8LtFrWGRq1xu4jJgU7mbRxS7jOVzAWikdH751YDh1/T1i9gKK6pMVIShYkP5BSAykj4+lj6B3Wz6M79hEK9vAQvmTsboE1wunduuZjVz4rRlYhH8PLfuqz5EOB/XdazOJZMjrheWRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813069; c=relaxed/simple;
	bh=n7i+VL7GgBNh4qhKakjQh12aQxUeEhkMiFlbOYgl9/c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mSUMnF7nu5b35znvhrXFRN4VEpwhNeILE/4OT3eZIWH6tSnimMJ1nWvwgsT9mSE25YN3MWHBrRyEHIAHSJfnNbmPoIxE0Uf0DEnR/ANF1LTTycN+S5rhhzYreebXKU5gmc9nLDs5HDJww6BXx89Ndz7ET0jDXxb5btoSI7LJksk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUigDi5w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUigDi5w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760BF1F00A3A;
	Mon,  7 Sep 2026 20:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788813067;
	bh=XgcYpYYEYojaeshBSjApD5s66yJaOO15EjtpJM1avds=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KUigDi5wBlWrgc5OY8drk5/N6Q2/8YkNJRXFkT2MSWzBSaFwmaxWYtbAPcdCgj3t5
	 JuZKnq08I7aVd5LxsVcaDnM/CcToMXC7uf+sYbfQj+ir9QVHj0qVa0gVIBiNZ5vHOx
	 zrXp0X6JhafByjHoexFssXSp34HaxQLREE7tRpTSLO8vuD6Gs9mGu8DMSDYDs958f1
	 aDQFwyhuPNbiWKE5dl2lPbsZFnnuzMssgSikEdl9f8/95wBSt12Uj3bTeokqVKNsnW
	 UCGr4PLbdxa735OMXGKCI6EWf7S5sjHPB/D4Jw5jM+HgMzrxa7OdL9dqzocep2KJVG
	 fEFz5dv1KIU0g==
Subject: Re: [PATCH v3] virtio_net: add rx-alloc-fail counter
From: netdev-bot+sashiko@kernel.org
To: lange_tang@163.com
Cc: kuba@kernel.org, mst@redhat.com, jasowangio@gmail.com,
 xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, tanglongjun@kylinos.cn
Date: Mon, 07 Sep 2026 20:31:07 +0000
Message-ID: <178881306701.219967.4783663587645828820@kernel.org>
In-Reply-To: <20260903022848.33595-1-lange_tang@163.com>
References: <20260903022848.33595-1-lange_tang@163.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

- [Medium] The patch advertises the standardized `rx-alloc-fail` qstat
  for every RX queue (`virtnet_rq_stats_desc_qstat[]` at…

Pre-existing issues:
- [Medium] The netdev qstats callbacks `virtnet_get_queue_stats_rx()` /
  `virtnet_get_queue_stats_tx()` (drivers/net/virtio_net.c:5648-5672)…

--

virtio_net: add rx-alloc-fail counter

This adds a per-receive-queue alloc_fail counter to struct
virtnet_rq_stats, increments it on skb allocation failures in the
receive_small/receive_big/receive_mergeable paths and on try_fill_recv()
returning failure from virtnet_receive(), and exports it through the
rx-alloc-fail qstat including virtnet_get_base_stats().

A couple of questions below about the coverage of the new counter and
about how it is read back.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e34c52d059d3..360cc3435e90 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -173,8 +174,9 @@ static const struct virtnet_stat_desc virtnet_sq_stats_desc_qstat[] = {
>  };
>  
>  static const struct virtnet_stat_desc virtnet_rq_stats_desc_qstat[] = {
> -	VIRTNET_RQ_STAT_QSTAT("packets", packets),
> -	VIRTNET_RQ_STAT_QSTAT("bytes",   bytes),
> +	VIRTNET_RQ_STAT_QSTAT("packets",    packets),
> +	VIRTNET_RQ_STAT_QSTAT("bytes",      bytes),
> +	VIRTNET_RQ_STAT_QSTAT("alloc_fail", alloc_fail),
>  };

[Severity: Medium]
This descriptor is used by virtnet_fill_stats_qstat() for every RX queue,
so rx-alloc-fail becomes an always-present value for all queue types,
including XSK-bound ones. Documentation/netlink/specs/netdev.yaml defines
it as "Number of times skb or buffer allocation failed on the Rx
datapath". Can the counter read 0 while the driver is in fact dropping
frames because allocations failed?

The AF_XDP receive path performs the same kind of skb and fragment
allocations that this patch now counts, but is not instrumented:

drivers/net/virtio_net.c:xsk_construct_skb() {
	skb = napi_alloc_skb(&rq->napi, size);
	if (unlikely(!skb)) {
		xsk_buff_free(xdp);
		return NULL;
	}
	...
}

drivers/net/virtio_net.c:xsk_append_merge_buffer() {
	...
		buf = napi_alloc_frag(len);
		if (!buf) {
			xsk_buff_free(xdp);
			goto err;
		}
	...
		if (!curr_skb) {
			put_page(page);
			goto err;
		}
	...
}

The XDP copy paths also turn RX buffer allocation failures into
xdp_drops/drops only:

drivers/net/virtio_net.c:xdp_linearize_page() {
	page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
	if (!page)
		return NULL;
	...
}

drivers/net/virtio_net.c:mergeable_xdp_get_buf() {
	...
		xdp_page = page_pool_alloc_pages(rq->page_pool, GFP_ATOMIC);
		if (!xdp_page)
			return NULL;
	...
}

Both NULL returns are routed to err_xdp by receive_small_xdp() and
receive_mergeable_xdp() without touching alloc_fail.

Finally, the refill sites outside NAPI drop the try_fill_recv() return
value entirely, so an -ENOMEM there is not visible at queue or device
scope:

drivers/net/virtio_net.c:virtnet_open() {
	...
			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
	...
}

drivers/net/virtio_net.c:virtnet_rx_resume() {
	...
		if (refill)
			try_fill_recv(vi, rq, GFP_KERNEL);
	...
}

The changelog says:

    This counter does not cover every allocation failure in all RX paths.
    It is intentionally limited to the common skb and RX buffer allocation
    paths to keep its meaning clear.

Since the napi_alloc_skb() and virtnet_skb_append_frag() failures in the
XSK path look like exactly those common skb paths, could they be counted
too, so that the same failure is not counted in one variant and dropped
in the other? The caveat only exists in the changelog, so a userspace
consumer cannot tell "no allocation failures" apart from "this path is
not instrumented".

[ ... ]

> @@ -2928,12 +2941,14 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  
>  	u64_stats_set(&stats.packets, packets);
>  	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> -		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> +		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
>  			/* We need to retry refilling in the next NAPI poll so
>  			 * we must return budget to make sure the NAPI is
>  			 * repolled.
>  			 */
>  			packets = budget;
> +			u64_stats_inc(&stats.alloc_fail);
> +		}
>  	}
>  
>  	u64_stats_update_begin(&rq->stats.syncp);
> @@ -2948,6 +2963,7 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  
>  	u64_stats_add(&rq->stats.packets, u64_stats_read(&stats.packets));
>  	u64_stats_add(&rq->stats.bytes, u64_stats_read(&stats.bytes));
> +	u64_stats_add(&rq->stats.alloc_fail, u64_stats_read(&stats.alloc_fail));
>  
>  	u64_stats_update_end(&rq->stats.syncp);

[Severity: Medium]
This isn't a bug introduced by this patch, but the qstat read side has no
seqcount protection, and the new alloc_fail field is now routed through
it as well.

The writer here runs in softirq inside
u64_stats_update_begin(&rq->stats.syncp) ...
u64_stats_update_end(&rq->stats.syncp), while the reader does a bare
read:

drivers/net/virtio_net.c:virtnet_get_queue_stats_rx() {
	virtnet_stats_ctx_init(vi, &ctx, (void *)stats, true);

	virtnet_get_hw_stats(vi, &ctx, i * 2);
	virtnet_fill_stats(vi, i * 2, &ctx, (void *)&rq->stats, true, 0);
}

drivers/net/virtio_net.c:virtnet_fill_stats_qstat() {
	...
			v_stat = (const u64_stats_t *)(base + desc[i].offset);
			ctx->data[offset] = u64_stats_read(v_stat);
	...
}

The ethtool reader in the same file does use the retry protocol:

drivers/net/virtio_net.c:virtnet_get_ethtool_stats() {
	...
		do {
			start = u64_stats_fetch_begin(&rq->stats.syncp);
			virtnet_fill_stats(vi, i * 2, &ctx, stats_base, true, 0);
		} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
	...
}

On CONFIG_64BIT=n, can a concurrent qstats dump observe a torn 64-bit
value for packets, bytes or the new alloc_fail? Would it make sense to
wrap the qstat callbacks in u64_stats_fetch_begin() /
u64_stats_fetch_retry() the same way?

> @@ -5666,6 +5682,7 @@ static void virtnet_get_base_stats(struct net_device *dev,
>  	 */
>  	rx->bytes = 0;
>  	rx->packets = 0;
> +	rx->alloc_fail = 0;
>  
>  	if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_RX_BASIC) {
>  		rx->hw_drops = 0;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903022848.33595-1-lange_tang%40163.com
