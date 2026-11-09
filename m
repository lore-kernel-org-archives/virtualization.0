Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794224374;
	b=xiOhr7Xi/O6UDDeYQTcrJG+/zpoJyBVmlosUi14ri2e1hbv/3Pv8zGbPU4dOHrqUaXQR
	 CCx+CMllqlISjg89aWetC7JSZnlzFzBbAN/lbZCRAT/1bak+Mr/DW/7bTg2c75Jh3H4+7
	 g1I/fkYgU1dJorT2vlmz+tIvuGx9MRsskB7EL+pxzA9JxLK7DQxHxWF4+TBr63rAjhXha
	 Ct5z+5R4Ba9fSQhmP3tPIno0ehYNqPlHSr0ADJQXGzogqXfTjEoLkx8YJkPqfiwzx2xOV
	 iVICvjB+4IPhtMpjgxjMaQSVPSraJjbZs5weA1oVDquuY0RbAe2HsWEX7oHfCtVJU5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794224374;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ktZiBN6oq8tKGv1h+O2XcUUsEH++jxjkstqeUMzHfjE=;
	b=jLOpZdVMuM5NWFOHaRmbfvB3822cnSLZn5E9MccP7lQRd2xM74BQnnXrtlBdP85lWsWE
	 eyV/FW1L1ODIGC5pTpJJKEPlHFnSa+fV09DK8pKVQFXbn/0UY8ji/zm5qi2Sw4I+ClImT
	 pc8e23ILR0PG7aNMrKFFCEHZ79BQb9zZdrsquM0Jh+zYlIdwWBiPq1CcPoecgtJZ52ydy
	 qg2/GB+2W2XOAz2pmZBoel60KHW0ZmDbYZxoNvVm5lwzbTPM8mxUP2Bl1sT/MWU8pexRg
	 E5IFzroQBawI59YUEssyOI6pHOw5rUFNmYeoRcNOltz2HBhiIR97wkJ9Kd475nTgLaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhnRr4fZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF25606A333;
	Mon,  9 Nov 2026 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GhnRr4fZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAE21F0089F;
	Mon,  9 Nov 2026 11:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794224374;
	bh=ktZiBN6oq8tKGv1h+O2XcUUsEH++jxjkstqeUMzHfjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GhnRr4fZKiyjV6YisqcdXb6W0WpXzVyJ+sPj9Rd7EnzXh7bpFYKG7qe3cpuoVlbHJ
	 bD9TSCutoqm8yhs0VWRCluaPyLhomLoXmkLMu0NGf9f0yw3CMq+T5qIPXfiFXOQHRO
	 8Mdepit62HK0zCno0G6KPy2ys0+gRVzq1ddebeMBtl9ctDjg6gUNjsFYhld0I0W8mi
	 OQGRG0VD/Ggu2ZSGt48CRNmBTvzjlx/zegonyX3/wwrq2j88lO8lfkGqby0zmF138S
	 RmwYyvDVqW6xfAyR2Xqk5a5vctyrvlJeK3kATIyN+dJMwAGafX05MihOjZdvX5IdjH
	 8tGr/tVj9MtVA==
Message-ID: <sashiko-outbox-204885@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 3/3] virtio_net: Keep AF_XDP zero-copy pools
 bound across suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haishuang Yan" <yanhaishuang@cmss.chinamobile.com>
Cc: virtualization@lists.linux.dev, bpf@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261108193845.73621-4-yanhaishuang@cmss.chinamobile.com>
References: <20261108193845.73621-1-yanhaishuang@cmss.chinamobile.com>
 <20261108193845.73621-4-yanhaishuang@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 11:39:33 +0000
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
- [High] virtio_net: virtnet_xsk_pools_attach() attaches unmapped AF_XDP
  pool
- [Medium] virtio_net: UAF on vi->rq in virtnet_xsk_pool_disable() after
  failed restore
- [Medium] virtio_net: DMA map leak in virtnet_xsk_pool_disable() after
  XDP detach
- [Medium] virtio_net: missing rtnl_lock() around xsk_pool_dma_unmap()
  on freeze
--

commit f8bbdffa48d34460262d93d81019cacaef0e299f
Author: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

virtio_net: Keep AF_XDP zero-copy pools bound across suspend

This commit preserves AF_XDP zero-copy pools across suspend and resume by
releasing only the per-queue driver state on freeze while keeping the pools
DMA-mapped, then re-attaching them to the newly allocated queues on
restore.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f9d227060375c..d9c920f421268 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -5808,6 +5810,7 @@ static int virtnet_restore_up(struct virtio_device =
*vdev)
>  err_destroy_pools:
>  	virtio_reset_device(vdev);
>  	free_unused_bufs(vi);
> +	virtnet_xsk_pools_release(vi);
>  	virtnet_destroy_page_pools(vi);
>  	virtnet_del_vqs(vi);
>  	return err;
> @@ -6038,6 +6041,13 @@ static int virtnet_xsk_pool_disable(struct net_dev=
ice *dev, u16 qid)
>  	rq =3D &vi->rq[qid];
> =20
>  	pool =3D rq->xsk_pool;
> +	if (!pool) {
> +		/* Binding it again on restore failed, only the DMA map is left */
> +		pool =3D xsk_get_pool_from_qid(dev, qid);
> +		if (pool)
> +			xsk_pool_dma_unmap(pool, 0);
> +		return 0;
> +	}

[Severity: Medium]
Can virtnet_xsk_pool_disable() dereference a freed or NULL vi->rq after a
failed restore?

If virtnet_restore_up() fails (for example at err_destroy_pools, or
earlier in init_vqs()), virtnet_del_vqs() -> virtnet_free_queues() frees
vi->rq and vi->sq while the net_device and bound AF_XDP pools remain
registered.  When the socket is later closed, virtnet_xsk_pool_disable()
reads vi->rq[qid].xsk_pool from the dangling vi->rq pointer.

[Severity: Medium]
Can this fallback also leak the pool's DMA mappings if XDP is detached
before the socket is closed?

When virtnet_xsk_pool_attach() fails on restore for a pool bound to an XDP
queue (qid >=3D curr_qp), rq->xsk_pool is left NULL while the pool stays
DMA-mapped.  If the XDP program is then removed via virtnet_xdp_set(),
netif_set_real_num_rx_queues() lowers dev->real_num_rx_queues to
curr_qp <=3D qid (and dev->real_num_tx_queues is also curr_qp).  When the
socket is subsequently closed, xsk_get_pool_from_qid(dev, qid) returns
NULL because qid is no longer below real_num_rx_queues or
real_num_tx_queues, skipping xsk_pool_dma_unmap().

Unmapping the pool directly in virtnet_xsk_pools_attach() when
virtnet_xsk_pool_attach() fails would avoid leaving a half-bound DMA map
behind.

> @@ -6053,6 +6063,133 @@ static int virtnet_xsk_pool_disable(struct net_de=
vice *dev, u16 qid)
>  	return err;
>  }
> =20
> +/*
> + * Freeze frees the receive and send queues, but the AF_XDP sockets stay
> + * bound and the xsk core keeps their pools. Release only the driver sta=
te
> + * of the zero-copy pools here, once the device is reset and the buffers
> + * posted to it are back in the pools. The pools stay DMA mapped, since =
the
> + * DMA device is still the same after restore and the buffers on their f=
ree
> + * lists keep their DMA addresses.
> + *
> + * A pool left above curr_queue_pairs by removing XDP is not bound again
> + * on restore, so unmap it as well.
> + */
> +static void virtnet_xsk_pools_release(struct virtnet_info *vi)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < vi->max_queue_pairs; i++) {
> +		struct receive_queue *rq =3D &vi->rq[i];
> +		struct send_queue *sq =3D &vi->sq[i];
> +
> +		if (rq->xsk_pool) {
> +			if (i >=3D vi->curr_queue_pairs)
> +				xsk_pool_dma_unmap(rq->xsk_pool, 0);

[Severity: Medium]
Does calling xsk_pool_dma_unmap() here without holding rtnl_lock() race on
pool->umem->xsk_dma_list?

remove_vq_common() calls virtnet_xsk_pools_release() outside rtnl_lock()
during virtnet_freeze().  xp_dma_unmap() walks and deletes entries from
pool->umem->xsk_dma_list, which is protected by rtnl_lock.  If an xdp_umem
is shared across multiple devices via XDP_SHARED_UMEM, concurrent async
suspends can corrupt xsk_dma_list.

[ ... ]

> +/*
> + * On restore, set the zero-copy pools up again on the new queues before
> + * they are filled and their NAPI is enabled.
> + */
> +static void virtnet_xsk_pools_attach(struct virtnet_info *vi)
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
> +		/* The pool stays DMA mapped until it is disabled */
> +		err =3D virtnet_xsk_pool_attach(vi, i, pool);

[Severity: High]
Can virtnet_xsk_pools_attach() re-attach a pool that was already
DMA-unmapped by virtnet_xsk_pools_release()?

If a pool is bound to an XDP queue qid, detaching XDP lowers
vi->curr_queue_pairs below qid, and the next freeze unmaps the pool in
virtnet_xsk_pools_release() via xsk_pool_dma_unmap().  xp_dma_unmap() sets
pool->dma_pages =3D NULL and pool->dev =3D NULL, but pool->umem->zc and
dev->_rx[qid].pool remain set.  If XDP is re-attached after resume (raising
vi->curr_queue_pairs above qid again) and the system suspends a second
time, virtnet_xsk_pools_attach() sees pool->umem->zc =3D=3D true and attach=
es
the unmapped pool to the queue, leading to a NULL pointer dereference on
pool->dma_pages or pool->dev during RX/TX.

Should this check pool->dma_pages instead of pool->umem->zc, or re-map the
pool when pool->dma_pages is NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108193845.7362=
1-1-yanhaishuang@cmss.chinamobile.com?part=3D3
