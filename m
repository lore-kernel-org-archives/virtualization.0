Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B04BBA45
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 03:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789097066; cv=none; b=PoDQp4Z9qKBLEoz8SpLzrXgFXrJ6lGtCCanVlsnQAQY79/MzC/yOOaSgYWB4hYEb03b9ed678pNH4R9wFzUV7OKBQ47+e2GZJBH+mPbKq8riMeSEQGVsjD17Ox5zm9qOvZkgvoItnl8IbrlXbv3Kgqhp8+wqncqPMZGoN8V7SXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789097066; c=relaxed/simple;
	bh=EF+sTk8Se8kmAADF0SBgG1PpVZlQ/krB6pwzvAYvRzs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a3ZNFitkRuB2Iwt860BU+q2saCPB0Z/fOqhE1gVsggTUSuHISu8aBlFM8X+RbLV9J8Nkhzxihih2BYFvIhyk0TzimjAmrXUmMYGhozBQh8xaNpAphSHDnYOA8digjFgS7h0us2F/Wf+4Q6JaPtfPudfUKBQwniMxwL3efc1pfrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKnZDznH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKnZDznH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B411F000FF;
	Fri, 11 Sep 2026 03:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789097064;
	bh=qgCT0K+FCIJRoP7Jl2QZ80LztYurtM0+NLEvwQm9sPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EKnZDznHR1ibW0HtEEgzPF9pSzd1MxzLuznAiXVsCLKPOFy92ck970tnaNpvvzZeP
	 irqku+EkG+Rn7JArEiCJ0Yp3AjfgYZ6mXyMEtjQ79omY7/IXbfFeg/fLfwzxjsHFNK
	 E2GjFC2yUAcWT7syYIu7sm+LyuMjPsujLJetuwq5Jrc+G6itqkIHZYrBZM+z6xljUp
	 wToHPz55GnbfNwbjjzzCWebHJ3H2V4vMuPnYQAuGbLP07S0+YT5CJ5OD2bWp23Hthi
	 JofyFU6Wqf0RcEjmwrdLVtumGQl5Hfs25kV/5DM8deVTgtYIHMzuFfFKf4k8P6x6sF
	 SfjDEEi8WbzFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] ALSA: virtio: reset device before deleting
 virtqueues
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260911031121.1542502-1-oss.patchbox@gmail.com>
References: <20260911031121.1542502-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 03:24:24 +0000
Message-Id: <20260911032424.A2B411F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver permanently leaks DMA mappings for unused virtqueue buf=
fers because they are not detached before virtqueue deletion.
- [High] Prematurely cancelling and freeing pending control messages before=
 resetting the device leads to hardware Use-After-Free, list corruption, an=
d double frees.
--

commit a186967d39bb57120371bc04edb4ff625893e99e
Author: Yuho Choi <oss.patchbox@gmail.com>

ALSA: virtio: reset device before deleting virtqueues

This commit moves virtio_reset_device() before del_vqs() in driver
remove and freeze paths. This prevents the hardware from accessing
virtqueue memory after it has been freed.

> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
> index 647190f4d5afc..6f35276416fed 100644
> --- a/sound/virtio/virtio_card.c
> +++ b/sound/virtio/virtio_card.c
> @@ -354,8 +354,8 @@ static void virtsnd_remove(struct virtio_device *vdev)
>  	if (snd->card)
>  		snd_card_free(snd->card);
> =20
> -	vdev->config->del_vqs(vdev);
>  	virtio_reset_device(vdev);
> +	vdev->config->del_vqs(vdev);

[Severity: High]
This is a pre-existing issue, but does this permanently leak DMA mappings f=
or
unused virtqueue buffers because they are not detached before the virtqueues
are deleted?

System suspend/resume or driver unbinding will call virtsnd_freeze() or
virtsnd_remove(), which deletes the virtqueues without first detaching unus=
ed
buffers via virtqueue_detach_unused_buf().

Repeated suspend/resume cycles could continuously leak DMA mappings (such as
pending event buffers and PCM buffers) until the DMA space is exhausted.

> =20
>  	for (i =3D 0; snd->substreams && i < snd->nsubstreams; ++i) {
>  		struct virtio_pcm_substream *vss =3D &snd->substreams[i];

[ ... ]

> @@ -383,8 +383,8 @@ static int virtsnd_freeze(struct virtio_device *vdev)
>  	virtsnd_disable_event_vq(snd);
>  	virtsnd_ctl_msg_cancel_all(snd);

[Severity: High]
This is a pre-existing issue, but does prematurely cancelling and freeing
pending control messages here (and similarly in virtsnd_remove) before
resetting the device leave a window where the hardware can DMA to freed
memory?

For messages sent with nowait =3D true, virtsnd_ctl_msg_cancel_all() drops =
the
refcount to 0, immediately freeing the memory while the message is still
actively queued in the hardware virtqueue.

The device could then DMA write into the freed memory, or trigger an
interrupt where virtsnd_ctl_notify_cb() retrieves the freed pointer and cal=
ls
virtsnd_ctl_msg_complete() on it again, causing a double free.

> =20
> -	vdev->config->del_vqs(vdev);
>  	virtio_reset_device(vdev);
> +	vdev->config->del_vqs(vdev);
> =20
>  	for (i =3D 0; i < snd->nsubstreams; ++i)
>  		cancel_work_sync(&snd->substreams[i].elapsed_period);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911031121.1542=
502-1-oss.patchbox@gmail.com?part=3D1
