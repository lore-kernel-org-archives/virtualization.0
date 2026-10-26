Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028249;
	b=4gdO5Ib73c2KddmIaud2iqfbfigqtaU0c/uuLuNJ8OFOSchJAwyzBkcOkpJLUoIn6wlz
	 25EF1JLuAyxkue9gVLpZIl7MfT6HG9K/KR5g6x6tpLVNLu8VXg9uxuMJGctjAx/ilpq4O
	 h1r6jk4/LXvPPs72IjFUFNl8NwJUJyTckTGDYhcxNCZGRBXMYIKS7DZrnjxgQuaHULV76
	 DanuhYpXqUru6TvnD1SMFSSjIYuavj9yEgKfni9IGq3JmpUDGe2US8pJvHBXa7RVEyhI/
	 tiW4WIGxb7Cf0rTlBFooxqJBit7wNxa7gCaWil0XL8a+krC1+d1YIAoDLGE75cXZTTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028249;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OK5kK482LwyZoDLbSM24uPB8wFUyBj/HMOVMqXxvc5U=;
	b=ft0YfntYryjpJoYwlMu5sik9udBLTMXklwHTbqe+ZoSFFLXXT2lLwrSbz747wMQMpkOA
	 BbcYq6QqsCyrQU0X5LXghN+Ui5CRQ/alMegUrZBleym3s/y5tRPp2cFlRee0ZD1zzDMw/
	 K+4LeFzQH/wJgGaI4MCO+rL4KLnW2aMUNJZ1zUAcgXfRB1IEOffl4LXbp0i3Ae9ZjlrJn
	 jyo2rMEx2kAICezv7SXGUEBz8dxZc60i0r+FPXZNkKOsDDFFBlJP0+UfwpjU2kKdMut2Y
	 JPe7vKpxVIM/4n//y+2GjcI0ueCjK0Y6oSOGElrZ+9Zu0TMgum5p4EBP+e3bABvpiRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HilUSFKD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B671D606A31B
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HilUSFKD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141A01F01829;
	Mon, 26 Oct 2026 15:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793028248;
	bh=OK5kK482LwyZoDLbSM24uPB8wFUyBj/HMOVMqXxvc5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HilUSFKD4Egcq0/FHXBe0nlAV5wpOEZUWfGNORKBFTxUySM2JxN0XO3D9jnXxCcI+
	 ZsTvxkXZy8R8V9+wTkQo8yzYFAtOMwhYQkHHWAbQTf9gS8SxCIalRVBRq0KDcThija
	 74ZRdRjXUheMQW+DtKAJBGpfjB0G0DlhCgvRlX2RN/bQZWxPWoYQrkuXDs0JGlcCYX
	 I45G58iAzhj58JVfR8Ab9/x6SjGisSoZSwcVoxl+nrhLRwjIQIgtHpp+fktlWeYLt4
	 dmjy6y8sjmvEbhO2czUOOaJv5L86FtXrlkslXJzR80llJrUiVVJLH58KrDVj+XOO8B
	 bMy0WH3XO7zJg==
Message-ID: <sashiko-outbox-185432@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] virtio_balloon: submit reported pages as individual
 buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, ojeda@kernel.org, gary@garyguo.net, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <6668d51dbda117d05d2eddd47db6ad69baab8b0c.1793026707.git.mst@redhat.com>
References: <ad6a530f49c4a0e182112a73789e31b5e91f3bb7.1793026707.git.mst@redhat.com>
 <6668d51dbda117d05d2eddd47db6ad69baab8b0c.1793026707.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 15:24:07 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] virtio: off-by-one in virtqueue_enable_cb_delayed_max() hangs page=
 reporting
- [Medium] virtio_balloon: broken callback suppression in virtballoon_free_=
page_report()
--

commit e2548c4b5befc523db0e3106c2a724d4255859e6
Author: Michael S. Tsirkin <mst@redhat.com>

virtio_balloon: submit reported pages as individual buffers

This commit submits each reported page in virtballoon_free_page_report() as=
 a
separate virtqueue buffer instead of a single scatter-gather descriptor cha=
in
to avoid exceeding the virtio specification's 2^32 byte limit. It uses
virtqueue_enable_cb_delayed_max() and virtqueue_disable_cb() around
wait_event() when draining the buffers.

> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index ab3e3d887e00f..64999f05f9f1d 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -205,25 +205,47 @@ static int virtballoon_free_page_report(struct page=
_reporting_dev_info *pr_dev_i

[ ... ]

> -	/* When host has read buffer, this completes via balloon_ack */
> -	wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
> +	if (nents) {
> +		virtqueue_kick(vq);
> =20
> -	return 0;
> +		/* When host has read buffer, this completes via balloon_ack.
> +		 * We report pages as individual buffers, so arm the callback
> +		 * to only interrupt once all the queued buffers have been
> +		 * used: otherwise we would get one interrupt per page.
> +		 */
> +		for (i =3D 0; i < nents; i++) {
> +			unsigned int unused;
> +
> +			virtqueue_enable_cb_delayed_max(vq);

[Severity: High]
Can calling virtqueue_enable_cb_delayed_max(vq) here cause wait_event() to
hang indefinitely when VIRTIO_RING_F_EVENT_IDX is negotiated?

In drivers/virtio/virtio_ring.c, virtqueue_enable_cb_delayed_max_split()
computes the event index as:

    bufs =3D (u16)(vq->split.avail_idx_shadow - vq->last_used_idx);

    virtio_store_mb(vq->weak_barriers,
                    &vring_used_event(&vq->split.vring),
                    cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx + bufs));

    if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.used->i=
dx)
                                    - vq->last_used_idx) > bufs)) {
            END_USE(vq);
            return false;
    }

In include/uapi/linux/virtio_ring.h, vring_need_event() checks:

    static inline int vring_need_event(__u16 event_idx, __u16 new_idx, __u1=
6 old)
    {
            return (__u16)(new_idx - event_idx - 1) < (__u16)(new_idx - old=
);
    }

Because event_idx is 0-based, an interrupt is triggered when used->idx
(new_idx) advances to event_idx + 1. When bufs buffers are queued at ring
slots last_used_idx .. last_used_idx + bufs - 1, consuming all queued buffe=
rs
advances used->idx to last_used_idx + bufs.

By setting vring_used_event to last_used_idx + bufs instead of
last_used_idx + bufs - 1, when the device finishes consuming all queued
buffers (new_idx =3D=3D event_idx), (__u16)(new_idx - event_idx - 1) underf=
lows
to 0xffff and vring_need_event() returns false. In addition, the race check
tests (used->idx - last_used_idx) > bufs, which can never be true since the
device cannot consume more than the bufs available buffers.

Similarly, in virtqueue_enable_cb_delayed_max_packed():

    bufs =3D vq->packed.vring.num - vq->vq.num_free;
    last_used_idx =3D READ_ONCE(vq->last_used_idx);
    wrap_counter =3D packed_used_wrap_counter(last_used_idx);

    used_idx =3D packed_last_used(last_used_idx) + bufs;
    if (used_idx >=3D vq->packed.vring.num) {
            used_idx -=3D vq->packed.vring.num;
            wrap_counter ^=3D 1;
    }

    vq->packed.vring.driver->off_wrap =3D cpu_to_le16(used_idx |
            (wrap_counter << VRING_PACKED_EVENT_F_WRAP_CTR));

This sets driver->off_wrap to packed_last_used(last_used_idx) + bufs
(next_avail_idx, one descriptor past the last queued descriptor) instead of
the last queued descriptor. Since that descriptor is not available to the
device, the device never marks it used and never interrupts, hanging the
page_reporting_process() -> page_reporting_cycle() ->
virtballoon_free_page_report() worker in wait_event().

> +			wait_event(vb->acked,
> +				   virtqueue_get_buf(vq, &unused));
> +			virtqueue_disable_cb(vq);
> +		}
> +	}

[Severity: Medium]
Does ordering virtqueue_enable_cb_delayed_max(), virtqueue_get_buf(), and
virtqueue_disable_cb() this way defeat the delayed callback suppression?

There appear to be three issues with the callback state machine in
virtballoon_free_page_report():

1. Reporting virtqueue callbacks are enabled by default in init_vqs(), and
virtqueue_kick(vq) is called before callbacks are disabled or delayed, so t=
he
device is notified while interrupts are still armed for the first buffer.

2. Inside the loop, virtqueue_enable_cb_delayed_max(vq) is called before
wait_event(vb->acked, virtqueue_get_buf(vq, &unused)). Because callbacks are
enabled when virtqueue_get_buf() runs, virtqueue_get_buf_ctx_split() (and
update_last_used_idx_packed() for packed rings) overwrites the delayed event
threshold on every dequeued buffer with the very next single buffer:

    vq->last_used_idx++;
    /* If we expect an interrupt for the next entry, tell host
     * by writing event index and flush out the write before
     * the read in the next get_buf call. */
    if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT))
            virtio_store_mb(vq->weak_barriers,
                            &vring_used_event(&vq->split.vring),
                            cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx)=
);

3. When an interrupt fires, vring_interrupt() sets vq->event_triggered =3D =
true.
After wait_event() wakes and virtqueue_get_buf() writes
vring_used_event =3D vq->last_used_idx, the subsequent virtqueue_disable_cb=
(vq)
call hits the early return in virtqueue_disable_cb_split() (and similarly in
virtqueue_disable_cb_packed()):

    if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
            vq->split.avail_flags_shadow |=3D VRING_AVAIL_F_NO_INTERRUPT;

            /*
             * If device triggered an event already it won't trigger one ag=
ain:
             * no need to disable.
             */
            if (vq->event_triggered)
                    return;

            if (vq->event)
                    /* TODO: this is a hack. Figure out a cleaner value to =
write. */
                    vring_used_event(&vq->split.vring) =3D 0x0;

This leaves vring_used_event armed at vq->last_used_idx in the shared ring =
at
the end of the batch, so the next call to virtballoon_free_page_report()
kicks the virtqueue with interrupts armed for the first buffer.

Should callbacks be kept disabled while draining available buffers with
virtqueue_get_buf(), only arming virtqueue_enable_cb_delayed_max() when
virtqueue_get_buf() returns NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ad6a530f49c4a0e1821=
12a73789e31b5e91f3bb7.1793026707.git.mst@redhat.com?part=3D2
