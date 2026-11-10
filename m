Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303834;
	b=5M5N36N3Kpub8dT3AIOIDyoYhJ1ViYn/XfOa22zMN8pX+/gjZGB14iAmr3DBFpOXVVAG
	 L5CvyFkXuItH56kAsmLVKBnq9aU4vGyLoo59/FONv9eM5KMraxZudiSjqOwUCNuor5WSx
	 3S7UAX3I+APWW5iMVj0qOaEn3brtjwxwKH0rRCOU+HQvbyfsfBl9amGN58Fn6BGNrqdBl
	 inrxZ/hulbb8ADPQiCF5qIhTbyeodLsJ3sM7vu+jZDlhaU+mmfRM89Hcnr9R4+1vUVl9Y
	 P+QoTJUy97+x5vaH3AuBwgEzpdEj+KPTLpY2Zb/KXkXaFONDPAIwGVmemKu/xTgysIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303834;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CfwMumRCTh2DwrZZZoNE9EhbLcaRVi2Tz0MOgDKzPXQ=;
	b=vJ4uUuANKcSBS7FgzhpAZOK3kHW9uYB0KFhRxYgX3VZRaSbSA754ydD6cZnALaQ7kTFc
	 8srvV2tDqf8LQMW6uNIuEox26Gd3EhWPkeRZ7oOUUinME+48FEnud+l+ndsis/siFQ/+y
	 C3TP3be0+SewFZKyortlSoqYX6sqZaWyeNeikxxtRaTL3LhT3Z1DGw2PEvVGWGTUwYJb6
	 07uLFykBq19ivOFSHZshdRyAxnf37v99Qo60Fvid7E6gY0R5zoF7soLBzCzvJWOzQSdms
	 JGxjjub3cuVlYsdz2GOOPbw/hLDZHDA0aHLpE7LW+doT7wsXGiK1gba1P0p1b+XAFQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XDnFTut6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043B1606BF00
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XDnFTut6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A1D1F0089F;
	Tue, 10 Nov 2026 09:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794303833;
	bh=CfwMumRCTh2DwrZZZoNE9EhbLcaRVi2Tz0MOgDKzPXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XDnFTut6Axng7rDOAgzcJE34RMoagUGXA9OXcgCA63X8/7MnuF/adXihCHRe858d+
	 F9FcE+SSyQ0oH7iRIf4wEX+ggd3DULfcgqQ7nWj3eONp7508FxQnWPEctVgcPbqHrm
	 iR5+y8de4ylrMv8m6YPJvpV6xn2sOeGRR894uSB0KY3VbI7P1CTSZbN20ZPQK1sxUv
	 bj/O4p88Z8o/AOjsKQ4SaCofk+Mz39lb1vAhHgmbGGoKjXsQOvOWWPdQ8YFLuSkhW2
	 DgpmL7bgjhMrrPeM1CMJa2oTsqq16FS2Az4VXbV7hrKFmdH9q4CtP8OwgOwdsuiezt
	 x6MT81jMvTFHA==
Message-ID: <sashiko-outbox-206797@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] virtio: add virtqueue_get_last_used_idx() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Longjun Tang" <lange_tang@163.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109094310.103979-2-lange_tang@163.com>
References: <20261109094310.103979-1-lange_tang@163.com>
 <20261109094310.103979-2-lange_tang@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:43:52 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] virtio_ring: 4-byte WRITE_ONCE() on u16 last_used_idx in
  tools/virtio
- [Medium] virtio_ring: virtqueue_get_last_used_idx() misses in-order
  batch buffers
--

commit e72b0bb03b2a71f4d30e308519407a5817a43cd2
Author: Longjun Tang <tanglongjun@kylinos.cn>

virtio: add virtqueue_get_last_used_idx() helper

This commit adds virtqueue_get_last_used_idx() to read vq->last_used_idx
and updates split ring buffer detachment to write vq->last_used_idx using
WRITE_ONCE().

> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f683a2d6a2002..f5f592de9ed59 100644
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
Does WRITE_ONCE(vq->last_used_idx, vq->last_used_idx + 1) corrupt the
adjacent u16 last_used field when drivers/virtio/virtio_ring.c is built
under tools/virtio/?

In struct vring_virtqueue, u16 last_used_idx is immediately followed by
u16 last_used.  The expression vq->last_used_idx + 1 promotes to int
(4 bytes), and tools/virtio/linux/compiler.h defines WRITE_ONCE() using
typeof(val):

tools/virtio/linux/compiler.h:
#define WRITE_ONCE(var, val) \
	(*((volatile typeof(val) *)(&(var))) =3D (val))

In tools/virtio builds, both WRITE_ONCE() calls perform a 4-byte store to
&vq->last_used_idx, overwriting vq->last_used right before
virtqueue_get_buf_ctx_split_in_order() increments it (and failing to
update vq->last_used_idx on big-endian hosts).  Casting the value to u16
or fixing the tools/virtio stub to use typeof(var) would avoid the
4-byte store.

[ ... ]

> @@ -3236,6 +3236,20 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigne=
d int last_used_idx)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_poll);
> =20
> +/**
> + * virtqueue_get_last_used_idx - get the last consumed used ring index
> + * @_vq: the struct virtqueue we're talking about.
> + *
> + * Returns the index of the most recently consumed used buffer.
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
report no pending buffers when VIRTIO_F_IN_ORDER is negotiated?

On a packed in-order ring, the device only writes the first descriptor of
a completed batch, and virtqueue_get_buf_ctx_packed_in_order() caches the
batch end in vq->batch_last.id while advancing vq->last_used_idx to the
next descriptor in the batch:

drivers/virtio/virtio_ring.c:more_used_packed_in_order() {
	if (vq->batch_last.id !=3D UINT_MAX)
		return true;

	return virtqueue_poll_packed(vq, READ_ONCE(vq->last_used_idx));
}

Because the intermediate descriptors in the batch do not have their USED
flag updated by the device, virtqueue_poll() (which dispatches to
virtqueue_poll_packed() without checking vq->batch_last.id) returns false
whenever a batch has been partially consumed, such as when NAPI poll stops
mid-batch after exhausting its budget.

Also, the kernel-doc says this returns the index of the most recently
consumed used buffer, whereas vq->last_used_idx is the next index to be
consumed and, for packed rings, also packs the wrap counter in bit
VRING_PACKED_EVENT_F_WRAP_CTR, matching the opaque token returned by
virtqueue_enable_cb_prepare().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109094310.1039=
79-1-lange_tang@163.com?part=3D1
