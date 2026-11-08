Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794156640;
	b=iQE8Adl9MAdMCxfeHreZ9ATyl+Mw+HW2vYnHHKwz/dzvLPDwoxIVvyWjf4MOGzIbOYdB
	 pSe6gZUoT9lgGC9muoMGdcsx9Ik8tfJh561Y7zi1xWLvzMDRplde30tdHDzk/X6auTW3e
	 Ldvwe0ErPLl4Xme/kBPzupNjo6RY6soO46dkVd9afwwehZ4YIZmKR6v+cspSeS0+dH2vH
	 UFDDU9XbSItRlFRudtlNXosdSXQPdKvNIYSTW1Vrzq3ZwLYqzepiBu5Z36PTPq0mnz/Fz
	 KSrpZMqaX1qM0pLtlCJYPYqWLsLQO819Wd+Jqy2E1WrgOD7KvwB9GwWAjekY8pW9D4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794156640;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=R+M3hS2jNytoUi4arwV9GXkjy3KU/YpVBV4EqmjANuI=;
	b=GtcJtk1Z80ItoCq1FE1b0Iy7Yb95dbW31XayJeTEFHx2WKCofE8jZiOt+cYTk5jBTFYJ
	 zZxefqr/veov0koJUOKbQYN3SaVGKtqB1MKAjyOVBJfx5m0TguGb32QFeCuH6VoafeOMC
	 gZ3u9VGF2HLprU3Ps/1/wrEphH2P2IdVoNZYbRJgUPMyiJGcBHG/zjCHQ0uI8DvsyOZX4
	 ALTiSxCpJuexs8bWOsUUplAVQiGkqc6P6ogKG/gQq2dg3xSmVl7DNr6pHh3M6cbE3tM9J
	 ELksZSDJvhY2nLjoKP5piNXZ9Ij7w+EBxPxXhTwwCNXEkuslsHfnfvyY3QGB+wvNtfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwEY3LiW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F90606A321
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwEY3LiW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B351F008A1;
	Sun,  8 Nov 2026 16:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794156639;
	bh=R+M3hS2jNytoUi4arwV9GXkjy3KU/YpVBV4EqmjANuI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hwEY3LiWlz5pBUC7Ptl7HIiltt/ZYwOuCBYB7956QuRWf2xzloulY8oYwOK3B+HqD
	 NinbXEP8ScfwJV9p7gMyssCqbtbDxUwXXTrDfYsuYK2mrPVCglJaZNK5NUc26hpT0y
	 VOcyrQcfKRbFO1ronRpHFuvk0v4+3ozjaPSTlHoFP/q/kssoSmHn/kF9NANXnZqivN
	 /cat9cU2B4iUjTjwermFYCB2AhLkQnhuptk20fxUVPxtobi71rcAt2Spot+Ra7AJrp
	 fA9lQzqUwIu1+z/WUyNXUK2Ru5OhrxoRMhpLXJy8UvPrY245voP/C4ZCpCdzTqXVz6
	 QFNoivdcJKQbw==
Message-ID: <sashiko-outbox-203883@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio: check for driver remove callback before calling
 it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Francesco Valla" <francesco@valla.it>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261108-virtio_drv_remove_fix-v1-1-23da1a7c3900@valla.it>
References: <20261108-virtio_drv_remove_fix-v1-1-23da1a7c3900@valla.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 16:50:38 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] virtio: unreset device in virtio_dev_remove() when
  drv->remove is NULL
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] virtio: use-after-free in virtio_dev_remove() [1]
--

commit ccd4078efa3bba738fda1cc44e8e8955495a84fa
Author: Francesco Valla <francesco@valla.it>

virtio: check for driver remove callback before calling it

This commit checks whether drv->remove is non-NULL before calling it in
virtio_dev_remove().

> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index a8588d7ad109f..067d32c67b44f 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -374,7 +374,8 @@ static void virtio_dev_remove(struct device *_d)
> =20
>  	virtio_config_core_disable(dev);
> =20
> -	drv->remove(dev);
> +	if (drv->remove)
> +		drv->remove(dev);
> =20
>  	/* Driver should have reset device. */
>  	WARN_ON_ONCE(dev->config->get_status(dev));

[Severity: Medium]
When drv->remove is NULL, will WARN_ON_ONCE(dev->config->get_status(dev))
always fire on unbind or module unload?

__device_release_driver() calls device_remove() (which runs
virtio_dev_remove()) before device_unbind_cleanup() runs
devres_release_all().  Even when a driver such as spi-virtio registers a
devm callback to reset the device and delete its virtqueues, that cleanup
has not run yet when virtio_dev_remove() checks get_status() and sets
VIRTIO_CONFIG_S_ACKNOWLEDGE.  The subsequent devm reset then wipes out
VIRTIO_CONFIG_S_ACKNOWLEDGE, or if a driver has no devm reset action at
all, the device is never reset and remains active with live virtqueues and
DMA after its devm resources are freed.

[Severity: Critical]
This problem wasn't introduced by this patch, but calling
of_node_put(dev->dev.of_node) at the end of virtio_dev_remove() causes a
refcount underflow and use-after-free [1].

virtio_device_of_init() acquires the dev->dev.of_node reference during
register_virtio_device(), not during driver probe, and virtio_dev_remove()
drops that reference on driver unbind without clearing dev->dev.of_node.
Unbinding and rebinding a driver drops the reference multiple times on the
same pointer, while unregistering a device that never bound to a driver
leaks the reference.

[1] https://sashiko.dev/#/bug/linux-cf8a6c4a-49fb-4827-8f82-d189cf36ccdd

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-virtio_drv=
_remove_fix-v1-1-23da1a7c3900@valla.it?part=3D1
