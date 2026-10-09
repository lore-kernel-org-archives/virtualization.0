Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63033BB689
	for <virtualization@lists.linux.dev>; Fri,  9 Oct 2026 04:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791520116; cv=none; b=Y3KE7WxcaoLulsg5yjgRtoO8nRw5vkO1gWr5CRx9YWsoErryicYVIwTLh51d87h4o6vF0ybfu+CWy6M4n1RutX4e4jQZjeuJdmke6WVyhzGO0EiTXmrMqfo8NrB7ajdR2eYDz0Yl5gHB1OhS+OafrKbhW0gqMVqxXgf4K+3ADzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791520116; c=relaxed/simple;
	bh=yYcAe96DFQ8kzSlWYVJc0afEYc7WWtymH/a8WFtB6H0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BZpGWwlRK4Y2htzNCs8Ri8s7oYc8dNSs4qwL6CjO4sfy1xg8kwPwyhyMpE1zPtwIp0DgogcaHNe/yK3TOQu0n86mk/O12I1bfPhn2/SFFrrsEsFfpJomTat1arOn2FcTBZ09OG0v9wzx+I+Aq7CR64cI7MxWgxPkUbng85V2sAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1ATqzsc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1ATqzsc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2244E1F00893;
	Fri,  9 Oct 2026 04:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791520108;
	bh=Twfj6V/503qRndPPRgFrkm4g3DeopDEOA1eDZYZAppo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X1ATqzsc3fStmCTTefYw0i+2pij0WOUbdVHLC12CwW5Diyms9XAv/8B2SysNluGrh
	 OGcd51eHrvhDMBjA0D5LHIDmejzvU1bH9Q1lcdqxuDjJAOqzEr3T0CxwWPZdaDZrdF
	 xtPkN1z/3fEQCy6qNMASUWn/c+KYwgm3YNzgFMlClKTo/BJOjf02jhxwewmmLZtMQa
	 BOY5VG1+LLF3EjeJrX2LpapEXXTie4STWQkUS5W/Ig8CF2Y9qtFOoLN3TNLSTyHO/z
	 bHBfNTXZO/fVmpRvPASY6EeXlES2aWX73AD47MnXcDo5ufoIke8hs7bMTCEawRupat
	 UdgyD+6riGN+Q==
Message-ID: <sashiko-outbox-164830@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] virtio_blk: Add control virtqueue support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linlin Zhang" <linlin.zhang@oss.qualcomm.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20261009041727.3170811-2-linlin.zhang@oss.qualcomm.com>
References: <20261009041727.3170811-1-linlin.zhang@oss.qualcomm.com>
 <20261009041727.3170811-2-linlin.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 04:28:27 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] block: NULL pointer dereference in virtblk_ctrl_vq_request on =
device removal
- [High] block: memory leak in virtblk_ctrl_vq_request due to timeout race
- [High] block: UAF and double free in virtblk_probe error path
- [Low] block: missing mutex_destroy on virtblk_probe error path
--

commit 4ba5fa6213a4ecb3d12630534388c763dd962458
Author: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Subject: virtio_blk: Add control virtqueue support

This patch adds support for the optional virtio-blk control virtqueue.
It allows the driver to manage control-queue requests independently
from the data path, preparing for a subsequent inline encryption
implementation.

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c8bfbf8435ac7..2499ae2fb9e22 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c

[ ... ]

> @@ -864,11 +898,181 @@ static int virtblk_getgeo(struct gendisk *disk, st=
ruct hd_geometry *geo)
> +static int virtblk_ctrl_vq_request(struct virtio_blk *vblk,
> +				    struct virtblk_ctrl_request *creq,
> +				    struct scatterlist *sgs[],
> +				    unsigned int out_sgs, unsigned int in_sgs)
> +{

[ ... ]

> +	if (wait_for_completion_timeout(&comp->done, VIRTBLK_CTRL_VQ_TIMEOUT)) {
> +		mutex_unlock(&vblk->ctrl_vq.mutex);
> +		kfree(comp);
> +		creq->compl =3D NULL;
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
> +	comp->abandoned =3D true;
> +	spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
> +	mutex_unlock(&vblk->ctrl_vq.mutex);

[Severity: High]
Could this leak memory if the request completes just as the timeout expires?

When wait_for_completion_timeout() expires, the waiter acquires ctrl_vq.lock
and sets comp->abandoned =3D true without checking if the completion was
already signaled.

If the hardware interrupt fires concurrently, virtblk_ctrlq_callback() might
run on another CPU before the lock is acquired, read abandoned as false,
call complete(), and skip freeing the memory. Since both paths assume the
other is responsible for cleanup during this specific race, the creq and
comp structures would be leaked permanently.

> +
> +	dev_warn(&vblk->vdev->dev,
> +		 "control queue request timed out, abandoning\n");

[Severity: Critical]
Is it safe to dereference vblk->vdev here without holding vdev_mutex?

If a request times out exactly as the device is being removed,
virtblk_remove() calls virtblk_ctrl_vq_quiesce(), which waits for the same
10-second timeout. When quiesce times out, it proceeds to reset the device,
drain the queue, and set vblk->vdev =3D NULL.

Meanwhile, this thread wakes up from the timeout, drops ctrl_vq.mutex (which
does not hold vdev_mutex), and dereferences vblk->vdev to log the warning.
Since vblk->vdev might have been cleared by the concurrent teardown, this
could cause a NULL pointer dereference.

> +	return -ETIMEDOUT;
> +}

[ ... ]

> @@ -1465,14 +1686,18 @@ static int virtblk_probe(struct virtio_device *vd=
ev)
>  	}
> =20
>  	mutex_init(&vblk->vdev_mutex);
> +	mutex_init(&vblk->ctrl_vq.mutex);
> +	spin_lock_init(&vblk->ctrl_vq.lock);
> =20
>  	vblk->vdev =3D vdev;
> =20
>  	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
> =20
>  	err =3D init_vq(vblk);
> -	if (err)
> +	if (err) {
> +		dev_err(&vdev->dev, "init virt queue failed: err =3D %d\n", err);
>  		goto out_free_vblk;
> +	}

[Severity: Low]
Does this error path miss destroying the newly initialized mutex?

mutex_init(&vblk->ctrl_vq.mutex) happens early in the probe sequence. If
init_vq() fails, the code jumps to out_free_vblk, which only calls
kfree(vblk). This bypasses mutex_destroy(), potentially leaking lockdep
tracking state when CONFIG_DEBUG_MUTEXES is enabled.

[ ... ]

> @@ -1554,6 +1779,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  out_free_vq:
>  	vdev->config->del_vqs(vdev);
>  	kfree(vblk->vqs);
> +	vblk->ctrl_vq.vq =3D NULL;
>  out_free_vblk:
>  	kfree(vblk);

[Severity: High]
Could this error path trigger a use-after-free and double free?

If an error occurs and the path jumps to out_cleanup_disk (just above this
diff snippet), the code calls put_disk(vblk->disk). Since the disk has a
refcount of 1 here, this drops it to 0, triggering the virtblk_free_disk()
callback which frees vblk.

Execution then falls through to blk_mq_free_tag_set(&vblk->tag_set), touches
the freed memory by assigning vblk->ctrl_vq.vq =3D NULL, and ultimately cal=
ls
kfree(vblk) again.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009041727.3170=
811-1-linlin.zhang@oss.qualcomm.com?part=3D1
