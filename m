Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227698;
	b=zZyxb3Ur2UOf93aemHeEG8zwJCYXB57TYp8vl03Z8uwZJ/zXj2y8JIA2OQZij3Kngjc7
	 Uhpz/5uhsEatK59fswSHuLtJq3MnnuuYoahaT2S+z5upsVZsgE1wRe+C8ngtLcq7EgBGZ
	 NEH9t2ORGPTgxu7rDdr00Dig513unRHA0RLqfApQYZDjA0HO3RQCs8S70nepguuxaLzpA
	 tVUS23v27GE3495rTUltItyLD3ZVLyMXHO5mh5b03qNuYAKEWNHF/mYps9fbqDqYVMnBW
	 Lr8HCa/GfOzyjyDZzN76DEl4QWZh7m+Egb4iw9OUz5W04yiNJC1wAgq2dyIvNnKfOUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227698;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FV/e5DTSHGHujwnLji+sEp9cemeAfuZJZ3Rm6Igc44Y=;
	b=Ui+xwO2zA+S/v7pdQznQp6iuZuVjuWbXhCSOASksmOz3YXeey6JHCEDmZdHW4Tr+Dgc3
	 Kupi+qHwogUQw0ph1CtR/lHHtwPkgdbgRLz4tOeU0ozA6vy/SAszFTzYPKH3ZriSJeA4o
	 Rb6KcqpqD37nynDWpDxyFM3BJ8Up6mBLpFAZ4f3CuteaalOp9+kcspl9MSCR+OdVBCACz
	 sfHDFR1fOa9f2GecJ2SeTSWPPv0NdOrwfOip0/Es5rVkq1CgqkFcoe01ZunIKVAzQ3JKq
	 Crt4cq2vP2TKIX+gTqrZFsCaDVmVgxA7oeSNCpx9uZbLxJEfVP2OYIQ6cT+v4mLBn8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvDlWwGB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647A606EEB5;
	Mon,  9 Nov 2026 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WvDlWwGB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E331F0089F;
	Mon,  9 Nov 2026 12:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794227698;
	bh=FV/e5DTSHGHujwnLji+sEp9cemeAfuZJZ3Rm6Igc44Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WvDlWwGBFrIAvkPaKeIjvUvoXyewNtM4oNcjfnVwDwBRSpReShHkZOPL9ty6xKrg6
	 13LpSsoV1ANlwc+InTjjPtgNr045ZnEjrTODjJ/MUMaISlxjNu1n+80E4Cog6ngdZn
	 MVXJ5cMg2OfVZARYAaJP+SoQUlYSlyXKTdCS3iePda0/4iUcTG7+XY4pLKXK/KU+q6
	 eQr36UYj5N9PpoaeD5o0EGQeCPpF3SNcnFSH+zOqWDpWZ6AXuEej7u/opmgPnj5os2
	 L6YXVZer7HFsiB1YVVgyRcycMXMuBkiFcJLsZQKHl4T9MsQKrKWFwZVm9PZIuQi2tZ
	 uV6lgrU8tdXng==
Subject: Re: [PATCH net v2 3/3] virtio_net: Keep AF_XDP zero-copy pools bound
 across suspend
From: netdev-bot+sashiko@kernel.org
To: yanhaishuang@cmss.chinamobile.com
Cc: mst@redhat.com, jasowangio@gmail.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org, virtualization@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 12:34:56 +0000
Message-ID: <179422769660.994134.7551261891585249565@kernel.org>
In-Reply-To: <20261108193845.73621-4-yanhaishuang@cmss.chinamobile.com>
References: <20261108193845.73621-4-yanhaishuang@cmss.chinamobile.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] virtnet_xsk_pools_release() unmaps the DMA of a zero-copy pool
  sitting at a qid >= curr_queue_pairs (left there by removing XDP), but…
- [Medium] When virtnet_xsk_pool_attach() fails on restore, the pool
  stays DMA mapped while rq->xsk_pool stays NULL.
- [Medium] If virtnet_xsk_pool_attach() fails during restore,
  virtnet_xsk_pools_attach() only logs netdev_warn() and the resume…
- [Medium] virtnet_xsk_pools_release() is a new writer of AF_XDP driver
  state (rq->xsk_pool, sq->xsk_pool, rq->xsk_buffs, sq->xsk_hdr) that…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it defeats the
  patch's cleanup model on the failed-restore path.

--

virtio_net: Keep AF_XDP zero-copy pools bound across suspend

This patch keeps AF_XDP zero-copy pools DMA mapped across freeze and
restore. Only the driver state (xsk_buffs, TX header, xdp_rxq_info) moves
from the old queues to the new ones: it is released in remove_vq_common()
and attached again in virtnet_restore_up() before virtnet_open(). Pools
above curr_queue_pairs are unmapped on freeze. virtnet_xsk_pool_disable()
gets a fallback that unmaps pools whose attach failed on restore.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f9d227060375c..d9c920f421268 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -5808,6 +5810,7 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  err_destroy_pools:
>  	virtio_reset_device(vdev);
>  	free_unused_bufs(vi);
> +	virtnet_xsk_pools_release(vi);
>  	virtnet_destroy_page_pools(vi);
>  	virtnet_del_vqs(vi);
>  	return err;

[Severity: High]
This is a pre-existing issue that this patch did not introduce, but the
new error path depends on it.

When virtnet_restore_up() fails (init_vqs, virtnet_create_page_pools or
virtnet_open), or virtnet_cpu_notif_add() fails in virtnet_restore(),
virtnet_del_vqs()->virtnet_free_queues() does:

	kfree(vi->rq);
	kfree(vi->sq);

The pointers are not cleared, and the netdev stays registered.

On this path virtnet_xsk_pools_release() deliberately leaves the pools with
i < curr_queue_pairs DMA mapped. It expects virtnet_xsk_pool_disable() to
unmap them when the socket is closed. A socket close after thaw goes
through:

xp_release_deferred()
  xp_clear_dev()
    xp_disable_drv_zc()
      ndo_bpf()
        virtnet_xsk_pool_disable()

and that function starts with:

	sq = &vi->sq[qid];
	rq = &vi->rq[qid];

	pool = rq->xsk_pool;

Does this read the freed vi->rq before it ever reaches the new !pool
check? Depending on the stale contents, it could go on into
virtnet_rq_bind_xsk_pool() and virtqueue_reset() on freed queues.

xp_put_pool() queues the release on system_freezable_wq, so it cannot run
while the system is frozen. Only the failed-restore case applies. Other
ndo ops, such as virtnet_close(), also touch the dangling vi->rq after a
failed restore.

[ ... ]

> @@ -6038,6 +6041,13 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
>  	rq = &vi->rq[qid];
>  
>  	pool = rq->xsk_pool;
> +	if (!pool) {
> +		/* Binding it again on restore failed, only the DMA map is left */
> +		pool = xsk_get_pool_from_qid(dev, qid);
> +		if (pool)
> +			xsk_pool_dma_unmap(pool, 0);
> +		return 0;
> +	}

[Severity: Medium]
Can this fallback miss a pool that is still mapped? xsk_get_pool_from_qid()
filters on the current real queue counts:

net/xdp/xsk.c:xsk_get_pool_from_qid() {
	if (queue_id < dev->real_num_rx_queues)
		return dev->_rx[queue_id].pool;
	if (queue_id < dev->real_num_tx_queues)
		return dev->_tx[queue_id].pool;
	return NULL;
}

Consider this sequence:

1. A zc pool is bound at a queue Q in the XDP range
   [curr_qp, curr_qp + xdp_qp).

2. Suspend keeps it mapped because Q < curr_queue_pairs. On resume,
   virtnet_xsk_pool_attach() fails (allocation failure, header mapping
   error, or xdp_rxq_info_reg() failure) and only netdev_warn() is
   printed.

3. XDP is reinstalled and then removed. Removing it right after resume is
   a no-op, because freeze dropped rq->xdp_prog. The removal makes
   virtnet_xdp_set() call netif_set_real_num_rx_queues(dev, curr_qp).

4. When the socket closes, virtnet_xsk_pool_disable(Q) sees
   rq->xsk_pool == NULL. xsk_get_pool_from_qid() fails both real_num
   checks and returns NULL, so the function returns 0.

Is the DMA mapping, and the umem's xsk_dma_map refcount, leaked at that
point? A later freeze doesn't clean it up either, because
virtnet_xsk_pools_release() only acts when rq->xsk_pool is set. The umem
pages would later be unpinned while the IOMMU still maps them.

[ ... ]

> +static void virtnet_xsk_pools_release(struct virtnet_info *vi)
> +{
> +	int i;
> +
> +	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		struct receive_queue *rq = &vi->rq[i];
> +		struct send_queue *sq = &vi->sq[i];
> +
> +		if (rq->xsk_pool) {
> +			if (i >= vi->curr_queue_pairs)
> +				xsk_pool_dma_unmap(rq->xsk_pool, 0);

[Severity: High]
Does this leave a zero-copy pool registered in the xsk core but no longer
DMA mapped? The pool stays at dev->_rx[Q].pool with umem->zc set, and
xp_dma_unmap() does:

	kvfree(pool->dma_pages);
	pool->dma_pages = NULL;
	pool->dma_pages_cnt = 0;
	pool->dev = NULL;

It does not clear the per-xskb dma values in pool->heads.

curr_queue_pairs can later grow back over Q. One way is ethtool -L:
virtnet_set_channels() only rejects the change when rq[0].xdp_prog is set,
and that is NULL after resume. Reinstalling XDP has the same effect.

On the next suspend/resume, virtnet_xsk_pools_attach() only filters on:

	if (!pool || !pool->umem->zc)
		continue;

virtnet_xsk_pool_attach() only checks rq->page_pool and that the DMA
devices match. So the unmapped pool is installed as rq->xsk_pool and
sq->xsk_pool.

On TX the path is:

virtnet_poll_tx()
  virtnet_xsk_xmit()
    virtnet_xsk_xmit_one()
      xsk_buff_raw_get_dma()
        __xp_raw_get_dma()

which indexes pool->dma_pages[addr >> PAGE_SHIFT] while dma_pages is NULL,
at an offset chosen by userspace.

On RX the path is:

virtnet_open()
  try_fill_recv()
    virtnet_add_recvbuf_xsk()
      xsk_buff_alloc_batch()

pool->dev is NULL, so the slow path is skipped. Stale xskb->dma addresses
from the destroyed mapping are then posted with
virtqueue_add_inbuf_premapped(). With a vIOMMU or swiotlb (confidential VMs,
for example), those IOVAs or bounce slots have already been freed.

Doesn't this break the invariant behind the comment in
virtnet_xsk_pools_attach(), "The pool stays DMA mapped until it is
disabled"?

[ ... ]

> +static void virtnet_xsk_pools_attach(struct virtnet_info *vi)
> +{
> +	struct xsk_buff_pool *pool;
> +	int i, err;
> +
> +	ASSERT_RTNL();
> +
> +	for (i = 0; i < vi->curr_queue_pairs; i++) {
> +		pool = xsk_get_pool_from_qid(vi->dev, i);
> +		if (!pool || !pool->umem->zc)
> +			continue;
> +
> +		/* The pool stays DMA mapped until it is disabled */
> +		err = virtnet_xsk_pool_attach(vi, i, pool);
> +		if (err)
> +			netdev_warn(vi->dev,
> +				    "failed to bind AF_XDP pool to queue %d: %d\n",
> +				    i, err);
> +	}
> +}

[Severity: Medium]
What happens to the bound AF_XDP socket when this attach fails? The pool is
still registered at the qid with umem->zc set, but rq->xsk_pool and
sq->xsk_pool stay NULL. virtnet_poll_tx() only services XSK TX when
sq->xsk_pool is set:

	if (sq->xsk_pool)
		xsk_done = virtnet_xsk_xmit(sq, sq->xsk_pool, budget);
	else
		free_old_xmit(sq, txq, !!budget);

So the socket's TX ring is never consumed. virtnet_xsk_wakeup() still
returns 0, and the socket gets no sk_err or ENETDOWN, so userspace has no
signal that anything is wrong. RX on that queue quietly falls back to
page_pool buffers.

The socket stays stalled until the next suspend cycle or a rebind. The
commit message says:

    If that fails for a queue, the pool is left DMA mapped and
    virtnet_xsk_pool_disable() only unmaps it when the socket is closed.

It does not mention that the socket stops passing traffic. Should the
socket be told about the failure, or should this case be handled some
other way?

[ ... ]

> @@ -7208,6 +7345,8 @@ static void remove_vq_common(struct virtnet_info *vi)
>  	/* Free unused buffers in both send and recv, if any. */
>  	free_unused_bufs(vi);
>  
> +	virtnet_xsk_pools_release(vi);
> +

[Severity: Medium]
Should this run under RTNL? Every other writer of rq->xsk_pool,
sq->xsk_pool, rq->xsk_buffs and sq->xsk_hdr runs under RTNL through
ndo_bpf. remove_vq_common() is reached from virtnet_freeze() without RTNL.
The err_destroy_pools path in virtnet_restore_up() also calls
virtnet_xsk_pools_release() after rtnl_unlock().

The unmap path is:

xsk_pool_dma_unmap()
  xp_dma_unmap()
    xp_find_dma_map()
    xp_destroy_dma_map()

xp_find_dma_map() walks pool->umem->xsk_dma_list without a lock, and
xp_destroy_dma_map() does a plain list_del(). The ndo_bpf callers hold
RTNL, and that is the only serialization.

With XDP_SHARED_UMEM across two virtio-net devices, one umem->xsk_dma_list
holds one dma_map per netdev. PCI devices have async suspend enabled
(pci_pm_init()->device_enable_async_suspend()), so two virtnet_freeze()
calls can run at the same time. Both could take the
i >= curr_queue_pairs unmap branch.

Could that corrupt the shared list, or touch a dma_map that has already
been freed? free_receive_bufs() later in remove_vq_common() already takes
rtnl_lock(), so wrapping virtnet_xsk_pools_release() in RTNL should close
this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108193845.73621-1-yanhaishuang%40cmss.chinamobile.com
