Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485460;
	b=0TOL4aCZiFEUIYYkXoV8KWpPTNi3FFRbQFitwDuvSYZ3vX1pKLWIiLZELfgnTMoIZw88
	 y9T8z2xP3spTUMkacgx41yb8EN6Qbb4kgbchf7ZR5i6syUxC0D0JXGMMiejO2O6xpKlfP
	 WGDNCw4piQhR7qcFDHY/h04tGJWyrFiv0Ggn0Y2so/ewgjrz0jOhejZdOJ25zUtyNmD3L
	 AtNbMvlYQIOuxWBdFJbdpEHCiLLETcoO3ioVpdKV21sYiZWmtlUfGRkRIaOYcSCqLsM9J
	 hqof31TDBISHzfyq5mHYmLlyI5WPZzWUYmr1S/Rp1lrNnS5E8ZOaNwdfonwAJ/57dDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485460;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Caijm9mw22Y9UoQBBtd0kFIDXijuY3rcbSVepzIoKdw=;
	b=zdUWO54hyiQWilVQUA/627ft+nXJqmXdJLpXCtScpxfyvQh6S6Uq9+qBiv8rLzdJYLYl
	 /IeqavcdNN82VTBCXnBzDzyMy7cW/TNyN8Ky+KdraBMPNFooGLl7nOUrIGmXLRRyuLZJa
	 TLXyt8qWkcuKbPpqx90cneT48CrZkkeGdCJTHLzxSXQlcbjjrNHRQmf7e7zNVantCnvaS
	 2iwsKAUUbN15ZqKquU8OyXILWx2aR2/Dql26BJi/rgdoIjuEoeG1UX3t0TZ6XscCbiYLM
	 hszDm7xynPDnZCTxiKkihnwVAPawbgKAkdiYGBp7SYN1ea5UQGPXqsgitYjOxYZ4XeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jm5QxUbO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49849606A319
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jm5QxUbO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCB01F000C4;
	Tue, 20 Oct 2026 08:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792485460;
	bh=Caijm9mw22Y9UoQBBtd0kFIDXijuY3rcbSVepzIoKdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jm5QxUbOChi4kgdfsxKAXC096ZT/Jox00jqJcthKieeaBlxsP69eGZqjNr63EwSUM
	 okjRwbtyAgI/CXmvbKWUepOlaZNfcB4tCsBSv/ECz7VLY2tNxhrU08VwH159nC6WB5
	 01az6/7RjC38iussyfYaKpz9ydyQ4MCgRL9kbmX1NTbZ8hJyK2YEQ1Bu2FOhiiIlXn
	 MYMSCtdsefnZ/2Tjgdh7wswSolQeB/itu5J/XNZvYdOjxnA11v4KbOmsYAxAvnb9kh
	 jBgPR5APHRzsVKFtll5fMhforfVfj/wSjpcLHrx/WxvB6+fpMg735fC38/NWa3wHUi
	 8H7JHSdZOTYRw==
Message-ID: <sashiko-outbox-178584@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] virtio_balloon: drain update works on probe error
 paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mingbing Zhai" <zhaimingbing@cmss.chinamobile.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261020035744.1131-1-zhaimingbing@cmss.chinamobile.com>
References: <20261019084406.162-1-zhaimingbing@cmss.chinamobile.com>
 <20261020035744.1131-1-zhaimingbing@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:37:39 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] virtio_balloon: uninitialized wakeup_lock used in virtballoon_stop=
_updates()
- [High] virtio_balloon: missing virtio_reset_device() before del_vqs() on =
probe error
- [High] virtio_balloon: race between init_vqs() and stats_handle_request()
--

commit e212fced31f70fa27727822aaf449978f76f3a04
Author: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>

virtio_balloon: drain update works on probe error paths

This commit factors out virtballoon_stop_updates() from virtballoon_quiesce=
()
and calls it on the virtballoon_probe() and init_vqs() error paths to stop
and drain pending balloon update works before deleting virtqueues and freei=
ng
the virtio_balloon structure.

> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index ab3e3d887e00f..fe99ab0fea227 100644
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

[Severity: High]
Does draining vb->update_balloon_stats_work via virtballoon_stop_updates()
on the init_vqs() and virtballoon_probe() error paths acquire an
uninitialized vb->wakeup_lock?

In virtballoon_probe(), init_vqs(vb) is called near the beginning of probe,
while spin_lock_init(&vb->wakeup_lock) is not called until near the end of
virtballoon_probe(), after init_vqs() and after all error jumps to
out_del_vqs, out_del_balloon_wq, out_unregister_shrinker, and
out_unregister_oom:

drivers/virtio/virtio_balloon.c:virtballoon_probe() {
	...
	err =3D init_vqs(vb);
	if (err)
		goto out_free_vb;
	...
		err =3D page_reporting_register(&vb->pr_dev_info);
		if (err)
			goto out_unregister_oom;
	}

	spin_lock_init(&vb->wakeup_lock);
	...
}

Once init_vqs() calls virtio_find_vqs(), the stats_vq callback
stats_request() is armed and calls start_wakeup_event(), which executes
spin_lock_irqsave(&vb->wakeup_lock, flags) on the uninitialized lock. If
init_vqs() fails at virtqueue_add_outbuf() or a later step in
virtballoon_probe() fails and jumps to out_del_vqs,
virtballoon_stop_updates(vb) drains update_balloon_stats_func(), which calls
process_wakeup_event() and finish_wakeup_event() and executes
spin_lock_irq(&vb->wakeup_lock) without spin_lock_init(&vb->wakeup_lock)
ever having been called. Furthermore, if stats_request() fires during or
after init_vqs() and probe succeeds, spin_lock_init(&vb->wakeup_lock) will
re-initialize the lock while stats_request() or update_balloon_stats_func()
may already be holding or contending on it.

Although the commit message notes a dependency on "virtio_balloon:
initialize wakeup_lock before virtqueues are set up", that change is not
present in the tree or included in this commit. Should
spin_lock_init(&vb->wakeup_lock) be moved before init_vqs(vb) here so that
vb->wakeup_lock is initialized before the virtqueue callbacks are armed and
before virtballoon_stop_updates() can drain the work?

> =20
>  static void update_balloon_size_func(struct work_struct *work)
>  {
>  	struct virtio_balloon *vb;
> @@ -633,6 +644,12 @@ static int init_vqs(struct virtio_balloon *vb)
>  		if (err) {
>  			dev_warn(&vb->vdev->dev, "%s: add stat_vq failed\n",
>  				 __func__);
> +			/*
> +			 * The virtqueues are up and the stats callback is
> +			 * armed: stop the works and unwind the queues.
> +			 */
> +			virtballoon_stop_updates(vb);
> +			vb->vdev->config->del_vqs(vb->vdev);
>  			return err;
>  		}
>  		virtqueue_kick(vb->stats_vq);

[Severity: High]
Can stats_request() and stats_handle_request() race with init_vqs() as soon
as virtio_find_vqs() returns?

In init_vqs(), virtio_find_vqs() sets up the virtqueues and arms the
stats_vq callback stats_request() while vb->stop_update is false, before
vb->stats_vq is assigned and before initial priming finishes:

drivers/virtio/virtio_balloon.c:init_vqs() {
	...
	err =3D virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
			      vqs_info, NULL);
	if (err)
		return err;

	vb->inflate_vq =3D vqs[VIRTIO_BALLOON_VQ_INFLATE];
	vb->deflate_vq =3D vqs[VIRTIO_BALLOON_VQ_DEFLATE];
	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
		struct scatterlist sg;
		unsigned int num_stats;
		vb->stats_vq =3D vqs[VIRTIO_BALLOON_VQ_STATS];

		num_stats =3D update_balloon_stats(vb);

		sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
		err =3D virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb,
					   GFP_KERNEL);
	...
}

If the device triggers stats_request() and update_balloon_stats_func() ->
stats_handle_request() runs on another CPU before vb->stats_vq =3D
vqs[VIRTIO_BALLOON_VQ_STATS] is assigned, stats_handle_request() will read
vq =3D vb->stats_vq as NULL and pass it to virtqueue_get_buf(vq, &len):

drivers/virtio/virtio_balloon.c:stats_handle_request() {
	...
	num_stats =3D update_balloon_stats(vb);

	vq =3D vb->stats_vq;
	if (!virtqueue_get_buf(vq, &len))
		return;
	sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
	err =3D virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
	if (WARN_ON_ONCE(err))
		return;
	virtqueue_kick(vq);
}

Even after vb->stats_vq is assigned, if stats_handle_request() runs
concurrently with the priming in init_vqs(), both paths will concurrently
write to vb->stats[] in update_balloon_stats(vb) and invoke unserialized
virtqueue operations (virtqueue_get_buf(), virtqueue_add_outbuf(),
virtqueue_kick()) on vb->stats_vq without any lock.

> @@ -1076,6 +1093,12 @@ static int virtballoon_probe(struct virtio_device =
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
Should virtio_reset_device(vdev) be called before vdev->config->del_vqs(vde=
v)
here at out_del_vqs (and on the error path in init_vqs())?

In init_vqs(), virtio_find_vqs() enables the virtqueues and arms IRQ
callbacks, and when VIRTIO_BALLOON_F_STATS_VQ is negotiated, init_vqs()
adds vb->stats as an outbuf to vb->stats_vq via virtqueue_add_outbuf() and
kicks vb->stats_vq. In addition, if update_balloon_stats_func() was running
when virtballoon_stop_updates(vb) drained it, stats_handle_request() will
have re-added vb->stats to vb->stats_vq and kicked the queue again.

Unlike remove_common(), which resets the device before deleting the
virtqueues:

drivers/virtio/virtio_balloon.c:remove_common() {
	...
	/* Now we reset the device so we can clean up the queues. */
	virtio_reset_device(vb->vdev);

	vb->vdev->config->del_vqs(vb->vdev);
}

neither out_del_vqs nor init_vqs() calls virtio_reset_device() before
calling del_vqs() and kfree(vb) (and virtio_dev_probe() only sets
VIRTIO_CONFIG_S_FAILED on error without resetting the device).

Without virtio_reset_device(vdev), on modern virtio-pci (vp_modern_del_vqs(=
))
enabled queues are not disabled without a reset, leaving the device active
with DMA mappings to the freed vring pages and to vb->stats after kfree(vb).
On virtio-mmio (vm_del_vqs()), vring_del_virtqueue() deletes and frees each
virtqueue from vdev->vqs before free_irq() is called, so without
virtio_reset_device() to stop the device and synchronize callbacks,
vm_interrupt() can concurrently iterate vdev->vqs and dereference freed
virtqueue structures.

[ ... ]

>
>
>

[]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020035744.1131=
-1-zhaimingbing@cmss.chinamobile.com?part=3D1
