Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB18A48E0D3
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 05:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791870234; cv=none; b=FGWpsnnwONpcA9amxNFER58xSvJnZxgarCjrC9+xePu1Oe0KwfldI7l/Ps9DetIeGYUvkfssiQJPtUrTlbQQnv6UOz+jirb2ezN3jHRT9COyK9Ezg3S960Ki3jxYiM42AlQwNNwAt1gldyxbRXMjOcp+DrkO7riAG4EEiBFc14c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791870234; c=relaxed/simple;
	bh=eScr6PYhlgAsBmPDBDwYJzedHVqwx1LQ+PofJgpsy4g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ucPVA7SKLfTBXu78zywkWpGc0nnJSqqJNtrKsOk8OA0NWT871XjCHHpXGs9IW2Mlq6yGMvrkyID6Ksrd+QPsmZqyTfjmeJcu+qj9pi2AGP9lb7gyXxmFrAUnZQSl9lLk+tp6lPlAgcRww91THfmLDaMCBeUM3mcJRwKcjBRNups=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O92S+4J8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O92S+4J8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2289F1F000FF;
	Tue, 13 Oct 2026 05:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791870233;
	bh=/OrV9XmAMKM+qFPLRYl0vnmWMNpzytiKy9Tm6uS8goc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O92S+4J8RSSPViwpvFX+K7xvGC+z4dJyQmmqN3+oYRFIcCFMXO8gKvfqoLxmaYhoS
	 PKB5GLVImJmVlHHRzusQS/+sNmDr27l7AwrvI6OqerdmO1IMA12/puKyh1rXUIdFNc
	 LlDlVV1gmxX2KCPg+EnkDM7BWXmZrG47RsY8hGM26rBAovSrGH1Xkj3e9y/xRXWgj5
	 c1t3E/jUX+Z51QF9xheD/wsv7Pg6YZfUKURvP8kfYGNWhmdgxNLLy3SaKBddnzM9Gm
	 lPl7Q5ewRQbMJ5aPicANOCulQsYeUSKXXclTv5R3ZvMWNqFZeVsMk3m2pQMoPWZUKF
	 XoA/goqzsTrug==
Message-ID: <sashiko-outbox-169006@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/5] ALSA: virtio: Retain control requests through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <9d5a0ff360e66bc4ddd28aa790d617edc875e20b.1791867377.git.mynameisjune111@gmail.com>
References: <cover.1791867377.git.mynameisjune111@gmail.com>
 <9d5a0ff360e66bc4ddd28aa790d617edc875e20b.1791867377.git.mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 05:43:52 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] virtio_sound: DMA mapping leak from uncalled virtqueue_detach_un=
used_buf()
- [Low] cleanup: mixing goto and scoped_guard in virtsnd_ctl_msg_send()
--

commit 58ca5d3aaf697e12525c1d956e26244a616c7d76
Author: Joonho Lee <mynameisjune111@gmail.com>
ALSA: virtio: Retain control requests through device reset

This commit updates the virtio sound driver to handle control message teard=
own
by keeping references to messages through device reset. It marks messages
canceled under the queue lock and defers freeing them until the queue has b=
een
deleted.

> diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
> index 6f35276416fed..ed884327bb0ef 100644
> --- a/sound/virtio/virtio_card.c
> +++ b/sound/virtio/virtio_card.c
> @@ -349,13 +349,15 @@ static void virtsnd_remove(struct virtio_device *vd=
ev)
>  	unsigned int i;
> =20
>  	virtsnd_disable_event_vq(snd);
> -	virtsnd_ctl_msg_cancel_all(snd);
> =20
>  	if (snd->card)
>  		snd_card_free(snd->card);
> =20
> +	virtsnd_ctl_msg_cancel_all(snd);
> +
>  	virtio_reset_device(vdev);
>  	vdev->config->del_vqs(vdev);
> +	virtsnd_ctl_msg_cleanup(snd);

[Severity: Medium]
Does deleting the virtqueues here after reset without first detaching the
unused buffers leak pending DMA mappings? Because virtqueue_add_sgs() creat=
es
DMA mappings for these buffers, if they aren't drained with
virtqueue_detach_unused_buf() before del_vqs(), those mappings might not be
unmapped.

[ ... ]

> @@ -385,6 +387,7 @@ static int virtsnd_freeze(struct virtio_device *vdev)
> =20
>  	virtio_reset_device(vdev);
>  	vdev->config->del_vqs(vdev);
> +	virtsnd_ctl_msg_cleanup(snd);

[Severity: Medium]
Similarly, does suspending the device here destroy the virtqueues without
detaching and unmapping pending DMA buffers?


> diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
> index 6433c870f271a..3ad1e1e1b2054 100644
> --- a/sound/virtio/virtio_ctl_msg.c
> +++ b/sound/virtio/virtio_ctl_msg.c
> @@ -147,12 +150,17 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, st=
ruct virtio_snd_msg *msg,
>  		psgs[nouts + nins++] =3D in_sgs;
> =20
>  	scoped_guard(spinlock_irqsave, &queue->lock) {
> -		rc =3D virtqueue_add_sgs(queue->vqueue, psgs, nouts, nins, msg,
> -				       GFP_ATOMIC);
> +		if (snd->ctl_msgs_blocked)
> +			rc =3D -ENODEV;
> +		else
> +			rc =3D virtqueue_add_sgs(queue->vqueue, psgs, nouts, nins,
> +					       msg, GFP_ATOMIC);
>  		if (!rc) {
>  			notify =3D virtqueue_kick_prepare(queue->vqueue);
> =20
>  			list_add_tail(&msg->list, &snd->ctl_msgs);
> +			if (notify)
> +				virtqueue_notify(queue->vqueue);
>  		}
>  	}

[ ... ]

> @@ -187,6 +192,11 @@ int virtsnd_ctl_msg_send(struct virtio_snd *snd, str=
uct virtio_snd_msg *msg,
>  		goto on_exit;
>  	}
> =20
> +	if (READ_ONCE(msg->cancelled)) {
> +		rc =3D -ENODEV;
> +		goto on_exit;
> +	}
> +
>  	switch (le32_to_cpu(response->code)) {
>  	case VIRTIO_SND_S_OK:
>  		rc =3D 0;

[Severity: Low]
This isn't a bug, but does mixing scope-based cleanup like scoped_guard with
traditional goto-based error handling (goto on_exit) violate the cleanup
guidelines?

The guidelines state that for a given routine, either all resources should =
be
converted to scope-based cleanup or none of them should be, to prevent brit=
tle
ownership semantics and future bugs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791867377.gi=
t.mynameisjune111@gmail.com?part=3D3
