Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921B147F2C3
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131477; cv=none; b=byljO7PiOzNRy7xPKgp/35YNm5vxgYHLW4hMDRF+SGz9v0Xhb4aI7IPQJWJqzRMTyK5nJ/nVNllRfniRnzKAykIebEgpIa7heilOfH5SOERgoDzSEA3hlfnXnv8rxpCbFuhgtRIBM2elycwUcsNyUKg89uu74W08FBmgtosOAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131477; c=relaxed/simple;
	bh=TV4o1EpzXfubo6ad2JFJwfqHshT52t1+ll5O7tlESi8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=txbJ6I4fMRYJzWRGsDM2kcfOeHEQoc5Bpku/Q8jf3fi3u2WDYFV3tsk/DtzLGml3lraFvig0m6c0QfncXrobfa4/hi0TiVBNt1T22pktOHcD3lxbB+3UnrfQkpHfTHbHUI01ZsA15hPtQq+fJL1dE65Qn5ljgCFOXjslSRAwS48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPbJrVjn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPbJrVjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A2F1F00899;
	Fri, 11 Sep 2026 12:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789131466;
	bh=rMYTjUdBOLOit+RCUuNdkm9bXiztI/bvEqqcDjMWqo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BPbJrVjnmt29q5KsN9g1MuryGf6rVbNPbmqOOV/VRE6Vdz7zVCMyARhXWAsFPvoCB
	 x1h9SdBmSVEkucKLTGhwYyAuM/te93XjK30FPnqxr44i1rNNZEZiQXpTQQ9NO63yK4
	 wzTbNQYwPohga54AUWWCVFklFJUHHDMvkjNSDxuKl8vvjeT4XACJByv+ualPLaoYFc
	 sYU1zgmNV3tK24fv1oflL7Z3bV9805VGCUBNNbDEWfttR0SqBiO0XSU3FwGk4ZpzHK
	 +p6lZxjFScWvFgiwLeAA0mytXXbd3RP0a8MkTjZp9RANDgzpH1WaXtVYrABt2QILcU
	 lsHw2mxl8cybw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] virtio_pci: drop extra callback sync
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <082fd9b2bad1db0088caa38a8d738aa848bf36b2.1789130213.git.mst@redhat.com>
References: <8f71425918a148dcad1be993ccabd39582d246ee.1789130213.git.mst@redhat.com>
 <082fd9b2bad1db0088caa38a8d738aa848bf36b2.1789130213.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 12:57:45 +0000
Message-Id: <20260911125745.E0A2F1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Removing `vp_synchronize_vectors()` from `vp_reset()` exposes a ra=
ce condition in `virtio_device_shutdown()`, allowing in-flight configuratio=
n change interrupts to execute concurrently with or after system shutdown.

Pre-existing issues:
- [High] Pre-existing data race in `vp_modern_avq_cleanup()` due to missing=
 `admin_vq` lock, leading to potential virtqueue corruption.
--

commit 0b14e711d0c9fc7c440dbf71513420ceb19b4bd3
Author: Michael S. Tsirkin <mst@redhat.com>
virtio_pci: drop extra callback sync

This patch drops the synchronization of callbacks on reset within virtio pc=
i,
relying instead on the virtio core to synchronize callbacks when needed.

> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
[ ... ]
> @@ -98,8 +98,6 @@ static void vp_reset(struct virtio_device *vdev)
>  	/* Flush out the status write, and flush in device writes,
>  	 * including MSi-X interrupts, if any. */
>  	vp_legacy_get_status(&vp_dev->ldev);
> -	/* Flush pending VQ/configuration callbacks. */
> -	vp_synchronize_vectors(vdev);

[Severity: High]
Does removing this synchronization leave a race condition in the shutdown
path?

While the core virtio_reset_device() function was updated to synchronize
after the reset returns, virtio_device_shutdown() appears to lack this
synchronization:

drivers/virtio/virtio.c:virtio_device_shutdown() {
    ...
    dev->config->reset(dev);
    // No trailing virtio_synchronize_cbs() call
}

Because vp_reset() writes to the status register and flushes in-flight
interrupts, returning without synchronization means virtio_device_shutdown()
can finish while a flushed vp_config_changed interrupt is still executing
concurrently.=20

Could this lead to unintended access to device structures or DMA memory
during system teardown or kexec paths?

>  }
> =20
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_p=
ci_modern.c
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
[ ... ]
> @@ -559,9 +559,6 @@ static void vp_reset(struct virtio_device *vdev)
>  		msleep(1);
> =20
>  	vp_modern_avq_cleanup(vdev);

[Severity: High]
This is a pre-existing issue, but is there a potential data race here with
concurrent interrupt handlers?

vp_modern_avq_cleanup() calls virtqueue_detach_unused_buf() without
acquiring the admin_vq->lock. If CONFIG_VIRTIO_HARDEN_NOTIFICATION is
disabled (leaving vq->broken as false), an in-flight admin vq interrupt
flushed during reset might execute concurrently on another CPU:

drivers/virtio/virtio_pci_modern.c:vp_modern_avq_done() {
    spin_lock_irqsave(&admin_vq->lock, flags);
    do {
        virtqueue_disable_cb(vq);
        while ((cmd =3D virtqueue_get_buf(vq, &len))) {
    ...
}

Could concurrent modification of the virtqueue's internal vring state cause
memory corruption or a double complete() execution if the interrupt handler
and cleanup routine run simultaneously?

> -
> -	/* Flush pending VQ/configuration callbacks. */
> -	vp_synchronize_vectors(vdev);
>  }
> =20
>  static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/8f71425918a148dcad1=
be993ccabd39582d246ee.1789130213.git.mst@redhat.com?part=3D2
