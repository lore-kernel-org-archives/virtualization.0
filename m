Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B563A331EC2;
	Thu,  6 Aug 2026 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032253; cv=none; b=cJxB9Zq8MtPxq9SWPrjg5eOoni0faClL8uVHuE/Den6ax7+cYBigpmMOgKaDD2yfdEUQqgPKSwtEQmMJVCpi6itR4GexGfIElMfOICjoQ/tUzW+ZAvBDpfEWD3JQgHxSeYUKtEL0Obk+HfhnER1On5kNpn+SDvWQOSlWZezJAAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032253; c=relaxed/simple;
	bh=RKiSn9CQ4b6a5ztK4l4MMGhU1alXfBuVDT1fHBpz+7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJ0CUG+VN8084JjfZ1hs206K6B95tGDaSgAyvxgqu7qyKa8W6ZDZyBgiDknCXKka0SUgB5hcgbWMDTGp4+7fn/+z+47DPaEytYo7YZZQwL5vluXr+AL9zmfcJ4ZP3A7yH1Jr7aUR4mUS6NQYhcVvu/vrXooVs+zMrs6caQKQoEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hce5AXcC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hce5AXcC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385951F00A3D;
	Thu,  6 Aug 2026 16:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032252;
	bh=IOnlEZN2r/PcwjESPiToyDV/256gFWmwLrFgYVCLISU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hce5AXcCm49rNHM2KbtePLIKEQg/cP6IV+6n6BZcRYlTqJcGIQGJJ2vWWwDj/JjY+
	 DF1e0dFMNULV5/1yG7mUTEjF08s+38j+BxwCCpFSXgy9E9ARwJ1PVt52mpoVJ3O4f1
	 bv41+1hUmrPy5ay1/KlbM2JuqdrlOP/Qm/f+26LdWnH+AnE2AKl7sNSqtfaK6fRXmV
	 UC/w0yPxMkIw0sKr36wvdxeLbyxkQN+qi2PgS+MAnc+lYfpSE6CK88jLS9geXsXB4o
	 dsuNWZCUzRbVVy1w3FfCivC+Kknv9K47sl9XuQod+uykXd7cFl5VYSGPRP+GrI7lvu
	 5Zqe8gYywe9kQ==
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
Subject: Re: [PATCH net 2/2] virtio_net: unmap AF_XDP header with tx virtqueue
Date: Thu,  6 Aug 2026 09:04:11 -0700
Message-ID: <20260806160411.2689177-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804085330.1333242-2-xiongweimin@kylinos.cn>
References: <20260804085330.1333242-2-xiongweimin@kylinos.cn>
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
virtio_net: unmap AF_XDP header with tx virtqueue

The patch changes the error unwind in virtnet_xsk_pool_enable() so that the
shared AF_XDP transmit header is unmapped with sq->vq instead of rq->vq,
matching the virtqueue used for the mapping.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6160aa8ba595e..a6f90f579b6e8 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -5959,7 +5959,7 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
>  err_rq:
>  	xsk_pool_dma_unmap(pool, 0);
>  err_xsk_map:
> -	virtqueue_unmap_single_attrs(rq->vq, hdr_dma, vi->hdr_len,
> +	virtqueue_unmap_single_attrs(sq->vq, hdr_dma, vi->hdr_len,
>  				     DMA_TO_DEVICE, 0);

[Severity: Low]

The changelog says "Use sq->vq on the setup error path as well so the DMA
unmap matches the mapping side", which reads like a real wrong-virtqueue
unmap is being fixed.  Is there a configuration where the old rq->vq unmap
actually released a different mapping?

Earlier in virtnet_xsk_pool_enable() the function bails out unless both
virtqueues share one non-NULL dma dev:

	if (virtqueue_dma_dev(rq->vq) != virtqueue_dma_dev(sq->vq))
		return -EINVAL;

	dma_dev = virtqueue_dma_dev(rq->vq);
	if (!dma_dev)
		return -EINVAL;

So on any path that can reach err_xsk_map, rq->vq and sq->vq have the same
dma dev.  virtqueue_dma_dev() only returns non-NULL when the device has no
map ops, and virtqueue_unmap_single_attrs() in drivers/virtio/virtio_ring.c
then only looks at the per-device flag before going to
virtqueue_unmap_page_attrs():

	if (!vq->use_map_api)
		return;

	virtqueue_unmap_page_attrs(_vq, addr, size, dir, attrs);

use_map_api is set from vring_use_map_api(vdev), so it is the same for both
queues too.  With that, the emitted dma_unmap_page_attrs() call is identical
before and after the patch (same device, address, size and direction).

Would it be clearer to state "no functional change intended" and explain
that the two virtqueues are equivalent today, so this is a symmetry cleanup
that only starts to matter if the dma dev equality precondition is relaxed?
Alternatively, if a reachable mismatch does exist, could the changelog name
that configuration and carry a Fixes: tag?  As written, the message with no
Fixes: tag can still be picked up as a DMA fix by stable/AUTOSEL tooling.
