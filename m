Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940232FF675
	for <virtualization@lists.linux.dev>; Mon, 14 Sep 2026 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394534; cv=none; b=SNbnPo84q1N0gGH8niZhveQ8eKmz7u2YQLIyQKMYPVmssoEyDp4E67WfO0jD7MIznU3vqApy/PTuR3h9Ugzug2VYpBwl/ABtAjJIidHLMhVS3MA+rJDPe/Zbi0EaWtDZoW/5tGSPpOMi0X++cxKtqBL9elxtOqOvf8vyupNts+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394534; c=relaxed/simple;
	bh=agV8SyH5yX6KXIBb61kaelzrAdbijvKEYCJYtfNOERk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rPmmRAl3YMpG0Q/bqILTdJe0Li7V2lo5wEtUv/FQNUfHouO7+P58EhPpREvfuRLZ/ye7nYCnmFUJihjRfPvnQaXnNVIZM31OzstYaS6I4l+Kijh8fNxcy+s5GJAhc0wVOW5LF3JyeXWXcbhMafjxV2SNZiMK+uYtXbjokO65UJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blmGHSCQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blmGHSCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398941F000FF;
	Mon, 14 Sep 2026 14:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789394533;
	bh=RqkPKX37YkVMRMBEVPQMdu/HaTOmRQaqYJle9cqfIf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=blmGHSCQiDKpdrxCkKq6pJauMsHOKjZbTz68u0B28P0BVRfXR6VxvY84qhZocgHB0
	 u6MjsImKkv1qEcZhZHe8/JqlOJc1kq5yTC6n/TDKqbSYRIHlVscvnheCDp6Bsk/GtF
	 /I6BnamREoi+xNKrSn7MimCrQ8WguqDbO6vGg78wLKjbpARFYHh5nxXbiaLWFPfmo7
	 UIUZPyWN3jp5W25yhUnb1rk72ECI6FV6R6jlxQLZpTv087Krv6aju0+d10JsLH/AjR
	 eyW5z+DM/GjvLiCopamr2VUfbMD5TyyD8EUnFnElw08eOcGzOnn7bK9IMr1aifu5Oi
	 u+eEevtDnHyjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] virtio_blk: Add control virtqueue support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linlin Zhang" <linlin.zhang@oss.qualcomm.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260914133733.15429-2-linlin.zhang@oss.qualcomm.com>
References: <20260914133733.15429-1-linlin.zhang@oss.qualcomm.com>
 <20260914133733.15429-2-linlin.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:02:12 +0000
Message-Id: <20260914140213.398941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] DMA cacheline sharing causes memory corruption on non-coherent arc=
hitectures.
- [High] Erroneous teardown ordering causes valid in-flight requests to fai=
l with I/O errors during suspend.
- [High] Unbounded wait in `virtblk_ctrl_vq_request` deadlocks device teard=
own if the host is unresponsive.

Pre-existing issues:
- [High] Use-after-free and double-free of `vblk` in the `virtblk_probe` er=
ror path.
--

commit 36271d203fcaee50a88fd7b53aa73dbbba25cf7c
Author: linlzhan <linlin.zhang@oss.qualcomm.com>

virtio_blk: Add control virtqueue support

This commit adds support for the optional virtio-blk control virtqueue.
It allows the driver to manage control-queue requests independently from
the data path, preparing for subsequent inline encryption implementation.

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
[ ... ]
> @@ -110,6 +123,12 @@ struct virtblk_req {
>  	struct scatterlist sg[];
>  };
> =20
> +struct virtblk_ctrl_request {
> +	__virtio32 type;
> +	u8 status;
> +	struct completion compl;
> +};

[Severity: High]
Is it safe to place DMA targets (type, status) and CPU synchronization
primitives (struct completion compl) in the same struct without cacheline
alignment?

On non-coherent architectures, could the DMA API unmap operation invalidate
the cacheline and destroy the CPU's unwritten modifications to compl.wait,
thereby corrupting the waitqueue? Buffers that are targets of DMA typically
need to be cacheline-aligned or physically separated from CPU-modified
lock/sync primitives.

[ ... ]
> +static int virtblk_ctrl_vq_request(struct virtio_blk *vblk,
> +				    struct virtblk_ctrl_request *creq,
> +				    struct scatterlist *sgs[],
> +				    unsigned int out_sgs, unsigned int in_sgs)
> +{
[ ... ]
> +	wait_for_completion(&creq->compl);
> +	mutex_unlock(&vblk->ctrl_vq.mutex);
> +	return 0;
> +}

[Severity: High]
Could this unbounded wait deadlock device teardown if the host is
unresponsive?

When called from a block I/O context, this thread holds a reference to
q_usage_counter. If the host hangs, del_gendisk() in virtblk_remove() will
freeze the block queue and wait indefinitely for q_usage_counter to reach
zero.

Since virtblk_ctrl_vq_drain() is called after del_gendisk(), wouldn't the
system deadlock before the drain can recover the stuck requests?

[ ... ]
> @@ -1553,6 +1713,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  out_free_vq:
>  	vdev->config->del_vqs(vdev);
>  	kfree(vblk->vqs);
> +	vblk->ctrl_vq.vq =3D NULL;
>  out_free_vblk:
>  	kfree(vblk);
>  out_free_index:

[Severity: High]
This is a pre-existing issue, but does the error path in virtblk_probe()
trigger a use-after-free and double-free?

If device_add_disk() fails, the path jumps to out_cleanup_disk which calls
put_disk(vblk->disk). Because vblk->disk->fops points to virtblk_fops,
dropping the last reference invokes virtblk_free_disk(), which frees vblk
and vblk->index.

By the time execution reaches out_free_vq, aren't accesses to vblk->vqs and
this new assignment to vblk->ctrl_vq.vq writing to freed memory, followed
by a double free of vblk in out_free_vblk?

[ ... ]
> @@ -1593,6 +1759,8 @@ static int virtblk_freeze_priv(struct virtio_device=
 *vdev)
>  	struct request_queue *q =3D vblk->disk->queue;
>  	unsigned int memflags;
> =20
> +	virtblk_ctrl_vq_quiesce(vblk);
> +
>  	/* Ensure no requests in virtqueues before deleting vqs. */
>  	memflags =3D blk_mq_freeze_queue(q);

[Severity: High]
By calling virtblk_ctrl_vq_quiesce() before blk_mq_freeze_queue(), could
valid in-flight requests fail with I/O errors?

virtblk_ctrl_vq_quiesce() sets ctrl_vq.dead =3D true. Since the block queue
is not yet frozen, in-flight block I/O requests that haven't yet submitted
their control requests (but have already incremented q_usage_counter) will
encounter dead =3D=3D true when calling virtblk_ctrl_vq_request(), resultin=
g in
-ENODEV.

Should the data plane be frozen before the control queue is marked dead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914133733.1542=
9-1-linlin.zhang@oss.qualcomm.com?part=3D1
