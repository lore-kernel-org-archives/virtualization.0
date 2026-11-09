Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227697;
	b=FzsS8GELFsnFDZJBbMDBMW+tM/AmzLBDzdgsrq+duv1MfwquJhBJGL6gVyunDGndwwb5
	 siNIjnMgFndNPknAyW+TNmHYxdZzmaZ++yVEZE+BI11qqnB9fF3/NthsLnFE07OLrIgDi
	 2z9ENhYrTz+wsW1e+fKDyqt2mqFTbzi7JerYE8BO1EKGa8PBJg2utv+WKvd8/9ceIQxOK
	 xjoTqpCxXaG7lAtv5r+6FSlrGmNEerUDuLJpwvjkBOxc7nJM8CRJA7b2c7EutwN99ttxu
	 1f/HyAuYNAG1mvQXDI5//41fwFy0L3QXUegctkPMdIJ6ZUPpr14yMwwwKGmJjzcHn/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227697;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=4GbJ+kUwo8z1BuDy3RTehdprY4yldT3/buOwkYyDG08=;
	b=RwyVT3Z3OUcP7j6+d9Y5W/iLLcB3DA1nXcQ+Gh9Lr4oOTdKQpKJzE/UrAUnGUkNJUfFo
	 HYROOz7WpJzua5q7rSFruRyD+PBT6QNznmJnttiL4+2Too3MWLejj10VPIlIM+mVM48XF
	 BU1mFulBt0eqIoD+/V/hDAEr1mENsm4ZNtRH/+cKgbT6lSoQeE6kuBM0aJOG7/i4KNG4m
	 uRavNdqAVVQf/LwxlJ1O/79lJtxdxKpi78WX7z7NqX/7XYj8FOZbNu0Yy9ef8qXOE6jRf
	 /bchQ8b+B/zSvn7OWuxzeZqEnYQzxRIvLLvi96AkDJsHWHNLZbnqMM4YVEdYfJPoCeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E94VJpTc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED1C606EE94;
	Mon,  9 Nov 2026 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E94VJpTc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B32F1F008A3;
	Mon,  9 Nov 2026 12:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794227696;
	bh=4GbJ+kUwo8z1BuDy3RTehdprY4yldT3/buOwkYyDG08=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E94VJpTcFDjJZq8KFikD+Zpgt0InXO4fas8YTA0WkAdfxCVMIY+PD+PT/BCkUQzeD
	 qdT8Rz7jNBLBIj02N3BDKxeCyBZaczxv99mqZp1s6hDcV4wqAnS9QgxJ+bwV13s00M
	 Q1xSUOvP4KBpRa17VqpMgDQeo6uurIfOP0J4QCctiAkkN7Iw10ZwWTou6qNPe0sd8Q
	 zKkGBxUHdVAUmkQ9O+aBADI36mYDOzULUQy+M98uVLL0+ECE9f7Lf1ClyUdqyPpEM1
	 OAC+fdLOav1DdmxizNvfN1b5P2sF+woIPAXP2DfYpituS3Ez6dy7rBn7hmujjt74Gg
	 yZ6KjF7iZZZ1w==
Subject: Re: [PATCH net v2 2/3] virtio_net: Disable AF_XDP pools on queues
 above curr_queue_pairs
From: netdev-bot+sashiko@kernel.org
To: yanhaishuang@cmss.chinamobile.com
Cc: mst@redhat.com, jasowangio@gmail.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, netdev@vger.kernel.org, virtualization@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 12:34:55 +0000
Message-ID: <179422769501.994134.8613940611095428101@kernel.org>
In-Reply-To: <20261108193845.73621-3-yanhaishuang@cmss.chinamobile.com>
References: <20261108193845.73621-3-yanhaishuang@cmss.chinamobile.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In the final state of the series, the widened qid range in
  virtnet_xsk_pool_disable() from this patch combines with the restore…
- [Low] The commit message names only one trigger: explicitly removing
  XDP and then closing the socket.

--

virtio_net: Disable AF_XDP pools on queues above curr_queue_pairs

This patch changes the qid check in virtnet_xsk_pool_disable() to use
max_queue_pairs instead of curr_queue_pairs. With this change, an AF_XDP
zero-copy pool bound to an XDP_TX queue can still be unbound after the XDP
program is removed. Before this patch, the core freed the pool while
rq->xsk_pool still pointed to it, which caused a use-after-free on refill.

> When the program is removed, the queue count goes down again while the
> pool stays bound to the driver. When the socket is closed afterwards,
> virtnet_xsk_pool_disable() rejects the queue with -EINVAL, and the core
> frees the pool anyway:

[Severity: Low]

Is explicit XDP removal followed by closing the socket the only trigger?

Ordinary netdev unregistration looks like it ends in the same failed
disable. Examples are virtio-net hot-unplug, driver unbind and module
unload. This needs an XDP program attached and a zero-copy socket bound
to one of the XDP_TX queues:

unregister_netdevice_many_notify()
    dev_xdp_uninstall(dev)
        virtnet_xdp_set(NULL)    <- lowers curr_queue_pairs
    call_netdevice_notifiers(NETDEV_UNREGISTER, dev)
        xsk_notifier()
            xp_clear_dev(xs->pool)
                xp_disable_drv_zc()
                    ndo_bpf(XDP_SETUP_XSK_POOL, NULL, qid)
                        virtnet_xsk_pool_disable()  <- -EINVAL before this patch

Before this patch, that path hit WARN(1, "Failed to disable zero-copy!")
in xp_disable_drv_zc(). It also left rq->xsk_pool, sq->xsk_pool, the
posted XSK buffers and the pool DMA map in place.

The new max_queue_pairs bound fixes this path as well. The commit message
only hints at it with "Removing XDP must not fail". Could the message
also mention the unregister path?

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4f5d8812f75b0..f9d227060375c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6030,7 +6030,8 @@ static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
>  	struct send_queue *sq;
>  	int err;
>  
> -	if (qid >= vi->curr_queue_pairs)
> +	/* Removing XDP can leave the pool on a queue above curr_queue_pairs */
> +	if (qid >= vi->max_queue_pairs)
>  		return -EINVAL;

[Severity: Medium]

How does this wider qid range interact with the restore fallback that a
later patch in this series adds to this function? That patch is
"virtio_net: Keep AF_XDP zero-copy pools bound across suspend", and the
fallback looks like this:

drivers/net/virtio_net.c:virtnet_xsk_pool_disable() {
    ...
	pool = rq->xsk_pool;
	if (!pool) {
		/* Binding it again on restore failed, only the DMA map is left */
		pool = xsk_get_pool_from_qid(dev, qid);
		if (pool)
			xsk_pool_dma_unmap(pool, 0);
		return 0;
	}
    ...
}

xsk_get_pool_from_qid() only returns a pool for a qid below
real_num_rx_queues or real_num_tx_queues:

net/xdp/xsk.c:xsk_get_pool_from_qid() {
	if (queue_id < dev->real_num_rx_queues)
		return dev->_rx[queue_id].pool;
	if (queue_id < dev->real_num_tx_queues)
		return dev->_tx[queue_id].pool;

	return NULL;
}

This patch now lets those same qids through after XDP removal. Consider
this sequence:

1. XDP is attached. virtnet_xdp_set() raises curr_queue_pairs and
   real_num_rx_queues, and real_num_tx_queues stays at the original
   count.

2. A zero-copy socket binds to a qid in the XDP_TX range.

3. On suspend, virtnet_xsk_pools_release() leaves the pool DMA mapped,
   because qid < curr_queue_pairs.

4. On resume, virtnet_xsk_pools_attach()->virtnet_xsk_pool_attach()
   fails. Possible causes are a kvzalloc()/kzalloc() failure, a TX header
   DMA mapping error or an xdp_rxq_info_reg() failure. Only a warning is
   printed. The pool stays DMA mapped and rq->xsk_pool is NULL.

5. XDP is removed. curr_queue_pairs, real_num_rx_queues and
   real_num_tx_queues are now all at or below qid.

6. The socket is closed. The qid passes the new max_queue_pairs check
   and rq->xsk_pool is NULL. xsk_get_pool_from_qid() returns NULL, so
   the unmap is skipped and 0 is returned.

The core then frees the pool through xp_release_deferred()->xp_destroy(),
which never unmaps:

net/xdp/xsk_buff_pool.c:xp_destroy() {
    ...
	kvfree(pool->tx_descs);
	kvfree(pool->heads);
	kvfree(pool);
}

Does this leak the xsk_dma_map, its dma_pages array and the DMA or IOMMU
mappings of the umem pages? Would the umem pages then be unpinned and
freed while they are still mapped for the device?

A few possible fixes:

- read dev->_rx[qid].pool directly in the fallback, which is bounded by
  num_rx_queues
- keep a driver-side pointer to a pool that is mapped but not attached
- unmap on restore when the attach fails

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108193845.73621-1-yanhaishuang%40cmss.chinamobile.com
