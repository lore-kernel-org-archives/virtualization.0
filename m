Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794116479;
	b=WNLfxeO8MWxH3bqtCCJf8ND5erMrApPUGVx5SR5ePqC7f49FaMWqSefK5cZ+DzjCeeTN
	 jUPHc2Dwqk/HMEpRKTNFzeu7Ty9+JkOV3e51HE51xiZCkRhIXI1Fajp8CVYOd7R5926Ao
	 Kq8I1E0/XQIlAypXIokgzIk9CFYjYioOLP854Btv6CGSBsN+tNjmEA5A5hHaMKuU/bYqm
	 7TA5YZRFq6q6fk3iVJI9bo2ilp3zmmomz7j2tPzViIfD2E7nuPKq8qFhK5T6fCtF5ivt+
	 Qmffyi9RurUWcRYGLuLLRPZ1L/KFnk5P6m8O/sfzUTzlPAsG5D3DDPiMyKzryEc4WLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794116479;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IPLIMMSflTCXvdcYE0YdAxRGwBqpklNNDxYuzi2MxMA=;
	b=F6yv5RWWWUl/Tu3Aq41w7P4xRxTeVKsH4O7lbJbvGVEqHIOh0qccphlD7IdWQryG///Z
	 7tV+x5tdqjWqwzK5cWEz+oOkOhRn5Gi7kMI7YhxAN6lK1hODOJifRsYAsEqVLIvAOz3YB
	 IktJa50qOLd8p6Bf5NhSeSoS4euG91rAb6Y+2isuDLwFPQ/BJ5y4WFyobNIaRfZA2EoBN
	 bhpz24UHODv+zZrHAMaVudJZih5XRN6WOqmhFTJ/F9JxCQGr7ABVSoaKB2nBnnOAwbDDd
	 j0/IiF1rdgeCC1aF1JdQlHxiBJX50mzs9QNHr8F2gJ/BaWIfhtLC/pPSi2XQLGy3GPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iAa9mcHd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A906606A334;
	Sun,  8 Nov 2026 05:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iAa9mcHd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA311F008A1;
	Sun,  8 Nov 2026 05:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794116478;
	bh=IPLIMMSflTCXvdcYE0YdAxRGwBqpklNNDxYuzi2MxMA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iAa9mcHdXIo9Q+xwrhFFYeH9vQPqUIeZ/n5Ix8O7ExIzF50jPFLqh5SfsVByA8IU/
	 llRAiPsy/vf59O3yJp12giI3JOxqD5wA2pldhlWlJqr3VMznu0US17KmOJJvaPCBG1
	 9twtx4HzQqL5f/jHOQ6OiUURVnrezuMOOnS3xRXqzVPmWBIog/Bgke5IK/7rvU2YeG
	 7surETfUfmb9wbWld66+4VzoNIzTmpZjbr6GZqOqCOcNy2S51rxMJsUfDh37fij0zA
	 9QuZSnRNv8E6GI9l8SgFnVR7o8a7IN+WaxpUh5KFRe7BIRvPHWrdJb2XoJjnIAzWSM
	 LYgisYIYE2u1g==
Subject: Re: [PATCH net 2/2] virtio_net: Keep AF_XDP zero-copy pools bound
 across suspend
From: netdev-bot+sashiko@kernel.org
To: yanhaishuang@cmss.chinamobile.com
Cc: mst@redhat.com, jasowangio@gmail.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org, virtualization@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 08 Nov 2026 05:41:17 +0000
Message-ID: <179411647719.994134.8428591729717130295@kernel.org>
In-Reply-To: <20261107125723.33547-3-yanhaishuang@cmss.chinamobile.com>
References: <20261107125723.33547-3-yanhaishuang@cmss.chinamobile.com>
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

Critical: 0 · High: 3 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] virtnet_xsk_pools_unbind() calls virtnet_xsk_pool_disable() for
  pools whose AF_XDP sockets are still XSK_BOUND.
- [High] virtio_net: stale DMA addresses in free_list after unaligned XSK
  pool rebind
- [High] virtio_net: uninitialized xsk_hdr_dma_addr used in
  virtnet_xsk_pool_enable()
- [Medium] virtnet_xsk_pools_unbind()
  (drivers/net/virtio_net.c:6063-6072) loops over max_queue_pairs and…

--

virtio_net: Keep AF_XDP zero-copy pools bound across suspend

This patch releases the driver side of AF_XDP zero-copy pools in
virtnet_freeze() and binds them again in virtnet_restore(). The xsk core
keeps the pools across suspend, so the driver needs to drop and rebuild its
own state for them. It also makes virtnet_xsk_pool_disable() return early
when a queue has no pool.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4f5d8812f75b0..5995ad730a91a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -6052,6 +6055,42 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
>  	return err;
>  }
>  
> +/*
> + * Freeze frees the receive and send queues while the AF_XDP sockets stay
> + * bound to the device, so release the driver side of the zero-copy pools
> + * before and bind them again after restore.
> + */
> +static void __maybe_unused virtnet_xsk_pools_unbind(struct virtnet_info *vi)
> +{
> +	int i;
> +
> +	ASSERT_RTNL();
> +
> +	for (i = 0; i < vi->max_queue_pairs; i++)
> +		if (vi->rq[i].xsk_pool)
> +			virtnet_xsk_pool_disable(vi->dev, i);

[Severity: High]
Does this work for a pool created with XDP_UMEM_UNALIGNED_CHUNK_FLAG?

On freeze, virtnet_xsk_pool_disable() resets the RX virtqueue with
virtnet_rq_unmap_free_buf(), which hands every posted buffer back with
xsk_buff_free(). Those xdp_buff_xsk entries go onto pool->free_list
with xskb->dma and xskb->frame_dma still pointing into the old
mapping. xsk_pool_dma_unmap() then tears that mapping down.

On restore, xsk_pool_dma_map() ends up in xp_init_dma_info(), but that
only refreshes the per-buffer DMA addresses for aligned pools:

	if (!pool->unaligned) {
		...
		for (i = 0; i < pool->heads_cnt; i++) {
			...
			xp_init_xskb_dma(xskb, pool, ...);
		}
	}

For unaligned pools the address is filled in by xp_get_xskb() when a
buffer is taken from the fill queue. Buffers recycled from
pool->free_list in xp_alloc_reused() or xp_alloc() are handed out as
they are.

So when virtnet_rq_bind_xsk_pool() refills the ring through
virtnet_rx_resume()->try_fill_recv()->virtnet_add_recvbuf_xsk(),
won't xsk_buff_xdp_get_dma() return the pre-suspend address for the
recycled buffers? With an IOMMU or swiotlb, that address is no longer
mapped or may already belong to someone else. The device would then
either fault or write received data into the wrong memory.
xp_dma_sync_for_device() would also be called on the stale address.

The normal unbind path never hits this, because the pool is destroyed
together with the socket. Here the same pool is unmapped and mapped
again while buffers sit on its free_list.

Should the driver keep the pool DMA mapping across freeze instead of
dropping it? Or does the xsk core need to reinitialise the free_list
entries when an unaligned pool is mapped again?

[Severity: Medium]

What happens here for a pool bound to a queue at or above
curr_queue_pairs? virtnet_xsk_pool_disable() returns before it releases
anything:

virtnet_xsk_pool_disable() {
	...
	if (qid >= vi->curr_queue_pairs)
		return -EINVAL;
	...
}

The return value is dropped here, so nothing is reported.

This state looks reachable. With native XDP attached, curr_queue_pairs is
curr_qp + nr_cpu_ids and real_num_rx_queues goes up to match. A zero-copy
socket can then bind to one of the XDP queues, because
virtnet_xsk_pool_enable() only requires qid < curr_queue_pairs.

When XDP is detached, virtnet_xdp_set() lowers curr_queue_pairs without
checking for bound pools:

	err = virtnet_set_queues(vi, curr_qp + xdp_qp);
	if (err)
		goto err;
	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
	vi->xdp_queue_pairs = xdp_qp;

On a later suspend, remove_vq_common()->virtnet_free_queues() frees vi->rq
and vi->sq. For those queues, wouldn't the pool DMA mapping,
rq->xsk_buffs, sq->xsk_hdr and the hdr DMA mapping still leak?

virtnet_xsk_pools_rebind() only walks curr_queue_pairs, so these queues
are not rebound on restore either. If the socket is closed after that, the
core gets -EINVAL back from virtnet_xsk_pool_disable() and warns "Failed
to disable zero-copy!". If XDP is attached again before the close, the new
!pool early return reports success and the umem DMA mapping is never
unmapped.

The missing check in virtnet_xdp_set() predates this patch. However, the
commit message says the patch releases "the driver side of all zero-copy
pools before freezing", and this case is still skipped without any error
being reported.

> +}

[ ... ]

> @@ -7246,6 +7285,10 @@ static __maybe_unused int virtnet_freeze(struct virtio_device *vdev)
>  {
>  	struct virtnet_info *vi = vdev->priv;
>  
> +	rtnl_lock();
> +	virtnet_xsk_pools_unbind(vi);
> +	rtnl_unlock();
> +

[Severity: High]

Can this race with the receive datapath? At this point the AF_XDP sockets
are still XSK_BOUND. The device is also still live, because
virtnet_freeze_down() has not run yet.

When the xsk core disables a pool itself, it quiesces the datapath first
in xsk_unbind_dev():

	WRITE_ONCE(xs->state, XSK_UNBOUND);

	/* Wait for driver to stop using the xdp socket. */
	xp_del_xsk(xs->pool, xs);
	synchronize_net();

Here, virtnet_xsk_pool_disable() does this instead:

	err = virtnet_rq_bind_xsk_pool(vi, rq, NULL);
	err |= virtnet_sq_bind_xsk_pool(vi, sq, NULL);

	xsk_pool_dma_unmap(pool, 0);

virtnet_rq_bind_xsk_pool(NULL) ends with virtnet_rx_resume(), which
refills the ring with page_pool buffers and re-enables NAPI. rq->xdp_prog
is still set, so an XDP_REDIRECT into the XSKMAP reaches xsk_rcv(). Since
the socket is still bound, xsk_rcv_check() passes and the copy path runs:

xsk_rcv()->__xsk_rcv()->xsk_buff_alloc()->xp_alloc()

xp_alloc() reads pool->dev and calls xp_dma_sync_for_device(). In
unaligned mode, xp_get_xskb() reads pool->dma_pages.

At the same time, xp_dma_unmap() can be running on another CPU. It unmaps
the pages, kvfree()s pool->dma_pages and sets pool->dev to NULL. RTNL does
not exclude the softirq.

Could this cause a use-after-free of pool->dma_pages, a DMA sync on an
address that was already unmapped (with swiotlb the bounce slot may have
been reused), or a NULL dev being passed to dma_sync_single_for_device()?

Restore seems to have the same window in reverse. virtnet_restore_up()
re-enables NAPI first. Then
virtnet_xsk_pools_rebind()->virtnet_xsk_pool_enable() calls
xsk_pool_dma_map() before virtnet_rq_bind_xsk_pool() pauses NAPI.

xp_init_dma_info() publishes pool->dev before it fills in the dma_pages
contents. A concurrent copy-mode receive, for example from a generic XDP
program still attached to the netdev, could then see a half-initialised
pool.

Before this patch, the driver's enable and disable paths only ran while the
socket was not bound, so this concurrency could not happen.

>  	virtnet_cpu_notif_remove(vi);
>  	virtnet_freeze_down(vdev);
>  	remove_vq_common(vi);

[ ... ]

> @@ -7270,6 +7313,10 @@ static __maybe_unused int virtnet_restore(struct virtio_device *vdev)
>  		return err;
>  	}
>  
> +	rtnl_lock();
> +	virtnet_xsk_pools_rebind(vi);
> +	rtnl_unlock();
> +
>  	return 0;
>  }
>  

[Severity: High]
Is the ordering in virtnet_xsk_pool_enable() still safe now that it
can be called for a pool whose sockets are already bound?

virtnet_restore_up() allocates a new, zeroed vi->sq array, so
sq->xsk_hdr_dma_addr is 0 when virtnet_xsk_pools_rebind() runs.
virtnet_xsk_pool_enable() maps the header into the local hdr_dma.
However, it only stores it in sq->xsk_hdr_dma_addr after
virtnet_sq_bind_xsk_pool() has returned.

virtnet_sq_bind_xsk_pool() sets sq->xsk_pool and then calls
virtnet_tx_resume(), which goes through virtnet_napi_tx_enable() to
virtnet_napi_do_enable(). That schedules the TX NAPI and runs it from
local_bh_enable(), so virtnet_poll_tx() can execute before
virtnet_sq_bind_xsk_pool() returns. A wakeup from userspace through
virtnet_xsk_wakeup() or a TX interrupt can get there as well.

virtnet_poll_tx() sees sq->xsk_pool set and calls virtnet_xsk_xmit().
On the initial bind there is nothing to send at that point, because
xp_assign_dev() calls ndo_bpf before the socket is added to
pool->xsk_tx_list. On restore the sockets are already on xsk_tx_list
and may still have descriptors queued in their TX ring from before
suspend. virtnet_xsk_xmit_one() would then pass sq->xsk_hdr_dma_addr,
which is still 0, to sg_fill_dma() and post it with
virtqueue_add_outbuf_premapped().

That hands DMA address 0 to the device as the virtio-net header for
every packet in the batch. Under an IOMMU this would fault. Without
one, the device would send whatever happens to be at that address as
the header.

The ordering predates this patch. Before it, though, the driver enable
path only ran before the socket was on xsk_tx_list. Should
sq->xsk_hdr_dma_addr be set before virtnet_sq_bind_xsk_pool() is
called, with the error path clearing it again?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261107125723.33547-1-yanhaishuang%40cmss.chinamobile.com
