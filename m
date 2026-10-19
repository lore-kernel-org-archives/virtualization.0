Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6CC4973AD
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400405; cv=none; b=H7URiTCkRO7gY11IQlNPsxW1991jwjTdvLgmYagHZgZr19Uui+550ublxvFe76+m4Ux7ii+iWNh7VAS4T29RaLMfhPHUSBT4mPWFMDsgdVka8qFQz1nIiMHUoq+8riUEKcIiF8cTtWArm3vKmfqq4e6l+AcNdsMrENvBnZnKoi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400405; c=relaxed/simple;
	bh=1O7NuU3zT0CViIPa0Le6MDU6pPCc8N3VBy16Ix6HysU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RXzDnFpw60BPeR5QahQbPbbgw+C40qw/ClSgd/nYD9SZCPkiN9qfYdlkp6FURiy0kVdNCkNjIhkkSSBLoaGSbObrz7D3L7A4O4NVeMICgeXaTFHMMNiflzzQCNV0iyrL2KIV091275llXkT7lNm3wzzydSSlyI2IJIcx93y6WkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGCFccVD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGCFccVD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2D31F000C4;
	Mon, 19 Oct 2026 09:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792400404;
	bh=DiFjtLmYf/wZ14J9ZASU0XhfLKjCokCZxJ7K2oPJTYk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RGCFccVDAQ9VIxqlOluJaKKIuvrlmvOW3ASpnHonIBP9AoA7i0IooOy/6YRNL6v4v
	 /Lfn7uwrdGtnk54ask+2CEBwoIDGvx6m4sIyyUseZH0mvWEVZZkbel5TAtfGDl9o02
	 1zU47pPdmwu67I1ZbiBnmZEUukkr/9yFhbu341HjUsQiuvidzhmue62A+8rDZPFaaV
	 kiL7LdHmDHBu+UDy5rsTH4O42/rZuYFHQysviXtlaB/B2+E1RwghR0b8Tmll/vwenN
	 WBbGAmnQrzpJAI88qjHUYsZf/AC9ED0yc/TFQVei51+Qkit9G3kZY3+78IDJJC4Jq2
	 VFZjIMWXuXmfA==
Message-ID: <sashiko-outbox-176855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio_balloon: drain update works on probe error paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mingbing Zhai" <zhaimingbing@cmss.chinamobile.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261019084406.162-1-zhaimingbing@cmss.chinamobile.com>
References: <20261019084406.162-1-zhaimingbing@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 09:00:03 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] virtio_balloon: uninitialized wakeup_lock used in virtballoon_prob=
e()
- [High] virtio_balloon: leak vqs and UAF vb when init_vqs() fails after fi=
nd_vqs
--

commit ead8a642cbbc78b91d17dc13d18353f2a7792fd1
Author: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>

virtio_balloon: drain update works on probe error paths

This commit factors out virtballoon_stop_updates() from virtballoon_quiesce=
()
and calls it on the virtballoon_probe() error path before deleting the
virtqueues and freeing struct virtio_balloon.

> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index ab3e3d887e00f..caac7f5b3459c 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -554,6 +554,17 @@ static void update_balloon_stats_func(struct work_st=
ruct *work)
>  	finish_wakeup_event(vb);
>  }
> =20
> +/* Stop queueing of and drain any pending balloon update works. */
> +static void virtballoon_stop_updates(struct virtio_balloon *vb)
> +{
> +	spin_lock_irq(&vb->stop_update_lock);
> +	vb->stop_update =3D true;
> +	spin_unlock_irq(&vb->stop_update_lock);
> +
> +	cancel_work_sync(&vb->update_balloon_size_work);
> +	cancel_work_sync(&vb->update_balloon_stats_work);
> +}
> +
>  static void update_balloon_size_func(struct work_struct *work)
>  {
>  	struct virtio_balloon *vb;
> @@ -1076,6 +1087,12 @@ static int virtballoon_probe(struct virtio_device =
*vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
>  		destroy_workqueue(vb->balloon_wq);
>  out_del_vqs:
> +	/*
> +	 * init_vqs() arms the stats virtqueue callback and primes the
> +	 * queue, so an update work may already be pending: stop queueing
> +	 * and drain it before the virtqueues and vb go away.
> +	 */
> +	virtballoon_stop_updates(vb);
>  	vdev->config->del_vqs(vdev);
>  out_free_vb:
>  	mutex_destroy(&vb->balloon_lock);

[Severity: High]
Can this acquire an uninitialized vb->wakeup_lock when stats_request() fires
during virtballoon_probe()?

In virtballoon_probe(), init_vqs(vb) arms stats_request() and kicks stats_vq
early in the function, whereas spin_lock_init(&vb->wakeup_lock) is only cal=
led
near the end of virtballoon_probe(), after all of the error jumps that unwi=
nd
through out_del_vqs:

drivers/virtio/virtio_balloon.c:virtballoon_probe() {
	...
	spin_lock_init(&vb->stop_update_lock);
	mutex_init(&vb->balloon_lock);
	init_waitqueue_head(&vb->acked);
	vb->vdev =3D vdev;

	balloon_devinfo_init(&vb->vb_dev_info);

	err =3D init_vqs(vb);
	if (err)
		goto out_free_vb;
	...
		err =3D page_reporting_register(&vb->pr_dev_info);
		if (err)
			goto out_unregister_oom;
	}

	spin_lock_init(&vb->wakeup_lock);
}

When stats_request() triggers during virtballoon_probe(), it calls
start_wakeup_event(vb, ...) -> spin_lock_irqsave(&vb->wakeup_lock, flags)
before vb->wakeup_lock has been initialized.

If a subsequent probe step fails and jumps to out_del_vqs,
spin_lock_init(&vb->wakeup_lock) is skipped altogether, and draining
update_balloon_stats_work in virtballoon_stop_updates(vb) runs:

update_balloon_stats_func()
  -> process_wakeup_event() -> spin_lock_irq(&vb->wakeup_lock)
  -> finish_wakeup_event()  -> spin_lock_irq(&vb->wakeup_lock)

on an uninitialized spinlock. Even when probe succeeds, if stats_request()
fires before spin_lock_init(&vb->wakeup_lock), spin_lock_init() will
re-initialize vb->wakeup_lock while it may already be in use. Should
spin_lock_init(&vb->wakeup_lock) be moved before init_vqs(vb)?

[Severity: High]
Also in virtballoon_probe(), what happens if init_vqs() fails at
virtqueue_add_outbuf() after virtio_find_vqs() has already succeeded?

drivers/virtio/virtio_balloon.c:init_vqs() {
	...
	err =3D virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
			      vqs_info, NULL);
	if (err)
		return err;
	...
	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
		...
		err =3D virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb,
					   GFP_KERNEL);
		if (err) {
			dev_warn(&vb->vdev->dev, "%s: add stat_vq failed\n",
				 __func__);
			return err;
		}
		virtqueue_kick(vb->stats_vq);
	}
}

If virtqueue_add_outbuf() fails (for example, on a DMA mapping failure),
init_vqs() returns an error while the virtqueues allocated by
virtio_find_vqs() and their callbacks remain active. In virtballoon_probe(),
the error path for init_vqs() jumps directly to out_free_vb, bypassing
out_del_vqs:

	err =3D init_vqs(vb);
	if (err)
		goto out_free_vb;

Could this leak the virtqueues and leave the armed callbacks and any queued
update_balloon_stats_work referencing vb after kfree(vb)?

[ ... ]

>
>
>

[]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019084406.162-=
1-zhaimingbing@cmss.chinamobile.com?part=3D1
