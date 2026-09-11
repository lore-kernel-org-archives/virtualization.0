Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD4C403AF8
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162711; cv=none; b=GLyMIOAvr0ctsuj50DZLjGSdoF3ErRinh8wPX9lVuKJCqBgu4toIUzwrvb+2AAfNI91Toxen4BjlsbO6q1X3IlD6t4I7A84BiTaPcATHiU6de9GnZbhbgK7wVX59GfbpMhYIK5PrN67U6iDtIE4puHSFdzziiZ7BAo3JrzMuD9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162711; c=relaxed/simple;
	bh=K1SrALXYRdEyUoxgCt8oeiUQLC75nbSvcRYGa1R19/4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D0fgeye/vDTaImfJ5qG/z3ZgxgVgugqB3s/ravj0fMEQxebsYmw15ZChL1kX7S78qE7nGoL+7LZ/n4FBrQw9OAUSt5sx7djVUYJYfTVFiJkt0xgWm4rtBetjZiXy4AWvE+Xdd89TIT5L6xIMCDuU73Kb6G1Ikvqx++IhWAQmJ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vp31GcEP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp31GcEP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18D51F00898;
	Fri, 11 Sep 2026 21:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789162710;
	bh=Ur7Mb+xzV5djfBzfA5q4TQ4Yj6/qXpy9fhWkiEgJjMA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vp31GcEPGyQwQ3r2Jnd0u22tKG+vKgEdpkv/srmHEub2i8lK+yNiz4PmrfhdcLK58
	 OBuQpeoQE0wfc2kQDP/exvz4xw5lNZoq162DXlRNo4yzK0lGXxQgGC0h+VbmsVjzOX
	 /gqAtsL/X2z3/Xj0Epz9acaFMGRj4Ome0ObwLmADnzXzVhWpcKEdv9yQhDUEiiOeV8
	 KSXeIxRJyjneroCoz3wTbNIzC5PB1e04eugcVWOMGI8T/6k+sbwC6vIh2unaj/Ukx+
	 lxfxeKT5rozzVhzz+2T+Pjd8vHp7O+tizJ2EEv5h+kqtf37W1role4NaoXgvyP1JOH
	 j03S7/qtYKPAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] virtio_pci_legacy: drop callback sync on reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <572661b65eebb784652e5843944d284bbceb2954.1789160982.git.mst@redhat.com>
References: <cover.1789160982.git.mst@redhat.com>
 <572661b65eebb784652e5843944d284bbceb2954.1789160982.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 21:38:29 +0000
Message-Id: <20260911213829.B18D51F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Race condition during system shutdown due to missing callback sync=
hronization after device reset, leading to potential use-after-free or syst=
em crash.
--

commit 78e24f18ba4e25cf07c789fb8728c72626386f80
Author: Michael S. Tsirkin <mst@redhat.com>

virtio_pci_legacy: drop callback sync on reset

The virtio core now synchronizes callbacks after reset,
so the legacy PCI transport no longer needs to do it itself.

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
Does removing this internal synchronization introduce a race condition
during system shutdown?

Unlike virtio_reset_device(), virtio_device_shutdown() in
drivers/virtio/virtio.c does not synchronize callbacks after resetting
the device:

drivers/virtio/virtio.c:virtio_device_shutdown() {
	...
	virtio_synchronize_cbs(dev);
	/*
	 * As IOMMUs are reset on shutdown, this will block device access to memor=
y.
	 * Some devices get wedged if this happens, so reset to make sure it does =
not.
	 */
	dev->config->reset(dev);
}

When dev->config->reset(dev) calls vp_reset(), the status read can trigger
a final in-flight MSI-X interrupt.

Without vp_synchronize_vectors(), vp_reset() now returns immediately while
the interrupt handler could still execute drv->config_changed(dev)
concurrently on another CPU.

Can this lead to a fatal bus error, use-after-free, or kernel crash as the
system teardown sequence proceeds?

>  }
> =20
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789160982.gi=
t.mst@redhat.com?part=3D2
