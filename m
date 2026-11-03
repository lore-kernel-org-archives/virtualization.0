Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697950;
	b=BtP9GThuhMWDuFuKLAx/WX5NOSMPb7gCTv57LKEEat5DAzsQiwKmHbIfJ7NW+IsLgO0b
	 NT5+T/Ml4GBHTGDP2WbSlqlaB0e+LuEAt19UPi+ysk/uFVIVpDdjGbz5bUYURqsFB1qXx
	 krainTdZ1hDtX89MVXr2y/rE4xAP4p8lUTk7kx2vnAcQWsUWxjG1QZ01jYhKkItG3R+oG
	 GTJP3Je8kn6Uiy3hv53IceGjW/TXvbx5LGlwGcyhhx3SbTIAetnZUstcVu3gI2fdFpmmh
	 rPxbt+jOGY6ezDZwDIW0VVhDJRDNw0Cyn+4A2u6LtlyYrVW4Z8bMXNWW99TiD8aET6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697950;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/y5mUW6F/xjp6oVhSbACwYe+x2qmHH4wrUSBgUqKVgg=;
	b=mPyqjku3B5NWKTfAAh1o7s4yt/GNFXWIs/lNnpl9ObzvZiiPdQM74cJC+/3ZWniJG+vQ
	 f5diNQW1D6471zW77FxitHrM8Um7f+uAbNs+3TznGioqrQwowd5DupD3TRsbr7ALwtycI
	 RUTSRDun1eDOziRn6Tt+ZKIvMy3zIU+fLvbba1+czWG4WpvL7B7H8ws2OAzoGWL4YYoIY
	 CbEYjEKxNcck+DE7MP3HKrIKmM9RZWVXkFid3P1hxaWxEMH8ihrzNr5QX4sKxHPWzRA0L
	 VaKV/h+4M9P/G8GYvHEW0fs5kbhoSRDeQEsGs0OcPu4amKtI5qSFDFUOGFFwzzstEKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddqbRQHS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A1B606A32C;
	Tue,  3 Nov 2026 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddqbRQHS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263E11F0093A;
	Tue,  3 Nov 2026 09:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793697949;
	bh=/y5mUW6F/xjp6oVhSbACwYe+x2qmHH4wrUSBgUqKVgg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ddqbRQHSNJO0nP7/Sd6ZDRBVOXsRkbwjOAMimM3pVKVSbFg5p4vptVkXCvIoPtg+a
	 eO3FZ9T5neiZK65+hNgSqNF64bprcj8smZNEYYCsQfrIp27Tad+Lf+c2Me6/Nz9f16
	 FEGvFP5bzr+r9S9hBxdIpzlV821QdCJnAKJ1cA5pDaBxQOJP4oiflk/WZSl+12Nd1Q
	 KbnGTTSDV4t0wkAAXsIJ8SltfunPZ/oob0fr0CqIj/2MoH65TgMVJCwXTmEqjP9PeZ
	 B6tMNUXDWcE8jU5sEA8F3D0/uLf+sfIqUeTLF+dPtIZHdRouAi2W8+vWLOV6kasVdI
	 bz+/o/cwHPptQ==
Message-ID: <sashiko-outbox-194954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 03/12] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103080821.16983-4-mynameisjune111@gmail.com>
References: <20261103080821.16983-1-mynameisjune111@gmail.com>
 <20261103080821.16983-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 09:25:48 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ALSA: virtio: NULL deref in virtsnd_disable_event_vq() on probe fa=
ilure
--

commit dbe53b6c2e9b3ca5c54f2da85fde0a3fdaa123b3
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Retain queued messages through device reset

This commit retains the control queue through snd_card_free() during device
teardown, detaches remaining virtqueue buffers after device reset, and
protects virtqueue callbacks under their respective queue locks.

> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
> index 6f35276416fed..aec4959c973ca 100644
> --- a/sound/virtio/virtio_card.c
> +++ b/sound/virtio/virtio_card.c

[ ... ]

> @@ -174,8 +188,9 @@ static void virtsnd_disable_event_vq(struct virtio_sn=
d *snd)
>  	struct virtio_snd_event *event;
>  	u32 length;
> =20
> +	guard(spinlock_irqsave)(&queue->lock);
> +	snd->event_vq_enabled =3D false;
>  	if (queue->vqueue) {
> -		guard(spinlock_irqsave)(&queue->lock);
>  		virtqueue_disable_cb(queue->vqueue);
>  		while ((event =3D virtqueue_get_buf(queue->vqueue, &length)))
>  			virtsnd_event_dispatch(snd, event);

[Severity: High]
Can virtsnd_disable_event_vq() dereference a NULL pointer when cleaning up
after a failure in virtsnd_probe()?

In virtsnd_probe(), virtsnd_find_vqs() populates the event virtqueue with
buffers while snd->event_vq_enabled is still false, and virtio_device_ready=
()
marks the device live before virtsnd_build_devs() creates the ALSA objects:

sound/virtio/virtio_card.c:virtsnd_probe() {
	...
	rc =3D virtsnd_find_vqs(snd);
	if (rc)
		goto on_exit;

	virtio_device_ready(vdev);

	rc =3D virtsnd_build_devs(snd);
	if (rc)
		goto on_exit;

	virtsnd_enable_event_vq(snd);

on_exit:
	if (rc)
		virtsnd_remove(vdev);
	...
}

Because VIRTIO_CONFIG_S_DRIVER_OK is set before virtsnd_build_devs(), the
device can place events into the event queue while virtsnd_build_devs() is
running. With this change, virtsnd_event_notify_cb() sees
!snd->event_vq_enabled and leaves those events in the ring.

If virtsnd_build_devs() fails before virtsnd_enable_event_vq() is reached
(for example, after virtsnd_kctl_parse_cfg() sets snd->nkctls and allocates
snd->kctls, but before virtsnd_kctl_build_devs() populates each kctl->kctl),
virtsnd_probe() calls virtsnd_remove() -> virtsnd_disable_event_vq().

Since virtsnd_disable_event_vq() unconditionally drains queue->vqueue and
calls virtsnd_event_dispatch() without checking whether snd->event_vq_enabl=
ed
was true, dispatching a pending event against partially initialized state
(such as passing &kctl->kctl->id to snd_ctl_notify() in virtsnd_kctl_event()
when kctl->kctl is NULL) will dereference a NULL pointer.

Should virtsnd_disable_event_vq() only drain and dispatch events if
snd->event_vq_enabled was previously true?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103080821.1698=
3-1-mynameisjune111@gmail.com?part=3D3
