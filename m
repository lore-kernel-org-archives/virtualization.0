Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7981371889
	for <virtualization@lists.linux.dev>; Sat, 12 Sep 2026 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789209833; cv=none; b=TcfuIY2LU9y7jcWf+covw4/ylGLgtJ2/zN8I7thQHGsOoq0+zn8JkOg3en3qxtxEIoTN6oboxcr2fWfEqEvRJ5zPv41rZrHnyxXlWjBBFei6PvEwxH2u17fQjRdV7Ruk0mmuyfmkYPfwaxzxHNTosvfFen805VFp9n3YUopWlIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789209833; c=relaxed/simple;
	bh=hmRlqa3aHfqwt02m95hJDHvlt/liIft06H330vATY9s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rPvio08IE74eFI2Qy+57ML6Eng8WeFmUOWEer6UJla7dW5L2HSNhYm6CycV5BLnOc+JSr6MYXzcGK2QzSfstBp8GE+6BUHOzO708LUnDGOB4PIhPBLk1vmDWwVlY957KeAqFrLl6pXQYx0H4IuC9jPaLxorOuik97MQfQdixZvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGz5iX4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGz5iX4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CCD1F000FF;
	Sat, 12 Sep 2026 10:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789209831;
	bh=8CY/kS49XPajqkDul6ioodhysmIHQQbEr6ihfJYN+S8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mGz5iX4fVDQdyGyjWidQkK1dYEDYExe20sL8qxnRojNnjL5Z6X7zFcsUoR2UNH9/r
	 FhtnPRPw1bRfzu5ydZUAUXf1PzZj15A3bvka7HsCmyNV2GulZiBVFmuS5dPlXSvvBe
	 kVb/88HY5J9NU73Kf44TgPhUDz8a8VdHxcDE1J0nbK4hcSkkYtKWK2n4AAcuvM5+eu
	 IMUHs2RiF5aYgCTsrUB5V6z5X9LzKXMiwqae0VscAG3tJRVJO5tuuod7UeOmTT5D7t
	 4Lx3BrOwLRPKneoBzp1/yO+jGkMDyN0XzDhTloiWyIE8ZTeN/bc50sJiBnnSC3EcXg
	 dInb/PRnDPOkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] virtio_pci: drop callback sync on reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <64421afa76075c2e0b66ef5c2ea18948b861ab73.1789204858.git.mst@redhat.com>
References: <cover.1789204858.git.mst@redhat.com>
 <64421afa76075c2e0b66ef5c2ea18948b861ab73.1789204858.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 10:43:51 +0000
Message-Id: <20260912104351.73CCD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removal of callback synchronization from `vp_reset()` introduces a=
 race condition during system shutdown, as `virtio_device_shutdown()` fails=
 to synchronize callbacks after device reset.
--

commit a9d5f056fe92ddf169045b3557dd34b627d1eb0b
Author: Michael S. Tsirkin <mst@redhat.com>

virtio_pci: drop callback sync on reset

The virtio core now synchronizes callbacks after reset, so the PCI transpor=
ts
no longer need to do it themselves.

> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_p=
ci_legacy.c
> index d9cbb02b35a11..8115aa39e01e9 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -98,8 +98,6 @@ static void vp_reset(struct virtio_device *vdev)
>  	/* Flush out the status write, and flush in device writes,
>  	 * including MSi-X interrupts, if any. */
>  	vp_legacy_get_status(&vp_dev->ldev);
> -	/* Flush pending VQ/configuration callbacks. */
> -	vp_synchronize_vectors(vdev);

[Severity: High]
Does removing this synchronization introduce a race condition during system
shutdown?

During system shutdown, virtio_device_shutdown() in drivers/virtio/virtio.c
calls dev->config->reset(dev) directly without calling virtio_reset_device(=
):

drivers/virtio/virtio.c:virtio_device_shutdown() {
	...
	dev->config->reset(dev);
	/* Missing virtio_synchronize_cbs(dev) here */
}

The vp_reset() implementation flushes pending MSI-X interrupts, which can
cause a configuration interrupt to fire. Because this patch removes the
internal synchronization from vp_reset(), virtio_device_shutdown() returns
immediately.=20

The configuration interrupt (vp_config_changed()) could then run concurrent=
ly
on another CPU, invoking driver callbacks while the system is tearing down =
the
IOMMU or jumping into a kexec kernel.

>  }
> =20
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)

> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_p=
ci_modern.c
> index b4249afd7f580..922e2df027de9 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
[ ... ]
> @@ -563,9 +563,6 @@ static void vp_reset(struct virtio_device *vdev)
>  	 */
>  	while (vp_modern_get_status(mdev))
>  		msleep(1);
> -
> -	/* Flush pending VQ/configuration callbacks. */
> -	vp_synchronize_vectors(vdev);

[Severity: High]
Does removing the synchronization here present the same issue?

This breaks the guarantee that interrupts flushed during the reset loop have
finished before returning, which virtio_device_shutdown() relies upon to
safely stop the device.

>  }
> =20
>  static int vp_active_vq(struct virtqueue *vq, u16 msix_vec)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789204858.gi=
t.mst@redhat.com?part=3D3
