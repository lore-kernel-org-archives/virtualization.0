Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245538;
	b=u5aLcGg1uUfqma0d7AEMg5p8JPO6VCcP3/zo0ei8dQtMCMmgdv7mCGimu4rFFe8vPZwr
	 Eeit8vYnDcraJKBcwvGDgR9KjT6E47ISeiPufL/2qCZRqVnygnZHnyxhdmYcddI3yV4ph
	 KLjwb/HGZseWIc3Dr5YjGYJmLVTKclOU1J67rtSUKv8UQwHztj/+LogK5Gp8IudjbT0xs
	 Z7+YSil423cjfKeqobb97++lZX3KAgnvG1XFc5MY8EQmO9du+kVghlJS/ozldoK5oqRA/
	 oF/4AnDqpw/Vckjl/lLLCNRF4uoW/Clg8WT4EvtO3c+t/nEM9CNlwXwnf83DAp1ZtRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245538;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4ASn7NVUUnGxxx0coa/6cFc+dndnPMXB7kDNOtBE0cc=;
	b=mnJIOVIY2s54nSdKaWcbtzkr3XQ5azV3MGGpd8qvCo+Nt0ZF3NKUgwmtbaTYq/tTJJob
	 HivlK1H7fUrC2JDEhJsfd290EsWsxNs831GtOw61Vgdh7hQwjgY4R2VpEmcBjlex2HkcX
	 UxSI3pdRmYBkTwH/rRaf4YCTKnhUp2ovXjsGvxasIfmn6qCnlMBWXrQoOPBPlQmILjGjS
	 VfS/euBmYMJ0DPOxS7H24c9lL+fcr5m+FUNLNuEPHSLm2LK6nfpH/uaPEov6pwPOUi99A
	 7yt3U75BQEz3z0rLae/ejkOHbmTjKAhAITFwUNdS/GFjsydr7YciBhiEiQQx4JYuvkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MbuGmaso;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEF4606A320
	for <virtualization@lists.linux.dev>; Sat, 21 Nov 2026 07:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MbuGmaso
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121B31F000CA;
	Sat, 21 Nov 2026 07:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795245538;
	bh=4ASn7NVUUnGxxx0coa/6cFc+dndnPMXB7kDNOtBE0cc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MbuGmasoMT9bFnPTiu/0n/i3hjhewyXDnjuwkKy9XsepJ6FIjKy1qgxKh+Bxz9Y+H
	 eGHIRBZGxwHXUhqCQlM2Ghz8Ewl26GuYVIgjko4vGUZqXYCuiF/haK88hiZb6VgpT2
	 swyjdsjSLzxXWckNgmgY1EcM1x15V2qgi8dZr1j3tCWysvO3NPbvIzrCexBDnEc/zG
	 /3GEQ5hZClZmHnvUPWyhDg4v/OByGvl2iLdE/w9MN4hVw96HnXo85LVmPlqk6hed2W
	 5jQpOh18kka6x3e5zV/PT7Zstbijgn/KHFPH19PvNNa3u3VEN/X22L+rfh/0khsXNy
	 ddLZ2TWWjyLVA==
Message-ID: <sashiko-outbox-226756@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] virtio: add virtqueue_get_last_used_idx() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Tang" <lange_tang@163.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261120071826.198604-2-lange_tang@163.com>
References: <20261120071826.198604-1-lange_tang@163.com>
 <20261120071826.198604-2-lange_tang@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 07:18:57 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] virtio_ring: 4-byte WRITE_ONCE() on u16 last_used_idx in
  tools/virtio
- [Medium] virtio_ring: virtqueue_get_last_used_idx() misses in-order
  batch buffers
- [Medium] virtio: virtqueue_get_last_used_idx() ignores maintainer API
  objection
--

commit e3f548bc724c634761028f08e7565898a68423a0
Author: Longjun Tang <tanglongjun@kylinos.cn>

virtio: add virtqueue_get_last_used_idx() helper

This commit adds a virtqueue_get_last_used_idx() helper to expose
vring_virtqueue's last_used_idx and converts the split-ring updates of
last_used_idx to use WRITE_ONCE().

> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f683a2d6a2002..e8af6d5c6432b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1005,7 +1005,7 @@ static void *virtqueue_get_buf_ctx_split(struct vri=
ng_virtqueue *vq,
>  	/* detach_buf_split clears data, so grab it now. */
>  	ret =3D vq->split.desc_state[i].data;
>  	detach_buf_split(vq, i, ctx);
> -	vq->last_used_idx++;
> +	WRITE_ONCE(vq->last_used_idx, vq->last_used_idx + 1);
>  	/* If we expect an interrupt for the next entry, tell host
>  	 * by writing event index and flush out the write before
>  	 * the read in the next get_buf call. */
> @@ -1072,7 +1072,7 @@ static void *virtqueue_get_buf_ctx_split_in_order(s=
truct vring_virtqueue *vq,
>  	ret =3D vq->split.desc_state[last_used].data;
>  	detach_buf_split_in_order(vq, last_used, ctx);
> =20
> -	vq->last_used_idx++;
> +	WRITE_ONCE(vq->last_used_idx, vq->last_used_idx + 1);
>  	vq->last_used +=3D (vq->vq.num_free - num_free);

[Severity: Medium]
Does WRITE_ONCE(vq->last_used_idx, vq->last_used_idx + 1) perform a 4-byte
store into the 2-byte u16 last_used_idx field when compiled under
tools/virtio/?

Because vq->last_used_idx + 1 undergoes integer promotion to int, the
userspace WRITE_ONCE() stub in tools/virtio/linux/compiler.h casts the
destination pointer to typeof(val) * (4 bytes):

tools/virtio/linux/compiler.h:
#define WRITE_ONCE(var, val) \
	(*((volatile typeof(val) *)(&(var))) =3D (val))

In struct vring_virtqueue, u16 last_used_idx is immediately followed by
u16 last_used, so a 4-byte write clobbers vq->last_used right before
virtqueue_get_buf_ctx_split_in_order() increments it (and on big-endian
hosts writes zero into vq->last_used_idx in virtqueue_get_buf_ctx_split()).
Casting the value to u16 (or fixing the tools/virtio/ macro to use
typeof(var)) avoids the out-of-bounds write.

> @@ -3236,6 +3236,20 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigne=
d int last_used_idx)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
> =20
> +/**
> + * virtqueue_get_last_used_idx - get the ring's last consumed position
> + * @_vq: the struct virtqueue we're talking about.
> + *
> + * Returns: the vring_virtqueue's last_used_idx.
> + */
> +unsigned int virtqueue_get_last_used_idx(const struct virtqueue *_vq)
> +{
> +	const struct vring_virtqueue *vq =3D to_vvq(_vq);
> +
> +	return READ_ONCE(vq->last_used_idx);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_get_last_used_idx);

[Severity: Medium]
Can passing virtqueue_get_last_used_idx() to virtqueue_poll() falsely
report no pending used buffers when VIRTIO_F_IN_ORDER is negotiated?

When a device completes a multi-buffer batch in order, it only writes the
batch's single used entry (or the first descriptor on a packed ring), and
virtqueue_get_buf_ctx_{split,packed}_in_order() caches the end of the batch
in vq->batch_last.id while advancing vq->last_used_idx on each detached
buffer.  If the driver stops consuming mid-batch (for example, when NAPI
exhausts its budget), vq->batch_last.id is not UINT_MAX, yet
virtqueue_poll() only inspects the ring at last_used_idx where the device
wrote no descriptor flag or used entry, returning false while unconsumed
buffers remain in the batch:

drivers/virtio/virtio_ring.c:more_used_packed_in_order() {
	if (vq->batch_last.id !=3D UINT_MAX)
		return true;

	return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
}

[Severity: Medium]
As reported by Michael S. Tsirkin on v1 [1], is exposing last_used_idx
through virtqueue_get_last_used_idx() an appropriate public virtio API given
that packed virtqueues do not have a used ring and encode both the
descriptor index and VRING_PACKED_EVENT_F_WRAP_CTR wrap counter in
vq->last_used_idx?

[1] https://lore.kernel.org/r/20261112174936-mutt-send-email-mst@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120071826.1986=
04-1-lange_tang@163.com?part=3D1
