Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028265;
	b=3OsgtmSpWgvwBAJSf84MAIhmVD/BPwJ5PomPXssp4r0UtT/YQZCeEmNMqGOeb9t6cvQL
	 68PAiQGdUY73SQMies0wC980vXftqPccdLCh+6UvgdJq+znZOYniR19qUebY3Y6AdM3cy
	 7cLsr0TgdOCAeqycu8waXfmeCcJtKIfPJNGtccEVxjEDyHRZ7stee19dscX+YpQnwyiJp
	 8HMwHkqUCm1Zr7Co/3JW3HhGxqpThC6MNCDIcLptc79HyiTLOcjcsVTFgrvHMN4OrKUls
	 CH9vpcshFLa16DGNrQHxjkIQ4z44QRYOclu1Ju52L1bsm0p5dfU4HW+GTX+p+yVhx5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028265;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=I7GiPK6KUsoqxhNTDJTWSF8RukWR11xbnjNUwtaiIpc=;
	b=137Jds1zt+lYaJWwTLl89YE5UvsQ5JlZWRgNAwZGbQiC+HOxrIR7/gWCNtFseleEqXCV
	 pmF/E/Jr9H9DlDZmuXvebDnWxJH4fsLo72ItBTvV+Ecj5J+Pl/S+fCrI+0j2FfOY6xj+k
	 uSHtvf2bloD0u7gCbp4EGEKmCclbb3js78P1UOwzAGhmkxA38izL5YHsft+sJ9LzOs9Nm
	 GLMCcW0d0S5OLGXqJjHxIoYH7Sml6Vs9iyJj0BiccTyHv3etHhE1hv9qdV6odLR5Z4fSX
	 7KlwS98jEQKF3t2TB84FOZZjpHEY7CLWgDBASjfled2Swnve2h2z/uMhDpde1lWKVFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZaiODNYK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EC6606A31A
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZaiODNYK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202F81F01825;
	Mon, 26 Oct 2026 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793028264;
	bh=I7GiPK6KUsoqxhNTDJTWSF8RukWR11xbnjNUwtaiIpc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZaiODNYK12OiQCx6Lc5BR2A0PPOD4zfzQtli7OjKpSQ1D0M1AHWpx4OvHi0nvJ0Zw
	 UjxAOwS/cvzX51VMaoJmdnPkWiXAUgkpQHoJH9rv5141nm/S6F6oM76+gRAxSDcfLN
	 r6+5k/mhiJzzRYaDdhl8LsCsIi5xtcNIR1aO6CkK83QaMADpT5Xm8G7+vhArhoz+LD
	 F8Jss5JykjWoAjBkzUoQVFBdeYAHHNib+rQnDmPcWhP9GIgpgiATIcX3HIJ9YIo76S
	 cVDU0jiNX7pqw+6AYRSJlVizQtAGSHxdIw2SM0MGlsOiEqZH9l8R5SRu6JEf2ZEVu/
	 38NkKDkI5EUXg==
Message-ID: <sashiko-outbox-185433@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] virtio_ring: add virtqueue_enable_cb_delayed_max
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <ad6a530f49c4a0e182112a73789e31b5e91f3bb7.1793026707.git.mst@redhat.com>
References: <ad6a530f49c4a0e182112a73789e31b5e91f3bb7.1793026707.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 15:24:23 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] virtio_ring: off-by-one in virtqueue_enable_cb_delayed_max_split()
- [High] virtio_ring: off-by-one in virtqueue_enable_cb_delayed_max_packed()
- [High] virtio_ring: missing vq->broken check in virtqueue_enable_cb_delay=
ed_max()
- [Medium] virtio_ring: missing READ_ONCE() in virtqueue_enable_cb_delayed_=
max_split()
--

commit f77f0cd19bbfba432c2d11a8e7e8a7c7597a610a
Author: Michael S. Tsirkin <mst@redhat.com>

virtio_ring: add virtqueue_enable_cb_delayed_max

This commit introduces virtqueue_enable_cb_delayed_max(), which arms the
virtqueue callback with the used event placed at the last currently queued
buffer so that the device only notifies the driver once all queued buffers
have been used.

> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index db678f5a80e03..98b630fc6f8f6 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
[ ... ]
> @@ -1165,6 +1166,42 @@ static bool virtqueue_enable_cb_delayed_split(stru=
ct vring_virtqueue *vq)
>  	return true;
>  }
> =20
> +static bool virtqueue_enable_cb_delayed_max_split(struct vring_virtqueue=
 *vq)
> +{
> +	u16 bufs;
> +
> +	START_USE(vq);
> +
> +	/* We optimistically turn back on interrupts, then check if there was
> +	 * more to do. */
> +	/* Depending on the VIRTIO_RING_F_USED_EVENT_IDX feature, we need to
> +	 * either clear the flags bit or point the event index at the next
> +	 * entry. Always update the event index to keep code simple. */
> +	if (vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT) {
> +		vq->split.avail_flags_shadow &=3D ~VRING_AVAIL_F_NO_INTERRUPT;
> +		if (!vq->event)
> +			vq->split.vring.avail->flags =3D
> +				cpu_to_virtio16(vq->vq.vdev,
> +						vq->split.avail_flags_shadow);
> +	}
> +	/* Point the used event at the last queued buffer: the device
> +	 * will only notify us once it has used everything. */
> +	bufs =3D (u16)(vq->split.avail_idx_shadow - vq->last_used_idx);
> +
> +	virtio_store_mb(vq->weak_barriers,
> +			&vring_used_event(&vq->split.vring),
> +			cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx + bufs));
> +
> +	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.used->i=
dx)
> +						- vq->last_used_idx) > bufs)) {
> +		END_USE(vq);
> +		return false;
> +	}

[Severity: High]
Is there an off-by-one in how bufs and vring_used_event are computed in
virtqueue_enable_cb_delayed_max_split()?

Here bufs is set to (u16)(vq->split.avail_idx_shadow - vq->last_used_idx),
so vq->last_used_idx + bufs equals vq->split.avail_idx_shadow. Per the
virtio specification and vring_need_event():

include/uapi/linux/virtio_ring.h:vring_need_event() {
	return (__u16)(new_idx - event_idx - 1) < (__u16)(new_idx - old);
}

event_idx is 0-indexed and triggers a notification when used->idx (new_idx)
transitions from event_idx to event_idx + 1 (for example,
virtqueue_enable_cb_prepare_split() writes vq->last_used_idx + 0 to be
notified when the first buffer is used and used->idx reaches
vq->last_used_idx + 1). When the device consumes all queued buffers,
used->idx advances to vq->split.avail_idx_shadow. With event_idx also set
to vq->split.avail_idx_shadow, (u16)(new_idx - event_idx - 1) underflows to
0xffff, so vring_need_event() evaluates to false and the device never sends
an interrupt when the batch finishes.

In addition, in the post-barrier race check:

	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.used->idx)
						- vq->last_used_idx) > bufs)) {

because only bufs (avail_idx_shadow - last_used_idx) buffers have been made
available to the device in total, (u16)(used->idx - vq->last_used_idx) can
at most equal bufs when every queued buffer has been used and can never be
strictly greater than bufs. Even if the device already consumed all queued
buffers before vring_used_event or avail->flags was updated, this check
always evaluates to false and virtqueue_enable_cb_delayed_max_split()
returns true, causing callers to sleep forever waiting for a notification
that will never arrive.

[Severity: Medium]
Also in virtqueue_enable_cb_delayed_max_split(), should the read of
vq->split.vring.used->idx use vring_read_split_used_idx(vq) instead of
reading vq->split.vring.used->idx directly?

Commit 32fe1de5c124 ("virtio_ring: Add READ_ONCE annotations for
device-writable fields") introduced vring_read_split_used_idx(vq) to wrap
the lockless read of device-writable vq->split.vring.used->idx in
READ_ONCE(), which is what virtqueue_enable_cb_delayed_split() uses:

drivers/virtio/virtio_ring.c:virtqueue_enable_cb_delayed_split() {
    ...
	if (unlikely((u16)(vring_read_split_used_idx(vq)
					- vq->last_used_idx) > bufs)) {
    ...
}

> +
> +	END_USE(vq);
> +	return true;
> +}
[ ... ]
> @@ -2391,6 +2428,67 @@ static bool virtqueue_enable_cb_delayed_packed(str=
uct vring_virtqueue *vq)
>  	return true;
>  }
> =20
> +static bool virtqueue_enable_cb_delayed_max_packed(struct vring_virtqueu=
e *vq)
> +{
> +	u16 used_idx, wrap_counter, last_used_idx;
> +	u16 bufs;
> +
> +	START_USE(vq);
> +
> +	/*
> +	 * We optimistically turn back on interrupts, then check if there was
> +	 * more to do.
> +	 */
> +
> +	if (vq->event) {
> +		/* Point the event at the last queued buffer: the device
> +		 * will only notify us once it has used everything. */
> +		bufs =3D vq->packed.vring.num - vq->vq.num_free;
> +		last_used_idx =3D READ_ONCE(vq->last_used_idx);
> +		wrap_counter =3D packed_used_wrap_counter(last_used_idx);
> +
> +		used_idx =3D packed_last_used(last_used_idx) + bufs;
> +		if (used_idx >=3D vq->packed.vring.num) {
> +			used_idx -=3D vq->packed.vring.num;
> +			wrap_counter ^=3D 1;
> +		}
> +
> +		vq->packed.vring.driver->off_wrap =3D cpu_to_le16(used_idx |
> +			(wrap_counter << VRING_PACKED_EVENT_F_WRAP_CTR));
> +
> +		/*
> +		 * We need to update event offset and event wrap
> +		 * counter first before updating event flags.
> +		 */
> +		virtio_wmb(vq->weak_barriers);
> +	}
> +
> +	if (vq->packed.event_flags_shadow =3D=3D VRING_PACKED_EVENT_FLAG_DISABL=
E) {
> +		vq->packed.event_flags_shadow =3D vq->event ?
> +				VRING_PACKED_EVENT_FLAG_DESC :
> +				VRING_PACKED_EVENT_FLAG_ENABLE;
> +		vq->packed.vring.driver->flags =3D
> +				cpu_to_le16(vq->packed.event_flags_shadow);
> +	}
> +
> +	/*
> +	 * We need to update event suppression structure first
> +	 * before re-checking for more used buffers.
> +	 */
> +	virtio_mb(vq->weak_barriers);
> +
> +	last_used_idx =3D READ_ONCE(vq->last_used_idx);
> +	wrap_counter =3D packed_used_wrap_counter(last_used_idx);
> +	used_idx =3D packed_last_used(last_used_idx);
> +	if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
> +		END_USE(vq);
> +		return false;
> +	}

[Severity: High]
Won't virtqueue_enable_cb_delayed_max_packed() also place driver->off_wrap
one past the last queued descriptor and miss the completion interrupt?

When bufs =3D vq->packed.vring.num - vq->vq.num_free descriptors are queued,
they occupy offsets 0 through bufs - 1 starting from
packed_last_used(last_used_idx). Adding bufs to
packed_last_used(last_used_idx) sets used_idx to vq->packed.next_avail_idx
(with vq->packed.avail_wrap_counter), which is the next free descriptor
slot that has not been made available to the device.

With VRING_PACKED_EVENT_FLAG_DESC, the device notifies the driver when it
marks the descriptor at driver->off_wrap as used (for comparison,
virtqueue_enable_cb_prepare_packed() sets driver->off_wrap to
vq->last_used_idx, i.e. offset 0, to trigger when the first queued
descriptor is used). Because no descriptor is queued at next_avail_idx (and
if the last queued buffer is a multi-descriptor direct chain, the device
writes the used completion to the head descriptor of that chain), the
device stops at next_avail_idx without ever using the descriptor at
driver->off_wrap.

When the post-barrier check then tests is_used_desc_packed() at
packed_last_used(last_used_idx) and sees the first queued buffer is not yet
used, virtqueue_enable_cb_delayed_max_packed() returns true and the caller
sleeps forever waiting for an interrupt at next_avail_idx that never
arrives.

> +
> +	END_USE(vq);
> +	return true;
> +}
[ ... ]
> @@ -3278,6 +3380,29 @@ bool virtqueue_enable_cb_delayed(struct virtqueue =
*_vq)
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
> =20
> +/**
> + * virtqueue_enable_cb_delayed_max - callback for all queued buffers
> + * @_vq: the struct virtqueue we're talking about.
> + *
> + * Like virtqueue_enable_cb_delayed, but with VIRTIO_RING_F_EVENT_IDX
> + * the used event is placed at the last currently queued buffer, so the
> + * device only notifies us once it has used everything we queued.
> + *
> + * Returns "true" if the callback is armed and we can sleep waiting
> + * for the notification, or "false" if some buffers were already used
> + * and we should poll instead.
> + */
> +bool virtqueue_enable_cb_delayed_max(struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq =3D to_vvq(_vq);
> +
> +	if (vq->event_triggered)
> +		data_race(vq->event_triggered =3D false);
> +
> +	return VIRTQUEUE_CALL(vq, enable_cb_delayed_max);
> +}

[Severity: High]
Should virtqueue_enable_cb_delayed_max() check if (unlikely(vq->broken))
and return true, matching virtqueue_enable_cb_delayed()?

Commit 0d0eff39ceb3 ("virtio_ring: fix infinite loop in
virtnet_poll_cleantx when device is broken") added:

drivers/virtio/virtio_ring.c:virtqueue_enable_cb_delayed() {
	struct vring_virtqueue *vq =3D to_vvq(_vq);

	if (unlikely(vq->broken))
		return true;
    ...
}

because virtqueue_get_buf_ctx_split() and virtqueue_get_buf_ctx_packed()
immediately return NULL when vq->broken is true without detaching buffers
or advancing vq->last_used_idx. Without this check in
virtqueue_enable_cb_delayed_max(), if vq->broken becomes true while used
descriptors remain in the ring, a caller polling until
virtqueue_enable_cb_delayed_max() returns true will spin forever because
virtqueue_get_buf() returns NULL without advancing vq->last_used_idx while
virtqueue_enable_cb_delayed_max() repeatedly returns false.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ad6a530f49c4a0e1821=
12a73789e31b5e91f3bb7.1793026707.git.mst@redhat.com?part=3D1
