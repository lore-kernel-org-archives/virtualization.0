Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78133A5E7A;
	Thu,  6 Aug 2026 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032253; cv=none; b=HkLXBIS/t72b7ppaFs1BUpbbKVw9C/00hy2F1z0GwBGggJfbbeNoFedgVdM1qXpJyxM3vTTiifzN/1l6aQOkfLRlCqbNHq935VFzOUcm5KJaQIx7HCeQ/gf3ZOd4dZFgtCn4gk3d9HEO4JInyzX0naDW8rJUi8ow1yg9WmaFtWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032253; c=relaxed/simple;
	bh=JA+f1SBJ0vX73iyDUgJmY52Xr8YlvdcqP3z/vMjhdP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F68yyvf+e73KYEyWV2Z8DPPRbAwlUP+F/Ujnu6V0Nb8Eqtq1IufA7a2w1jXyIpu14pZQnFxBXt2ZeeVYf0EWnmEvYkIqRrTD7TvTeBocTf9Co2mcnNqUzTx1bHUixPCyDhUppehFJ43raZ56D9SanBNff62DSPOSwDw5LR/htTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzWRoBPI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzWRoBPI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DAF1F00A3A;
	Thu,  6 Aug 2026 16:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032251;
	bh=VwNctgsn7ev4d1iV7X14XkVZ4wfENwSBeCgpcUp54Ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YzWRoBPIBmIjbRVA5/V9B2/I+zdIyOVOMdaKcK9s1sDFKA4nhwW8ud3pp+ZvEDJy1
	 z00/BH9PZhQEiR4ismfnYEV37DoPdp79nMMubbf5BJsu22QSy5tP70/CbMHCDvKIiM
	 LdBciS7rvCcGFWPgMJ/33zx9fVQs0dUSKcSzCwRIrg8v4OMV00JulT72ZN3FWVN4pi
	 06TfnC1v/kTSfxqZUuAscJdUyouhnj1NrX4PpejygdSaQG8WqXdZenage9jB/DDDc2
	 SRCfashtq2CI1dF4ogSGkshv2Qul7O6kM8ghY9E80Hb/1me8J2V/0QNejoYwoPjm+t
	 Yq4qV8wnIJqKA==
From: Jakub Kicinski <kuba@kernel.org>
To: xiongweimin@kylinos.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	mst@redhat.com,
	jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] virtio_net: check AF_XDP queue index before use
Date: Thu,  6 Aug 2026 09:04:10 -0700
Message-ID: <20260806160410.2689091-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804085330.1333242-1-xiongweimin@kylinos.cn>
References: <20260804085330.1333242-1-xiongweimin@kylinos.cn>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
virtio_net: check AF_XDP queue index before use

This moves the qid >= vi->curr_queue_pairs test in
virtnet_xsk_pool_enable() so that it runs before the vi->rq[qid].page_pool
check instead of after it.  The rest of the function is unchanged.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 3e2a5876c6c8c..6160aa8ba595e 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5896,15 +5896,15 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
>  	if (vi->hdr_len > xsk_pool_get_headroom(pool))
>  		return -EINVAL;
>  
> +	if (qid >= vi->curr_queue_pairs)
> +		return -EINVAL;
> +
>  	/* In big_packets mode, xdp cannot work, so there is no need to
>  	 * initialize xsk of rq.
>  	 */
>  	if (!vi->rq[qid].page_pool)
>  		return -ENOENT;
>  
> -	if (qid >= vi->curr_queue_pairs)
> -		return -EINVAL;
> -

[Severity: Medium]
The changelog says this "keeps an out of range queue id from reaching
vi->rq[qid] while checking page_pool".  Was an out of range qid actually
reachable here?

vi->rq and vi->sq are sized max_queue_pairs in virtnet_alloc_queues():

	vi->sq = kzalloc_objs(*vi->sq, vi->max_queue_pairs);
	...
	vi->rq = kzalloc_objs(*vi->rq, vi->max_queue_pairs);

and the netdev is created with alloc_etherdev_mq(..., max_queue_pairs), so
dev->num_rx_queues == dev->num_tx_queues == max_queue_pairs.

The only path into virtnet_xsk_pool_enable() is
xp_assign_dev() -> ndo_bpf(XDP_SETUP_XSK_POOL) -> virtnet_xsk_pool_setup(),
and xp_assign_dev() first goes through xsk_reg_pool_at_qid() in
net/xdp/xsk.c:

	if (queue_id >= max(dev->real_num_rx_queues,
			    dev->real_num_tx_queues))
		return -EINVAL;

real_num_rx_queues/real_num_tx_queues can never exceed num_rx_queues/
num_tx_queues, so any qid that reaches the driver is already inside the
allocated arrays and vi->rq[qid].page_pool was an in-bounds read.

For a qid in [curr_queue_pairs, max_queue_pairs) the old ordering still
rejected the request before sq/rq were used, so the only visible difference
after the reorder appears to be -EINVAL instead of -ENOENT.  Could the
changelog describe this as a defensive reordering rather than as preventing
an out of range dereference?  As written it reads like a memory safety fix
and may attract a stable backport.

[Severity: High]
This is a pre-existing issue and not something this patch introduces, but
since the patch touches the enable-side qid test, is the symmetric test in
virtnet_xsk_pool_disable() safe?

	if (qid >= vi->curr_queue_pairs)
		return -EINVAL;

	sq = &vi->sq[qid];
	rq = &vi->rq[qid];

On that path the early return skips virtnet_rq_bind_xsk_pool(vi, rq, NULL),
virtnet_sq_bind_xsk_pool(vi, sq, NULL), xsk_pool_dma_unmap(pool, 0), the
virtqueue_unmap_single_attrs() of sq->xsk_hdr_dma_addr and
kvfree(rq->xsk_buffs).

Can curr_queue_pairs shrink below a qid that already has a pool bound?
virtnet_xdp_set() raises it on attach:

	err = virtnet_set_queues(vi, curr_qp + xdp_qp);
	if (err)
		goto err;
	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
	vi->xdp_queue_pairs = xdp_qp;

With max_queue_pairs=8, curr_qp=4 and xdp_qp=4 an XDP attach gives
curr_queue_pairs = real_num_rx_queues = 8, so a zero-copy socket can bind
to qid 5 (xsk_reg_pool_at_qid() accepts it, virtnet_xsk_pool_enable()
accepts it, and rq[5].page_pool is non-NULL because
virtnet_create_page_pools() covers all max_queue_pairs queues).  Detaching
the program then goes back to virtnet_set_queues(vi, curr_qp) with no
AF_XDP-in-use check, unlike the ethtool channel paths which are guarded by
netdev_queue_busy().

When the socket is closed, xp_release_deferred() -> xp_clear_dev() ->
xp_disable_drv_zc() calls ndo_bpf(XDP_SETUP_XSK_POOL, pool=NULL,
queue_id=5), which now hits qid(5) >= curr_queue_pairs(4) and returns
-EINVAL.  The core only warns:

	WARN(1, "Failed to disable zero-copy!");

so does this leak the kvzalloc'ed rq->xsk_buffs array, the xsk pool DMA
mapping and sq->xsk_hdr_dma_addr?

Beyond the leak, rq[5]->xsk_pool and sq[5]->xsk_pool still point at the
pool that xp_release_deferred() then frees via xp_destroy().  If the queue
count is grown again (XDP re-attach, or ethtool -L back to 8, which is now
allowed because xsk_clear_pool_at_qid() already cleared dev->_rx[5].pool),
the datapath dereferences it unconditionally in try_fill_recv():

	if (rq->xsk_pool) {
		err = virtnet_add_recvbuf_xsk(vi, rq, rq->xsk_pool, gfp);
		goto kick;
	}

and similarly in virtnet_receive() and virtnet_poll_tx().  Can that be a
use-after-free of the freed pool?

Related to that, rq->xsk_buffs is never set to NULL after kvfree() in
either virtnet_xsk_pool_disable() or the err_free_buffs path of
virtnet_xsk_pool_enable():

err_free_buffs:
	kvfree(rq->xsk_buffs);
	return err;

so its safety depends entirely on rq->xsk_pool having been cleared first.
Would it make sense to release the resources unconditionally in the
disable path, or to block shrinking curr_queue_pairs while a pool is bound?
-- 
pw-bot: cr
