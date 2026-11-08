Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794113909;
	b=u+sOPPgko4kiQ6IGtUVUi8NIIJXExkPtveyV8+apdtTh7zaX2qVPckqOM3J+csIfJqZK
	 9S7gUk3kx8m4XpjS8yOoWq2Of1ndyHzyVLm3hHbSMUjjs2Xa/R2MRmARRKeO9pS4xyYqA
	 07U7YdnNDUDNTSvjgtv3cj24vUak/yq5rRdf7lYCjk2YaitXY/aI49KFvDm2bZBVMd/H6
	 83r6jbmYs1u9xbDRA5N91hdRK0cwDGPDanu1aW+ekETb+MKOZjEBZfi/Oi8k0lIiQk+MC
	 0nuhSEsSFyPNyFRsfh/D9OmZfHd/in+znhZWI4ry0qO/ixp+LxsiVpUSTyKThIUS9qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794113909;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QnIJPUTYMCZB2iSIS+z1z9PFKB+BDoMPJ2+pb0yLjgc=;
	b=oQA0kr8OtWqPkuIUMOayr9iTN9/G1H1ZZls6bTg3m5RCeXlAHqxsz7RQukzO3cYp7jKH
	 0NNBX1arkQhjvFE23t9XQMzYKVCWU0xM9fYqgv+7MghwIb0AU97sVNeMTSwPBRX9aQqu5
	 iKq5UJyH/DpVVWmHXSqDk/fNWBrk2Yaq97dWjggkkwY8VKN55Kb7DBap0T3W2CnPrYzus
	 OzSEp0DEkGOo/uGuS9+f3CQEG5IyMEYqWvBL/i0O+Q9Tm06f/pceqVLIX0Nrp7TuddAwB
	 nigdPLAQMyY1gLYgUCnhmlBz/lUqEBsTZgE2cl4/YcIpB8s86xr34I4PMJaZ3siLGIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fpq2DQhX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE46606A334;
	Sun,  8 Nov 2026 04:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fpq2DQhX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1EC1F0089F;
	Sun,  8 Nov 2026 04:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794113909;
	bh=QnIJPUTYMCZB2iSIS+z1z9PFKB+BDoMPJ2+pb0yLjgc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fpq2DQhXyw3aM7GX+UzwIeSmA0r1WoyUXuTVuC8rwtUEdU+YUDp9I1TnIhpiTjxG+
	 nyGopLI4jPQQSSsJeSpHXAAdLB32Tv4WTMtswGXIgGeI5duzcdZqvuqyvrVbfQm9ul
	 8HNhtPCXwVSzT+rpn3/GJFQ0NOPx/PtEykMJsArhrBJw+hOB02SxI2n90N49iFfsWS
	 N9HZsOaQ/vUoaSTVzVRU11hFsb7hiSWqhIrTFKXRc+9dMEKvB14MDElEnDJ7vciUxR
	 gDr8o0Q0E8LHiAq1S9p0oLavCkj0uqaa5SAtpfHamaI69ymJqHlLhWRnY1p/6b1smt
	 HS1ONnAGjCADw==
Message-ID: <sashiko-outbox-203566@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] virtio_net: Keep AF_XDP zero-copy pools bound
 across suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haishuang Yan" <yanhaishuang@cmss.chinamobile.com>
Cc: virtualization@lists.linux.dev, bpf@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261107125723.33547-3-yanhaishuang@cmss.chinamobile.com>
References: <20261107125723.33547-1-yanhaishuang@cmss.chinamobile.com>
 <20261107125723.33547-3-yanhaishuang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 04:58:28 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] virtio_net: stale DMA addresses in free_list after unaligned
  XSK pool rebind
- [High] virtio_net: uninitialized xsk_hdr_dma_addr used in
  virtnet_xsk_pool_enable()
- [High] virtio_net: race between RX NAPI and xsk_pool_dma_unmap() in
  virtnet_freeze()
- [Medium] virtio_net: virtnet_xsk_pool_disable() fails for qid >=3D
  curr_queue_pairs
--

commit 0f52eff49a0a7d3c2cb4265b671ce30bc13fd5e3
Author: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

virtio_net: Keep AF_XDP zero-copy pools bound across suspend

This commit unbinds the driver side of active AF_XDP zero-copy buffer pools
before freezing virtio_net queues and rebinds them after restore.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4f5d8812f75b0..5995ad730a91a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6052,6 +6055,42 @@ static int virtnet_xsk_pool_disable(struct net_dev=
ice *dev, u16 qid)
>  	return err;
>  }
> =20
> +/*
> + * Freeze frees the receive and send queues while the AF_XDP sockets stay
> + * bound to the device, so release the driver side of the zero-copy pools
> + * before and bind them again after restore.
> + */
> +static void __maybe_unused virtnet_xsk_pools_unbind(struct virtnet_info =
*vi)
> +{
> +	int i;
> +
> +	ASSERT_RTNL();
> +
> +	for (i =3D 0; i < vi->max_queue_pairs; i++)
> +		if (vi->rq[i].xsk_pool)
> +			virtnet_xsk_pool_disable(vi->dev, i);
> +}

[Severity: Medium]
Does virtnet_xsk_pool_disable() fail without unbinding the pool when
i >=3D vi->curr_queue_pairs?

Attaching an XDP program in virtnet_xdp_set() expands vi->curr_queue_pairs
and dev->real_num_rx_queues by xdp_qp, allowing an AF_XDP zero-copy pool to
be bound to a queue in that upper range, and detaching the XDP program
shrinks vi->curr_queue_pairs back down without unbinding the pool.  When
virtnet_xsk_pools_unbind() iterates up to vi->max_queue_pairs,
virtnet_xsk_pool_disable() rejects any qid >=3D vi->curr_queue_pairs:

drivers/net/virtio_net.c:virtnet_xsk_pool_disable() {
	if (qid >=3D vi->curr_queue_pairs)
		return -EINVAL;
}

As a result, remove_vq_common() frees vi->rq and vi->sq while leaving
rq->xsk_rxq_info registered, the pool DMA mapping active, and rq->xsk_buffs
and sq->xsk_hdr leaked.

> +
> +static void __maybe_unused virtnet_xsk_pools_rebind(struct virtnet_info =
*vi)
> +{
> +	struct xsk_buff_pool *pool;
> +	int i, err;
> +
> +	ASSERT_RTNL();
> +
> +	for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> +		pool =3D xsk_get_pool_from_qid(vi->dev, i);
> +		if (!pool || !pool->umem->zc)
> +			continue;
> +
> +		err =3D virtnet_xsk_pool_enable(vi->dev, pool, i);

[Severity: High]
When pool->unaligned is true, does rebinding the pool after freeze leave
stale pre-suspend DMA addresses in pool->free_list?

During virtnet_freeze(), virtnet_xsk_pool_disable() resets rq->vq and passes
each posted RX buffer to xsk_buff_free(), which places the xdp_buff_xsk
entries onto pool->free_list before xsk_pool_dma_unmap() unmaps and frees
the old DMA mapping.  On restore, virtnet_xsk_pool_enable() calls
xsk_pool_dma_map() -> xp_dma_map() -> xp_init_dma_info(), which skips
reinitializing xskb->dma when pool->unaligned is set:

net/xdp/xsk_buff_pool.c:xp_init_dma_info() {
	if (!pool->unaligned) {
		u32 i;

		for (i =3D 0; i < pool->heads_cnt; i++) {
			struct xdp_buff_xsk *xskb =3D &pool->heads[i];
			u64 orig_addr;

			orig_addr =3D xskb->xdp.data_hard_start - pool->addrs - pool->headroom;
			xp_init_xskb_dma(xskb, pool, dma_map->dma_pages, orig_addr);
		}
	}
}

When virtnet_rq_bind_xsk_pool() refills rq->vq via virtnet_rx_resume() ->
try_fill_recv() -> virtnet_add_recvbuf_xsk(), xsk_buff_alloc_batch() pops
those recycled entries from pool->free_list via xp_alloc_reused() without
updating xskb->dma, programming rq->vq with the unmapped pre-suspend DMA
addresses and causing IOMMU faults or DMA memory corruption.

> +		if (err)
> +			netdev_warn(vi->dev,
> +				    "failed to rebind AF_XDP pool to queue %d: %d\n",
> +				    i, err);
> +	}
> +}

[Severity: High]
Can virtnet_xsk_pool_enable() transmit from sq->xsk_pool during restore
before sq->xsk_hdr_dma_addr is initialized?

On restore, init_vqs() allocates fresh zeroed send queues (so
sq->xsk_hdr_dma_addr is 0), while bound AF_XDP sockets are already on
pool->xsk_tx_list and may have pending descriptors in their TX rings.
virtnet_xsk_pool_enable() calls virtnet_sq_bind_xsk_pool() before setting
sq->xsk_hdr_dma_addr:

drivers/net/virtio_net.c:virtnet_xsk_pool_enable() {
    ...
	err =3D virtnet_sq_bind_xsk_pool(vi, sq, pool);
	if (err)
		goto err_sq;

	/* Now, we do not support tx offload(such as tx csum), so all the tx
	 * virtnet hdr is zero. So all the tx packets can share a single hdr.
	 */
	sq->xsk_hdr_dma_addr =3D hdr_dma;
    ...
}

When the device is running, virtnet_sq_bind_xsk_pool() sets sq->xsk_pool =3D
pool and calls virtnet_tx_resume() -> virtnet_napi_tx_enable() ->
virtnet_napi_do_enable(), which schedules sq->napi and runs virtnet_poll_tx=
()
synchronously on local_bh_enable().  virtnet_poll_tx() -> virtnet_xsk_xmit()
-> virtnet_xsk_xmit_one() then submits sq->xsk_hdr_dma_addr (0) as the
virtio header DMA address to the virtqueue.

[ ... ]

> @@ -7246,6 +7285,10 @@ static __maybe_unused int virtnet_freeze(struct vi=
rtio_device *vdev)
>  {
>  	struct virtnet_info *vi =3D vdev->priv;
> =20
> +	rtnl_lock();
> +	virtnet_xsk_pools_unbind(vi);
> +	rtnl_unlock();
> +
>  	virtnet_cpu_notif_remove(vi);
>  	virtnet_freeze_down(vdev);

[Severity: High]
Can unbinding the pools before virtnet_freeze_down() race with RX NAPI
redirecting to the still-bound AF_XDP socket while xsk_pool_dma_unmap()
frees pool->dma_pages?

Because virtnet_xsk_pools_unbind() runs while netif_running(vi->dev) is
true and before virtnet_freeze_down() closes the device,
virtnet_rq_bind_xsk_pool(vi, rq, NULL) clears rq->xsk_pool and calls
virtnet_rx_resume(vi, rq, true), which refills rq->vq with page_pool
buffers and re-enables and schedules rq->napi before xsk_pool_dma_unmap()
runs.  Unlike normal socket teardown, the AF_XDP socket is still bound in
xsks_map, sorq->xdp_prog can redirect received page_pool packets into
xsk_rcv(), which falls back to copy mode (__xsk_rcv() -> xsk_buff_alloc())
while xsk_pool_dma_unmap() concurrently tears down the pool's DMA state:

CPU0                              CPU1 (<softirq>)
virtnet_freeze()
  virtnet_xsk_pools_unbind()
    virtnet_xsk_pool_disable()
      virtnet_rq_bind_xsk_pool(..., NULL)
        rq->xsk_pool =3D NULL
        virtnet_rx_resume()
          virtnet_napi_enable(rq)
                                  virtnet_poll()
                                    ...
                                    xsk_rcv()
                                      __xsk_rcv()
                                        xsk_buff_alloc(xs->pool)
                                          xp_alloc()
      xsk_pool_dma_unmap(pool, 0)
        xp_dma_unmap()
          kvfree(pool->dma_pages)
                                            xp_get_xskb()
                                              xp_init_xskb_dma(...,
                                                pool->dma_pages, ...)
                                                <-- use-after-free
          pool->dma_pages =3D NULL
          pool->dev =3D NULL

In addition to reading freed pool->dma_pages in xp_check_unaligned() and
xp_init_xskb_dma(), xp_alloc() can call xp_dma_sync_for_cpu() as pool->dev
and the DMA mappings are being cleared, or leave uninitialized xskb->dma
entries on pool->free_list when the socket consumes the copied frame.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107125723.3354=
7-1-yanhaishuang@cmss.chinamobile.com?part=3D2
