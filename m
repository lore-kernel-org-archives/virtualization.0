Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BCD3749F6
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203871; cv=none; b=ea6YtLkRksLObZmHw6SB9ISPa84QIRuZZPQp+WZSboj+AHxZOJ/NDA9isayfW5l34ncHRVw7bN+bswopHZedN/oML45+O8CHXPxL4cEgUPKPKec6FgwY9h4yLVXz4C/p+QjN9Wr2aaS1MO6yUFwQljtjSYMhTwaNo7Wma8/bdzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203871; c=relaxed/simple;
	bh=WWj8DDAdlLlqBubGeYPVW4b9eIRgba5bjPliyqqDWAs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lKFvEMRRUAjHN8bhP/v4uiDQc5W6RClhGykKEcnOhJExoTvmcnJoQK1jxHjofbHpjCYknvFC05UAC0kRQtpzAiL1dyYEBiuguygOlT8NVfvZM2O0adoZGT6Ej6M/fXYLiv/vGr6defevJ8w/+9QF3H7laAG9+s6XdnD4eHmNyOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4NdA1ce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4NdA1ce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9D81F00893;
	Sat, 12 Sep 2026 09:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789203869;
	bh=tk63SUPjWPgLEJYnSu9OxPA8yD1eQDihZlvyEO45hbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e4NdA1cezgrc6AmMZYVRLZWSOhH/X0c7M5nx62DENy2vIDwwZ90Dz/ZGgGgtFElPA
	 UAbk/R5WhQFMbCrTOKw92QKfrz61IpgCm+pKQPjFl67+kJ0Z4mFd3LiCGotxieiOdV
	 J0rIo0B5gV2q2G4oNu5F1SxX2ckwditcVxjrQEmh6qhC3O7n5LQL70kP3nFTvH0Q13
	 5htGtXHuqVcQ3eH51N3yNp2RaznBWbN13oQJxWl81PeD6ta2vsPZjYviT7gNgu8juy
	 ww0JmdkL3od5sItezoTTyUKumo3tS6jjshho3BfVV/tFqAxy2+T8UiURsmR7zlEzJk
	 AYITacwlMD5rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] virtio_blk: use synchronous quiesce in
 virtblk_freeze_priv()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cong Zhang" <cong.zhang@oss.qualcomm.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com>
References: <20260912-virtblk_sync_quiesce-v2-1-09a001549b72@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 09:04:29 +0000
Message-Id: <20260912090429.AB9D81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Polling I/O (via `virtblk_poll`) can dereference a freed or NULL `=
vblk->vqs` because the queue is unfrozen before `vblk->vqs` is freed, and p=
olling paths do not check if the queue is quiesced.
--

commit f53b3954fde7a5b53ac6d49c8006ad87ad21054b
Author: Cong Zhang <cong.zhang@oss.qualcomm.com>

virtio_blk: use synchronous quiesce in virtblk_freeze_priv()

This commit replaces blk_mq_quiesce_queue_nowait() with blk_mq_quiesce_queu=
e()
in virtblk_freeze_priv(). The queue is explicitly quiesced synchronously to
prevent dispatch code from continuing to run and accessing deleted virtqueu=
es.

Link: https://lore.kernel.org/20260911-virtblk_sync_quiesce-v1-1-a883f8f312=
58@oss.qualcomm.com

> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9dc..7a570591e040a 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1595,7 +1595,7 @@ static int virtblk_freeze_priv(struct virtio_device=
 *vdev)
> =20
>  	/* Ensure no requests in virtqueues before deleting vqs. */
>  	memflags =3D blk_mq_freeze_queue(q);
> -	blk_mq_quiesce_queue_nowait(q);
> +	blk_mq_quiesce_queue(q);
>  	blk_mq_unfreeze_queue(q, memflags);

[Severity: High]
This isn't a bug introduced by this patch, but does unfreezing the queue he=
re
leave polling I/O exposed to a use-after-free or NULL pointer dereference?

If virtio_blk is configured with poll_queues > 0, polling is enabled. Becau=
se
the queue is explicitly unfrozen before vblk->vqs is freed later in
virtblk_freeze_priv(), a userspace process can submit new polled requests
(e.g., via preadv2(RWF_HIPRI)).

These requests can successfully enter the queue and increment q_usage_count=
er.
The process can then call blk_rq_poll(), which bypasses the standard dispat=
ch
path and directly calls the driver's poll callback (virtblk_poll()).

Since polling paths do not check if the queue is quiesced, virtblk_poll() c=
an
calculate a pointer using the now-freed vblk->vqs and attempt to acquire a
spinlock, resulting in an immediate use-after-free or NULL pointer
dereference:

virtblk_freeze_priv() {
	...
	blk_mq_unfreeze_queue(q, memflags); // Queue unfrozen

	virtio_reset_device(vdev);
	flush_work(&vblk->config_work);
	vdev->config->del_vqs(vdev);
	kfree(vblk->vqs);                   // vqs freed
	vblk->vqs =3D NULL;
	...
}

virtblk_poll() {
	...
	struct virtio_blk_vq *vq =3D get_virtio_blk_vq(hctx);
	...
	spin_lock_irqsave(&vq->lock, flags); // UAF / NULL dereference
	...
}

This patch aims to fix a structurally identical race in the dispatch path by
using a synchronous quiesce, but it appears to leave this polling race
unresolved.

> =20
>  	/* Ensure we don't receive any more interrupts */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-virtblk_sy=
nc_quiesce-v2-1-09a001549b72@oss.qualcomm.com?part=3D1
