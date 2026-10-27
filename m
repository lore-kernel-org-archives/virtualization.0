Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060089;
	b=qLuMwMohKXXONosXoMeKqsQ7DH/Oylb5xE87UBlCU9ks8Gd/P1z8aopGIQrh9+JJENDk
	 q6j6+7dSPEaCK7rQi50RYYXBlDwfFbD3GkvYBYLvg0MY7mwhsaOc71ZYjkTG0+I124Gqo
	 UouoVZCIHW8RbGvwNEXQvVWl8txUov/pl6Ge2k3bBbEqgWscCQDAIFYxhAetA+mOkFEKl
	 WBqruDMCRKMT+QyyWWr0gfaEvLOdyHeMvnjq5GjFH8abwAHN1ouFdd9lBkBBtyDUwvcmI
	 uB+S1dMBxDH1Wbi0tPr46N/yCbuj9xcObaelzn66qpuoQwUBlCP+kyqMwiI9oPupHpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060089;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=up9RA6MS8Cb9k+yhfWajVJ/mcCpysfBsdVOugCf4uDA=;
	b=GqZk+tLGyfVgKShWqteH0xVhBuLfLocx8jSy/nCgmNteBfmFN6e5EAQm+Ocq+Yv9kGER
	 yx/TKYqKIdQlZUGhUbx5hggwAdt6gT/gt85WlVEvIbAAr7Ju3bLgUFBnM4kjZj/UoRt4P
	 PQU9xx51HseQ2rF96srefl82YKVKtdkWUXOo41gfYXxePT6fYN2PllPKYN4UMSEx5GYoj
	 9kOZI2a3WkkcVvFTi5JX9jBnnmkfnezNu3wFWK63FWa1FtJiiIRurWuNOSmoqjKKjeWis
	 f59bocxpZZklHOP0HI9zAM3AfJej8KLz37ZzyAXMWoyhAFb+iOFqHdf7Nl/Z9u3midw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZeNpWqT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00ED606A31A
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 00:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZeNpWqT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46B21F01825;
	Tue, 27 Oct 2026 00:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793060088;
	bh=up9RA6MS8Cb9k+yhfWajVJ/mcCpysfBsdVOugCf4uDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gZeNpWqTVW6usJ3uJjyMeK/jXy0v/ug5rMvoM8kR+D8KH++ZEZrMP+6g3n2yahoVp
	 YojoxItr/4Sz0g/XeshzykKITS++fVn6XyxrtxwrnQt8RSorLEctWVF3B4+Twfm4WC
	 jC6QsVuH0IVDC9mYulhlV9EDRfBfCJcqa2rk3jlWu0SW3UVA0XbV9ngRzXu294hfOz
	 CJiU9SSlDDodjH/YTgaVCWVoYFIeigquCfhalJQleOPb47N3W4Af45uVd+TXU4Huwm
	 v5wtw3P8VG+z60MKfAOZMUODvus6RZ9dytoeeH9FaZQnyVdm+6F/CBv4p6H3jgdxEn
	 wdwnlIn8LalLw==
Message-ID: <sashiko-outbox-185929@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] virtio_balloon: submit reported pages as
 individual buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, ojeda@kernel.org, gary@garyguo.net, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <02257263433b001cd0a55a52486857df81dd4246.1793057483.git.mst@redhat.com>
References: <32e21059adb6cb1fd08c3f4426a313c77cf450ec.1793057483.git.mst@redhat.com>
 <02257263433b001cd0a55a52486857df81dd4246.1793057483.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 00:14:47 +0000
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
- [High] virtio_balloon: infinite spin in virtballoon_free_page_report() on=
 broken vq
- [Medium] virtio_balloon: callback toggle side effects in wait_event() con=
dition
--

commit bced8a77808ca2850eb132d7f72c3d6fc5ae5935
Author: Michael S. Tsirkin <mst@redhat.com>

virtio_balloon: submit reported pages as individual buffers

This commit submits each reported free page as an individual virtqueue buff=
er
rather than a single scatter-gather chain to avoid exceeding the virtio 4 G=
iB
descriptor chain limit. To prevent interrupt storms from per-page buffers, =
it
disables reporting virtqueue callbacks at initialization and uses
virtqueue_enable_cb_delayed_max() while waiting for completion in
virtballoon_free_page_report().

> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index ab3e3d887e00f..0a331acf2c8ef 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -205,25 +205,53 @@ static int virtballoon_free_page_report(struct page=
_reporting_dev_info *pr_dev_i
>  	struct virtio_balloon *vb =3D
>  		container_of(pr_dev_info, struct virtio_balloon, pr_dev_info);
>  	struct virtqueue *vq =3D vb->reporting_vq;
> -	unsigned int unused, err;
> +	unsigned int i, err =3D 0;
> =20
>  	/* We should always be able to add these buffers to an empty queue. */
> -	err =3D virtqueue_add_inbuf(vq, sg, nents, vb, GFP_NOWAIT);
> +	for (i =3D 0; i < nents; i++) {
> +		struct scatterlist one;
> =20
> -	/*
> -	 * In the extremely unlikely case that something has occurred and we
> -	 * are able to trigger an error we will simply display a warning
> -	 * and exit without actually processing the pages.
> -	 */
> -	if (WARN_ON_ONCE(err))
> -		return err;
> +		sg_init_table(&one, 1);
> +		sg_set_page(&one, sg_page(&sg[i]), sg[i].length,
> +			    sg[i].offset);
> +		err =3D virtqueue_add_inbuf(vq, &one, 1, &sg[i], GFP_NOWAIT);
> =20
> -	virtqueue_kick(vq);
> +		/*
> +		 * In the extremely unlikely case that something has occurred
> +		 * and we are able to trigger an error we will simply display
> +		 * a warning and exit without actually processing the pages.
> +		 */
> +		if (WARN_ON_ONCE(err)) {
> +			nents =3D i;
> +			break;
> +		}
> +	}
> =20
> -	/* When host has read buffer, this completes via balloon_ack */
> -	wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
> +	if (nents) {
> +		unsigned int unused;
> =20
> -	return 0;
> +		virtqueue_kick(vq);
> +
> +		/* When host has read buffer, this completes via balloon_ack. */
> +		i =3D 0;
> +		wait_event(vb->acked, ({
> +			for (;;) {
> +				virtqueue_disable_cb(vq);
> +				while (virtqueue_get_buf(vq, &unused))
> +					i++;
> +
> +				/* Stop waiting if device used all that we added. */
> +				if (i >=3D nents)
> +					break;
> +
> +				if (virtqueue_enable_cb_delayed_max(vq))
> +					break;
> +			}
> +			i >=3D nents;
> +		}));

[Severity: High]
Can this inner for (;;) loop spin indefinitely in kernel workqueue context
when vq->broken becomes true before all nents buffers are drained?

In page_reporting_process() -> page_reporting_process_zone() ->
page_reporting_cycle() -> virtballoon_free_page_report(), if the device mar=
ks
buffers as used in the ring and vq->broken becomes true before all nents
buffers are consumed (either because virtqueue_get_buf() encounters a bad
descriptor and calls BAD_RING(), or because virtio_break_device() runs
concurrently during surprise removal or reset), virtqueue_get_buf() returns
NULL without advancing vq->last_used_idx or incrementing i.

Because i < nents, the loop then calls virtqueue_enable_cb_delayed_max(vq).
Unlike virtqueue_enable_cb_delayed(), which checks vq->broken:

drivers/virtio/virtio_ring.c:virtqueue_enable_cb_delayed() {
	struct vring_virtqueue *vq =3D to_vvq(_vq);

	if (vq->event_triggered)
		data_race(vq->event_triggered =3D false);

	if (unlikely(vq->broken))
		return true;
...
}

virtqueue_enable_cb_delayed_max() omits that check:

drivers/virtio/virtio_ring.c:virtqueue_enable_cb_delayed_max() {
	struct vring_virtqueue *vq =3D to_vvq(_vq);

	if (vq->event_triggered)
		data_race(vq->event_triggered =3D false);

	return VIRTQUEUE_CALL(vq, enable_cb_delayed_max);
}

When unconsumed used entries remain in the ring,
virtqueue_enable_cb_delayed_max_split() and
virtqueue_enable_cb_delayed_max_packed() both return false on every call:

drivers/virtio/virtio_ring.c:virtqueue_enable_cb_delayed_max_split() {
...
	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.used->idx)
						- vq->last_used_idx) > bufs)) {
		END_USE(vq);
		return false;
	}
	return true;
}

drivers/virtio/virtio_ring.c:virtqueue_enable_cb_delayed_max_packed() {
...
	if (is_used_desc_packed(vq, used_idx, wrap_counter)) {
		END_USE(vq);
		return false;
	}
	return true;
}

As a result, neither break condition in the for (;;) loop is ever met, and =
the
thread spins in a tight non-sleeping loop inside the wait_event() condition
rather than sleeping as noted in the commit message. Also, should
virtqueue_enable_cb_delayed_max_split() read used->idx via
vring_read_split_used_idx(vq) instead of a plain access?

[Severity: Medium]
Does placing virtqueue_disable_cb() and virtqueue_enable_cb_delayed_max()
inside the wait_event() condition cause unintended callback state changes w=
hen
wait_event() evaluates the condition multiple times?

In include/linux/wait.h, wait_event() evaluates the condition once before
calling __wait_event(), and ___wait_event() calls prepare_to_wait_event()
followed immediately by a second evaluation of the condition before calling
schedule():

include/linux/wait.h:wait_event() {
	might_sleep();
	if (condition)
		break;
	__wait_event(wq_head, condition);
}

When the host has not yet consumed all nents buffers on the first check,
virtqueue_enable_cb_delayed_max(vq) clears VRING_AVAIL_F_NO_INTERRUPT in
vq->split.avail_flags_shadow, sets vq->event_triggered =3D false, writes
vring_used_event =3D vq->last_used_idx + bufs, and issues virtio_store_mb().

Immediately afterwards, before sleeping in schedule(), the second condition
check in ___wait_event() runs virtqueue_disable_cb(vq):

drivers/virtio/virtio_ring.c:virtqueue_disable_cb_split() {
	if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
		vq->split.avail_flags_shadow |=3D VRING_AVAIL_F_NO_INTERRUPT;

		if (vq->event_triggered)
			return;

		if (vq->event)
			/* TODO: this is a hack. Figure out a cleaner value to write. */
			vring_used_event(&vq->split.vring) =3D 0x0;
...
}

Because the first check enabled callbacks and vq->event_triggered is still
false, virtqueue_disable_cb_split() writes vring_used_event =3D 0x0 into sh=
ared
ring memory while the kicked device is actively processing buffers, right
before virtqueue_enable_cb_delayed_max(vq) overwrites it again. When
vq->last_used_idx =3D=3D 0 (for example, on the first reporting batch after=
 probe
or on 16-bit wrap), transiently writing vring_used_event =3D 0x0 while the
device processes the first buffer (used->idx advancing from 0 to 1) satisfi=
es
vring_need_event(0x0, 1, 0) on the host and triggers an immediate interrupt=
 on
the first page. The same double evaluation also happens on any wakeup of the
shared vb->acked waitqueue from inflate_vq or deflate_vq.

In addition, on a packed virtqueue, when vring_interrupt() fires and sets
vq->event_triggered =3D true, waking wait_event() runs
virtqueue_disable_cb_packed(vq):

drivers/virtio/virtio_ring.c:virtqueue_disable_cb_packed() {
	if (vq->packed.event_flags_shadow !=3D VRING_PACKED_EVENT_FLAG_DISABLE) {
		vq->packed.event_flags_shadow =3D VRING_PACKED_EVENT_FLAG_DISABLE;

		if (vq->event_triggered)
			return;

		vq->packed.vring.driver->flags =3D
			cpu_to_le16(vq->packed.event_flags_shadow);
	}
}

Because vq->event_triggered is true, virtqueue_disable_cb_packed() updates
event_flags_shadow to VRING_PACKED_EVENT_FLAG_DISABLE and returns early
without updating vq->packed.vring.driver->flags in shared memory. When
i >=3D nents then breaks out of the loop without calling
virtqueue_enable_cb_delayed_max(vq), driver->flags remains
VRING_PACKED_EVENT_FLAG_DESC after virtballoon_free_page_report() returns, =
and
subsequent virtqueue_disable_cb(vq) calls become no-ops because
event_flags_shadow is already VRING_PACKED_EVENT_FLAG_DISABLE.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/32e21059adb6cb1fd08=
c3f4426a313c77cf450ec.1793057483.git.mst@redhat.com?part=3D2
