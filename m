Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792723432;
	b=jl/u8qoBSsTFTO+5vqFbnVFc+vfC5caPNON2tC7sY0BPACbpuOx6pOvLnm9bmZyuhgy7
	 2YmNaQ4ThsLUOqrbEUO7hoZi4yhQUFaUWc63FO3OuVySO7cUcNA51Ae7ibMcQPPwf8Kvv
	 +aoDchspbch+OrAs+OwPZa8sk4i7vCBtPv8rnT7yH7TVlfPz9Jl3uO+PKB2u14lkI4tAN
	 vIUGfD1p14JrFeysV+Rkk3rpQd/ySaunnD6bHv95H7GEsoNIVEsRHFXQVR56M3JVNSkHf
	 3zd2txMMinoUPku0UklxrxvWrj7hQqy06jniJzEFaQbJtkopUR8Et6jAVIqsJykf3gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792723432;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2sebXwFURZroT6sxEeOcbn8vHIXC7Ueja/Kyy39j1kg=;
	b=CaNtRQqYGcIda/30mM122N5sHO+U2uFHteZQESOZ8woqMiYF2LCxEmslERYtRpiN/7pE
	 USx76BGCTUHSvTkjQEu3jbnHeH7u8lIaZRpQKogYxDk4T8GooCQAABYCXj72/w3AI/u65
	 jnRkeZCAwB+hsmsrD7kPWvdcikpmQfTNc3Uh1WQWjsiSoWEq7nBYrRZfd9MAo87I8ZVz8
	 5e6oTiiMzQuZ7TsmwcWDk3p0H0AgfNZ1ojgTFWNrN4FGsi3ShGoaUlfCMFzAGefBg3wpH
	 j1q3fnLx3ktKryERSUzf7ihEI9u4yJbu8iDXob+Q6JDNkBXJUU6jP8B3Y5sGunhTqzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2vWw7HR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BC9606A319
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 02:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2vWw7HR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F951F01825;
	Fri, 23 Oct 2026 02:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792723431;
	bh=2sebXwFURZroT6sxEeOcbn8vHIXC7Ueja/Kyy39j1kg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M2vWw7HR3+yKWFvc0CY7mXtm7oi6AR3qzK4UWsk62oTHmbXrzMy646ehR54oHJQrG
	 fuUgM1clD4P4xj7AP7ihnAXTKiiqUXGPkgYXL2VOlrJVZPgrJgqKI8hU0JuDZYVpUV
	 EqTjC9qFpYzxTDMtxa/QqCZNYfAjczKrjNE2662GBrhYZ81onSoYyiHJgYlYgOqQti
	 dOERXpLGCgGjId3/Kik8dqqVv+cQlPmMSS0dPZJN40HLwznldup2LhSfsRdmHsX0vO
	 ZD1kGoGgObhJmiHsPa2pZh09eB8SrGsx9KaxRe+dZnHNlqg+tVaZ+xAa8kHGQGOEX1
	 itcC6OQ3zcXrA==
Message-ID: <sashiko-outbox-182246@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] virtio_balloon: drain update works on probe error
 paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mingbing Zhai" <zhaimingbing@cmss.chinamobile.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261023022311.1577-1-zhaimingbing@cmss.chinamobile.com>
References: <8f914911-8453-4f8f-b02f-384114f9d4ef@kernel.org>
 <20261023022311.1577-1-zhaimingbing@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 02:43:50 +0000
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
- [High] virtio_balloon: uninitialized wakeup_lock used in virtballoon_stop=
_updates()
- [High] virtio_balloon: missing virtio_reset_device() before del_vqs() on =
probe error
--

commit e9743442ee54f8ae6c7693dbd62ca4b60f4254f3
Author: Mingbing Zhai <zhaimingbing@cmss.chinamobile.com>

virtio_balloon: drain update works on probe error paths

This commit factors out virtballoon_stop_updates() from
virtballoon_quiesce() to stop and drain pending balloon size and stats
update work items. It calls virtballoon_stop_updates() on error unwind paths
in init_vqs() and virtballoon_probe() before deleting virtqueues and freeing
struct virtio_balloon.

> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index ab3e3d887e00f..b8b70a0943dd1 100644
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
When virtballoon_stop_updates() drains update_balloon_stats_work or
update_balloon_size_work on the init_vqs() and virtballoon_probe() error
paths, will the drained work operate on an uninitialized vb->wakeup_lock?

In drivers/virtio/virtio_balloon.c, update_balloon_stats_func() and
update_balloon_size_func() both call process_wakeup_event() and
finish_wakeup_event(), which acquire vb->wakeup_lock:

drivers/virtio/virtio_balloon.c:process_wakeup_event() {
	spin_lock_irq(&vb->wakeup_lock);
	vb->wakeup_signal_mask &=3D ~mask;
	spin_unlock_irq(&vb->wakeup_lock);
}

drivers/virtio/virtio_balloon.c:finish_wakeup_event() {
	spin_lock_irq(&vb->wakeup_lock);
	if (!vb->wakeup_signal_mask && vb->processing_wakeup_event) {
		vb->processing_wakeup_event =3D false;
		pm_relax(&vb->vdev->dev);
	}
	spin_unlock_irq(&vb->wakeup_lock);
}

Similarly, stats_request() calls start_wakeup_event(), which takes
spin_lock_irqsave(&vb->wakeup_lock, flags).

However, in virtballoon_probe(), spin_lock_init(&vb->wakeup_lock) is not
called until near the end of probe, after init_vqs() and after all of the
error jumps that unwind via out_del_vqs:

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
}

The commit message notes that this patch depends on "virtio_balloon:
initialize wakeup_lock before virtqueues are set up" to move
spin_lock_init(&vb->wakeup_lock) to the top of virtballoon_probe(), but that
change is not present in this tree. Without it, if stats_request() fires
after virtio_find_vqs() in init_vqs(), both the callback and the work drain=
ed
by virtballoon_stop_updates() will lock an uninitialized spinlock_t (and if
probe succeeds, spin_lock_init(&vb->wakeup_lock) can reinitialize the lock
while it is in use). Should spin_lock_init(&vb->wakeup_lock) be moved before
init_vqs() here or the prerequisite patch be applied first?

> +
>  static void update_balloon_size_func(struct work_struct *work)
>  {
>  	struct virtio_balloon *vb;
> @@ -633,6 +644,8 @@ static int init_vqs(struct virtio_balloon *vb)
>  		if (err) {
>  			dev_warn(&vb->vdev->dev, "%s: add stat_vq failed\n",
>  				 __func__);
> +			virtballoon_stop_updates(vb);
> +			vb->vdev->config->del_vqs(vb->vdev);
>  			return err;
>  		}
>  		virtqueue_kick(vb->stats_vq);
> @@ -1076,6 +1089,7 @@ static int virtballoon_probe(struct virtio_device *=
vdev)
>  	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
>  		destroy_workqueue(vb->balloon_wq);
>  out_del_vqs:
> +	virtballoon_stop_updates(vb);
>  	vdev->config->del_vqs(vdev);

[Severity: High]
Should the error unwind paths in init_vqs() and virtballoon_probe() call
virtio_reset_device() before calling del_vqs(), just as remove_common()
does?

In drivers/virtio/virtio_balloon.c, remove_common() resets the device
before deleting the virtqueues:

drivers/virtio/virtio_balloon.c:remove_common() {
	...
	/* Now we reset the device so we can clean up the queues. */
	virtio_reset_device(vb->vdev);

	vb->vdev->config->del_vqs(vb->vdev);
}

Once virtio_find_vqs() succeeds in init_vqs(), the vring DMA addresses are
programmed and the queues are enabled on the transport (for example,
vp_modern_find_vqs() sets queue_enable to 1). When
VIRTIO_BALLOON_F_STATS_VQ is negotiated, init_vqs() also queues vb->stats
into vb->stats_vq via virtqueue_add_outbuf() and calls
virtqueue_kick(vb->stats_vq) (and if update_balloon_stats_func() runs while
virtballoon_stop_updates() drains it, stats_handle_request() re-queues
vb->stats and kicks stats_vq again).

If init_vqs() fails after virtio_find_vqs() or a later step in
virtballoon_probe() fails and jumps to out_del_vqs, virtio_dev_probe() only
adds VIRTIO_CONFIG_S_FAILED without resetting the device. Calling del_vqs()
and kfree(vb) without virtio_reset_device() first can leave the device with
active queues pointing to freed vring and vb->stats DMA memory, cause
subsequent re-probes on modern virtio-pci to fail with -ENOENT in
setup_vq() because queue_enable remains set, and allow vring interrupts to
race with queue teardown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023022311.1577=
-1-zhaimingbing@cmss.chinamobile.com?part=3D1
