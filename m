Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222DF2DCF57
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 10:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792147661; cv=none; b=PPClVvjfo386FqGMvouEa/ifCntfNJHQcl2d1E7qrcl1Ovf7/FIqiZ1A5WAPixnaOv19XiJOF+nPacwL/yLz79Ma3+v1kZgQZpdsKSAxT9hDLXcaqW+8sDDnuBs3Wk9sf43XCZsU+VSBi+qBIdcoesEoUfks8Lhi7Rb6JNFQZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792147661; c=relaxed/simple;
	bh=8U1NHC5lf1F0afbMvl7Lbw+qxezoKsc8BjGZKiOyzek=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TUebZLJt8WF0MFtORivAQOwmDDxxngdRV1sLswDje50y6IG6TCyAf3fSjYQrmObz2yUJgEUJfrjxupB5KOVqjhVjMUm0b5zFpiyQK3ufkWhj3aWE6hOJWdO4O0cczvvnqHV0yI//6RTMlGIvaIXL6u5qGP8nCI/w94pQfaZdSVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fdfw6mpH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fdfw6mpH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C71F1F000C5;
	Fri, 16 Oct 2026 10:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792147659;
	bh=0K5PDdfRkO22ljo5rFMYrc9zZYVimWopdNlWlPl8dRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fdfw6mpHjesvByM6RyvPAYPRrQhfSUSKwOoiRlJtkzdvjWCIrmformJfMSLP/uPe6
	 uWHFA5PRpc+W4yWs7LOJUUitO46Q9XnMlHmdtrGpU1JCPYJRGCClnBhfx4/dMQeQN0
	 xi4sRszJeSW3yZgfb5hug6u83t//OnxVi/uOfItkFu6zirZofJwqiDz2EnS/SzhHUc
	 xgnqfXIY78atb9UxsNBBv0YJB9h0mV2zWApL/icJKGsBNAlRCEmDBNSJhFlKZNzXZw
	 yFLooF+OZSFQ5pScxcmd+FHI0u1GE8/lorL8EL2GLIUdjf25P3a+710sFIAZ0iD0xz
	 TzJWXV/uus4Fg==
Message-ID: <sashiko-outbox-174204@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] hwrng: virtio - prevent use-after-free after a failed
 restore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261016103640.4989-2-blum@kernel.org>
References: <20261016103640.4989-2-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 10:47:39 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] virtio-rng: data race on data_avail leads to deadlock
--

commit 2904ec0356e25704559279a6336e7fed895c58d2
Author: Thorsten Blum <blum@kernel.org>

hwrng: virtio - prevent use-after-free after a failed restore

remove_common() frees the driver data during freeze, but does not clear
vdev->priv, which points to freed memory. Clear vdev->priv on the error
cleanup path and before freeing the driver data in remove_common(). Also
reset the device and return early from remove_common() if vdev->priv is
already NULL.

> diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random=
/virtio-rng.c
> index f9982217247dd..45d87c0614a5e 100644
> --- a/drivers/char/hw_random/virtio-rng.c
> +++ b/drivers/char/hw_random/virtio-rng.c
[ ... ]
> @@ -198,6 +199,11 @@ static void remove_common(struct virtio_device *vdev)
>  {
>  	struct virtrng_info *vi =3D vdev->priv;
> =20
> +	if (!vi) {
> +		virtio_reset_device(vdev);
> +		return;
> +	}
> +
>  	vi->hwrng_removed =3D true;
>  	vi->data_avail =3D 0;

[Severity: High]
Does this code race with a reader and cause a deadlock?

In copy_data() in drivers/char/hw_random/virtio-rng.c, vi->data_avail is re=
ad,
memcpy() is called, and then size is subtracted:

drivers/char/hw_random/virtio-rng.c:copy_data() {
	...
	memcpy(buf, vi->data + idx, size);
	vi->data_idx +=3D size;
	vi->data_avail -=3D size;
	if (vi->data_avail =3D=3D 0)
		request_entropy(vi);
	return size;
}

If remove_common() sets vi->data_avail to 0 before the subtraction, will th=
is
cause an unsigned integer underflow, leaving vi->data_avail as a huge value?

Since vi->data_avail !=3D 0, copy_data() would skip calling request_entropy=
().
virtio_read() would then consume the single completion from remove_common().

Seeing a huge data_avail instead of 0, virtio_read() would continue looping
and eventually block forever in wait_for_completion_killable() because no
pending entropy request will trigger a new completion:

drivers/char/hw_random/virtio-rng.c:virtio_read() {
	...
	while (size !=3D 0) {
		/* data_avail is 0 but a request is pending */
		ret =3D wait_for_completion_killable(&vi->have_data);
	...
}

Could this cause hwrng_unregister() in remove_common() to block forever
waiting for the reader to drop its reference, deadlocking device removal?

>  	vi->data_idx =3D 0;
>  	complete(&vi->have_data);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016103640.4989=
-2-blum@kernel.org?part=3D1
