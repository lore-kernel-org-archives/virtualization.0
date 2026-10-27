Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059838;
	b=hfoxHU95wBQsjN8Z1s0KWSiWCNWp/+e18x4JLJ2Rl2kv421ebT4az4B0PRUu9xOyLzke
	 OQqw+XfX+ZqxqAUlFbK3e0Txmmr9qk4yodIpwdfA79J9eS4t2U1WKogwswDlIpcB/wnZj
	 K/NM4Xh4Ljc20Y6/4DiIrCKZBjVwphxix/9En8rYca00cKrwWCdB1dnc6oFpPOittR4Lh
	 w1NGo7sfyX7GuB47jljhU/ClpZeHIxI66CLFrMhZkbG7umBUe9MMgL+KFtEhMGzJYs1ed
	 IjhITsb/UJ/qu2LJ8NJV/prWVSZnwfQnbsMa4LIZ7IwKnbi9TrQAaILUy43gkMl7Lsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059838;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PELL1e11/LvnJitbLWB0wfS17wVMS9eK3z+fjoEDltw=;
	b=fPsu2fWStEoZpg/acQyyF79X+fRFyztHfCnzPv/0ETCgEnTP+cSQSb2X1yHEgHiis8Is
	 Oyc7/BVqX36DFryoZkgx0qDN1FOkwOsZ6x5Q2dEYwUcHfAcCbDH1KFQNXJFdSPBjh2sQd
	 j9XVOYEURas7pgvaQgs6fvIkHZUhBuDQX1jJXBoQIMWlBWl15Qvz7SZypuKMpoopYBC5R
	 TeQ1CsLeHRDVG/4f4de+lhsHO0i777e4v7g2OWIiXxHiYNudGMnx1YIjTyASSatlmehy+
	 wJKC57eRusXd4P8XyVMQ638mM2inYJHT82LuLM0A6TQdSjXcYjzFTDmzb+C9+Lk13Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wv6SyTkM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474AC606A31A
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 00:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wv6SyTkM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38A81F01825;
	Tue, 27 Oct 2026 00:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793059837;
	bh=PELL1e11/LvnJitbLWB0wfS17wVMS9eK3z+fjoEDltw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wv6SyTkMWhexDANBiteo3u6ve0X1On6lOZsbemDSoZt6cCnUR0SUHxpq3WCn+XXLg
	 W24W8bLcEZfO9WILkjj5ono5JQEsQRx7ihlpgrX0VEKwX/51lHFzakFx0l0kf4/RL3
	 qgCfCF//3MffA+z5T2BWGQoglS/zz+qMm10CEchqD8lGWKA7Pdqknl4hYdfnoy5ugw
	 3TtKsGtqynjjQMyDVMFfbHFDFDJdEXA3D5ypQlzsB2h5dDoMFL6B0R5z0ML+pUqfKy
	 Xgs+m1gqW52XPZdespgsJNsXCo8f7T3tbgyDSzmKIrVFo036LOjHiFWZ0zgW/ia7cd
	 3En6HiYFKhsSQ==
Message-ID: <sashiko-outbox-185882@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] virtio_ring: add virtqueue_enable_cb_delayed_max
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <32e21059adb6cb1fd08c3f4426a313c77cf450ec.1793057483.git.mst@redhat.com>
References: <32e21059adb6cb1fd08c3f4426a313c77cf450ec.1793057483.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 00:10:37 +0000
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
- [High] virtio_ring: u16 underflow in virtqueue_enable_cb_delayed_max() wh=
en empty
- [High] virtio_ring: wrong used check in virtqueue_enable_cb_delayed_max_p=
acked()
- [High] virtio_ring: missing broken check in virtqueue_enable_cb_delayed_m=
ax()
- [Low] virtio_ring: missing READ_ONCE() in virtqueue_enable_cb_delayed_max=
_split()
--

commit 3f9c8ee0d4b1a9cf9ff6d7ca78fdc78d2db0aa97
Author: Michael S. Tsirkin <mst@redhat.com>

virtio_ring: add virtqueue_enable_cb_delayed_max

This commit introduces virtqueue_enable_cb_delayed_max() to place the used
event at the last currently queued buffer so the device only notifies the
driver once the entire queued batch has been used.

> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index db678f5a80e03..06cb2964590d5 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c

[ ... ]

> @@ -1165,6 +1166,43 @@ static bool virtqueue_enable_cb_delayed_split(stru=
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
> +	/* Point the used event one entry before the last queued buffer:
> +	 * the device signals when it passes the event, so this makes it
> +	 * notify us exactly once it has used everything. */
> +	bufs =3D (u16)(vq->split.avail_idx_shadow - vq->last_used_idx) - 1;
> +
> +	virtio_store_mb(vq->weak_barriers,
> +			&vring_used_event(&vq->split.vring),
> +			cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx + bufs));

[Severity: High]
Can bufs underflow in virtqueue_enable_cb_delayed_max_split() when a caller
invokes virtqueue_enable_cb_delayed_max() after draining all queued buffers
with virtqueue_get_buf() so vq->split.avail_idx_shadow =3D=3D vq->last_used=
_idx?

When no buffers are in flight, bufs evaluates to 0xffff, which sets
vring_used_event(&vq->split.vring) to vq->last_used_idx - 1 (delaying device
notifications until 65,536 buffers have been used) and makes the subsequent
(u16)(... - vq->last_used_idx) > bufs check impossible to satisfy.

The same u16 underflow also happens in
virtqueue_enable_cb_delayed_max_packed() when vq->vq.num_free =3D=3D
vq->packed.vring.num:

drivers/virtio/virtio_ring.c:virtqueue_enable_cb_delayed_max_packed() {
	if (vq->event) {
		bufs =3D vq->packed.vring.num - vq->vq.num_free - 1;
		last_used_idx =3D READ_ONCE(vq->last_used_idx);
		wrap_counter =3D packed_used_wrap_counter(last_used_idx);

		used_idx =3D packed_last_used(last_used_idx) + bufs;
		if (used_idx >=3D vq->packed.vring.num) {
			used_idx -=3D vq->packed.vring.num;
			wrap_counter ^=3D 1;
		}

		vq->packed.vring.driver->off_wrap =3D cpu_to_le16(used_idx |
			(wrap_counter << VRING_PACKED_EVENT_F_WRAP_CTR));
}

When packed_last_used(last_used_idx) is 0, used_idx becomes 0xffff and
subtracting vq->packed.vring.num once leaves an out-of-range descriptor
offset with bit 15 (VRING_PACKED_EVENT_F_WRAP_CTR) still set, corrupting
vq->packed.vring.driver->off_wrap. When packed_last_used(last_used_idx) > 0,
used_idx wraps in u16 arithmetic to packed_last_used(last_used_idx) - 1,
skipping the wrap_counter toggle and pointing driver->off_wrap at an
already-used descriptor with the wrong wrap counter.

> +
> +	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.used->i=
dx)
> +						- vq->last_used_idx) > bufs)) {

[Severity: Low]
Should virtqueue_enable_cb_delayed_max_split() use
vring_read_split_used_idx(vq) here instead of reading
vq->split.vring.used->idx directly?

vq->split.vring.used->idx is concurrently written by the device in shared
memory, and commit 32fe1de5c124 ("virtio_ring: Add READ_ONCE annotations for
device-writable fields") updated virtqueue_enable_cb_delayed_split() to use
vring_read_split_used_idx(vq) to avoid KCSAN data-race warnings and compiler
load optimizations.

[ ... ]

> @@ -2391,6 +2429,68 @@ static bool virtqueue_enable_cb_delayed_packed(str=
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
> +		/* Point the event one entry before the last queued buffer:
> +		 * the device signals when it passes the event, so this
> +		 * makes it notify us exactly once it has used everything. */
> +		bufs =3D vq->packed.vring.num - vq->vq.num_free - 1;
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
Why does virtqueue_enable_cb_delayed_max_packed() overwrite used_idx and
wrap_counter with last_used_idx here instead of checking the target descrip=
tor
at last_used_idx + bufs?

In virtqueue_enable_cb_delayed_max_split(), the function returns false only
once all queued buffers up through bufs have been used. Here, after arming
vq->packed.vring.driver->off_wrap for the end of the batch at + bufs, the
post-barrier check tests the very first unconsumed descriptor at
last_used_idx. If the device has completed the first buffer while the rest =
of
the batch is still in flight, virtqueue_enable_cb_delayed_max_packed() will
return false even though the notification is only armed for the last buffer,
causing callers waiting on the batch to busy-poll instead of sleeping.

In addition, packed_in_order_ops wires .enable_cb_delayed_max to
virtqueue_enable_cb_delayed_max_packed(). With VQ_LAYOUT_PACKED_IN_ORDER, t=
he
device writes only a single used descriptor for an entire in-order batch and
leaves intermediate descriptors untouched (tracked via
vq->batch_last.id !=3D UINT_MAX in more_used_packed_in_order()). If a caller
partially drains an in-order batch, last_used_idx points to an unwritten
intermediate descriptor where is_used_desc_packed() returns false even when
all buffers have already been completed, which can cause the caller to sleep
forever waiting for an interrupt that will never arrive.

[ ... ]

> @@ -3278,6 +3382,29 @@ bool virtqueue_enable_cb_delayed(struct virtqueue =
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
What happens in virtqueue_enable_cb_delayed_max() if vq->broken becomes true
while used buffers are still present in the ring?

When a device is broken (via virtio_break_device() or BAD_RING()),
virtqueue_get_buf_ctx_split() and virtqueue_get_buf_ctx_packed() immediately
return NULL without advancing vq->last_used_idx.

Commit 0d0eff39ceb3 ("virtio_ring: fix infinite loop in virtnet_poll_cleantx
when device is broken") added a vq->broken check to
virtqueue_enable_cb_delayed():

drivers/virtio/virtio_ring.c:virtqueue_enable_cb_delayed() {
	struct vring_virtqueue *vq =3D to_vvq(_vq);

	if (unlikely(vq->broken))
		return true;
}

Without the same check in virtqueue_enable_cb_delayed_max(), won't callers
polling in a loop spin forever because virtqueue_get_buf() returns NULL whi=
le
virtqueue_enable_cb_delayed_max() repeatedly sees the unconsumed used entri=
es
and returns false?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/32e21059adb6cb1fd08=
c3f4426a313c77cf450ec.1793057483.git.mst@redhat.com?part=3D1
