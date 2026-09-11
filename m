Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B98E32C8B
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 01:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789090210; cv=none; b=RoWdAZFJHWHtbAnWclLmv7qsdipm9Id6sTrADGMIfLjOuK0Dmfd0NkjCnK9qH8+2U18YZzUmtNi1pzZI6iGZ3RNmhEDuwsfQGyUrzkL701F93/vN80/1D1Zd+wj6qfryvJVnP07pGKMHj0GVzpZ+kdRg0UM8Rj4Qs6jPWPR6azY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789090210; c=relaxed/simple;
	bh=OWIykSZ5EV6TeELAhpSHdxnR+yK7gPHtcNFeDGwVNjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qkDQPzXs+Nr1DDHsoMoolIO+hr4FV8meFcoT5DWv0MSjjIj/kqUBdQfW0qxza8MeD7fZMSeJZ72Bb8y6gE2AVN+CKOx2ZGFcQNK5PnCAbrkFm1h/0JBwdeGW92rW7ybahmuNf4Z3YCVshfWS75w8mX879Htps6LEda0xF44MJxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnveoVtL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnveoVtL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAAA1F000FF;
	Fri, 11 Sep 2026 01:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789090207;
	bh=uww61HurhzQF/wauuyZmNSiYFmlgfz0GFf28HgeeQj4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EnveoVtLJEr86mE0thqvvmcbyEH+gKyU1Kw1zpelFP8O2lvGUZAny38SCtp0CYqEV
	 n/np5FV6dTPq9uvkAFHpUaqW07WRRzaxUcedffaXEr6lAIi9e6q9XOARm7SxWqIDG+
	 acxZQguONfn6iwFHVhHfUTKoCe0o0ujUUNh8vMGCspX6g/ONOsG6K2C34t+qWlfteR
	 kus0fb5TBYcuTU/hbgLBl8gdmF6lv5iLdI2ik441VAg/EvfBm1lMFOcK4XHDmePUtW
	 8OdjmgrCX1JrqYCtaZh5dUXThhb/jx3v3LmyNxoSyjcZz9V2GahQtNiIX+E5WGxNfm
	 M+p5QXMEtrQNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] iommu/virtio: Reset device before deleting
 virtqueues on probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260911011249.1498825-1-oss.patchbox@gmail.com>
References: <20260911011249.1498825-1-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 01:30:06 +0000
Message-Id: <20260911013007.6CAAA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver ignores the return value of `iommu_device_register()`, =
which can lead to a double `list_del()` and kernel panic upon device remova=
l if registration failed.
- [High] The driver context `vdev->priv` is assigned too late in the probe =
sequence, creating a race window where an early interrupt causes a NULL poi=
nter dereference.
- [High] DMA mappings for event queue buffers are leaked on the probe error=
 path and during device removal.
- [High] `viommu_fill_evtq()` fails to kick the event queue after adding in=
itial buffers, potentially stalling event reception.
--

commit f64d3ec8a50d9c00ad5c23ca6661968d147a4ff4
Author: Yuho Choi <oss.patchbox@gmail.com>

iommu/virtio: Reset device before deleting virtqueues on probe failure
   =20
viommu_probe() marks the device DRIVER_OK before populating the event
virtqueue and registering the IOMMU device in sysfs. If either operation
fails, the error path deletes the virtqueues while the device is still
live. The device may therefore continue accessing queue memory after it
has been freed.
   =20
Reset the device on error paths after DRIVER_OK before deleting the
virtqueues, matching viommu_remove().

> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 587fc13197f12..fa72ae23b8afa 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1227,12 +1227,12 @@ static int viommu_probe(struct virtio_device *vde=
v)
>  	/* Populate the event queue with buffers */
>  	ret =3D viommu_fill_evtq(viommu);

[Severity: High]
This is a pre-existing issue, but viommu_fill_evtq() populates the event
virtqueue with initial buffers via virtqueue_add_inbuf() but never issues a
virtqueue_kick() to notify the host.

According to the Virtio specification, adding buffers to a virtqueue after
the device is marked ready requires an explicit notification.

Can this result in a queue stall, preventing the host from reporting IOMMU
faults?

>  	if (ret)
> -		goto err_free_vqs;
> +		goto err_reset_vdev;
> =20
>  	ret =3D iommu_device_sysfs_add(&viommu->iommu, dev, NULL, "%s",
>  				     virtio_bus_name(vdev));
>  	if (ret)
> -		goto err_free_vqs;
> +		goto err_reset_vdev;
> =20
>  	vdev->priv =3D viommu;

[Severity: High]
This is a pre-existing issue, but is vdev->priv assigned too late?

Before this assignment, viommu_fill_evtq() populates the event queue with
buffers, and virtio_device_ready() was already called.

If the device immediately consumes these buffers and asserts an interrupt,
viommu_event_handler() will read vq->vdev->priv as NULL and dereference it:

drivers/iommu/virtio-iommu.c:viommu_event_handler() {
	...
	struct viommu_dev *viommu =3D vq->vdev->priv;
	...
}

Can this lead to a NULL pointer dereference if an early interrupt occurs?

[Severity: High]
This is also a pre-existing issue, but shortly after vdev->priv is assigned,
the return value of iommu_device_register() is ignored:

	vdev->priv =3D viommu;
	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);

If iommu_device_register() fails, it cleans up the list node by calling
iommu_device_unregister(), poisoning the node. Since the failure is ignored,
viommu_probe() falsely succeeds.

Later, upon device unbind, viommu_remove() unconditionally calls
iommu_device_unregister() again.

Does this cause a double list_del() and a kernel panic?
=20
> =20
> @@ -1244,6 +1244,8 @@ static int viommu_probe(struct virtio_device *vdev)
> =20
>  	return 0;
> =20
> +err_reset_vdev:
> +	virtio_reset_device(vdev);
>  err_free_vqs:
>  	vdev->config->del_vqs(vdev);

[Severity: High]
This isn't a bug introduced by this patch, but virtqueues are deleted here
without first detaching and unmapping the unused buffers.

Since viommu_fill_evtq() allocated and mapped buffers using
virtqueue_add_inbuf(), and del_vqs() doesn't automatically unmap DMA
addresses, are these mappings permanently leaked?

Does the same leak also occur during normal device removal in
viommu_remove()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911011249.1498=
825-1-oss.patchbox@gmail.com?part=3D1
