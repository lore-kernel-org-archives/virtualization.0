Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19671432BF4
	for <virtualization@lists.linux.dev>; Sun, 20 Sep 2026 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789907717; cv=none; b=TRvbWPDJVb/b5+JMs7dQ9cIit/TgL5ArMu1KlalwroFur7eDKqETT1K/vH1IEJsliu71FXDZItlgyodfVoLPC7Ky5zQrXiP6nQ51rJGZ+YpJmVYVGwzbZgaM7pjVTBKjXN+o3NywElz/0uaPOe5sljXF/iICDIxp6HJroZ5k7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789907717; c=relaxed/simple;
	bh=vOWSSfsUvi1RaV9RxDc11nUarP9nRYcVCF9Bev54o68=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s3Gx4nskZvYyNbKoYmQEIEOjbkkg8wloypRYypbsBRNyTy87Ioiiz39VX623X6wuBsDgMn4Ibgvb3i4GgBJTRwSWR4r6PVUFx/IVsBLMlZW74GJkR+N+fnwMrT9BoYiOioP0TLppNtNiixxAzyq/fYb2NKDPf/KtIokI2DoRMTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idr8wRqF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idr8wRqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012D31F000FF;
	Sun, 20 Sep 2026 12:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789907705;
	bh=4qJrh0TScrbWaDFooRarS9DEpbh6NKu6itHlz2girnk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=idr8wRqF6+230CDQb2sf9tgnF1++j1jum1vjU7BEj7Bcvu5M5Gcb9Oudy11o6as9M
	 fzxzte20VhYsNBJqSuKSZQKy8iBB5rsAIdgLqowVKqpSwDFAI6F3Qa+v3xJDFzAT+f
	 H1RRhWP6HyO7b3mbhGpm1IqaIiv83eq8qrzR/a2NgU6b47Lew2KzcUQdP8ORWCXsGs
	 QZ1gEZ2T4zxahrdK0zrG2OwA8unGXLenSj76hdkxN6fUN2wljx7PiLCABm2jc7TEib
	 oFlbHbix1rx45xzpXDgUCNJqYOf88YzNd1xjID6rbqzq0Yj+I5CspleaOKbnuM98QX
	 yf44dy8MLIvAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] virtio_blk: Add control virtqueue support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linlin Zhang" <linlin.zhang@oss.qualcomm.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260920122444.2549493-2-linlin.zhang@oss.qualcomm.com>
References: <20260920122444.2549493-1-linlin.zhang@oss.qualcomm.com>
 <20260920122444.2549493-2-linlin.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 12:35:04 +0000
Message-Id: <20260920123505.012D31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] block/virtio_blk: DMA coherency violation on creq->abandoned
- [Medium] block/virtio_blk: TOCTOU race in control request timeout leads t=
o memory leak
--

commit e5e45f06d7dfecf78d290eb12655787cf1bee763
Author: linlzhan <linlin.zhang@oss.qualcomm.com>

virtio_blk: Add control virtqueue support

This patch adds support for the optional virtio-blk control virtqueue,
allowing the driver to manage control-queue requests independently from
the data path. The control virtqueue is intended for a subsequent inline
encryption implementation.

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9dc..2fad86e8f7a9a 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
[ ... ]
> @@ -110,6 +123,20 @@ struct virtblk_req {
>  	struct scatterlist sg[];
>  };
> =20
> +struct virtblk_ctrl_request {
> +	__virtio32 type;
> +	u8 status;
> +
> +	struct completion *compl;
> +	/*
> +	 * Set when virtblk_ctrl_vq_request()'s waiter timed out and moved on
> +	 * without freeing this request. Whichever of virtblk_ctrlq_callback()
> +	 * or virtblk_ctrl_vq_drain() later retrieves the buffer must free
> +	 * @compl and this struct instead of calling complete() on them.
> +	 */
> +	bool abandoned;
> +};

[Severity: High]
Could this cause a DMA coherency violation? The struct bundles the
device-written DMA field (status) with a CPU-modified software flag
(abandoned) within the same cacheline.

On non-cache-coherent architectures, if the CPU writes to the abandoned
flag while the device is actively DMA-writing to the status field, it
could result in cacheline tearing. This might lead to either silent data
corruption of the DMA-mapped response or loss of the CPU write.

[ ... ]
> +static void virtblk_ctrlq_callback(struct virtqueue *vq)
> +{
> +	struct virtio_blk *vblk =3D vq->vdev->priv;
> +	struct virtblk_ctrl_request *creq;
> +	unsigned long flags;
> +	unsigned int len;
> +
> +	spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
> +	do {
> +		virtqueue_disable_cb(vq);
> +		while ((creq =3D virtqueue_get_buf(vq, &len)) !=3D NULL) {
> +			bool drained =3D false;
> +			bool abandoned =3D creq->abandoned;
> +
> +			if (WARN_ON_ONCE(!vblk->ctrl_vq.inflight)) {
[ ... ]
> +			if (drained)
> +				complete(&vblk->ctrl_vq.drained);
> +			if (abandoned) {
> +				kfree(creq->compl);
> +				kfree(creq);
> +			} else {
> +				complete(creq->compl);
> +			}
> +			spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
> +		}
> +	} while (!virtqueue_enable_cb(vq));
> +	spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
> +}

[Severity: Medium]
Is there a race condition here that could lead to a memory leak of both
the request and completion structs?

If a request times out exactly as the device completes it, the IRQ thread
might read creq->abandoned as false, unlock the spinlock, and get
preempted.

Meanwhile, virtblk_ctrl_vq_request() wakes up from the timeout, acquires
the lock, sets creq->abandoned to true, unlocks, and returns -ETIMEDOUT.

When the callback resumes, it checks its local abandoned variable (which
is still false) and calls complete(creq->compl) instead of freeing the
memory. Because the caller already discarded the pointer upon timeout,
both creq and compl would be permanently leaked.

[ ... ]
> +/* Submit a control-queue request and wait for completion. */
> +static int virtblk_ctrl_vq_request(struct virtio_blk *vblk,
[ ... ]
> +	if (wait_for_completion_timeout(comp, VIRTBLK_CTRL_VQ_TIMEOUT)) {
> +		mutex_unlock(&vblk->ctrl_vq.mutex);
> +		kfree(comp);
> +		return 0;
> +	}
> +
> +	/*
> +	 * The host hasn't responded within the timeout. @creq is still
> +	 * owned by the device, so don't touch its DMA-target fields or
> +	 * free it here. Mark it abandoned and hand ownership of both @creq
> +	 * and @comp to whichever of virtblk_ctrlq_callback() or
> +	 * virtblk_ctrl_vq_drain() retrieves the buffer later; unlock the
> +	 * mutex so subsequent requests aren't serialized behind an
> +	 * unresponsive host.
> +	 */
> +	spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
> +	creq->abandoned =3D true;
> +	spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
> +	mutex_unlock(&vblk->ctrl_vq.mutex);
> +
> +	dev_warn(&vblk->vdev->dev,
> +		 "control queue request timed out, abandoning\n");
> +	return -ETIMEDOUT;
> +}

[Severity: High]
This timeout path is where the CPU writes to the shared cacheline while
the DMA operation might still be in flight. Does this trigger the DMA
coherency violation mentioned above for struct virtblk_ctrl_request?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920122444.2549=
493-1-linlin.zhang@oss.qualcomm.com?part=3D1
