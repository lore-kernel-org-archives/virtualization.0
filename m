Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A757B356771;
	Sun, 11 Oct 2026 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791715168; cv=none; b=DuZ5Mt+EL3katad8pkUXkHeORbmN2Ts0f9+NPiudMNtVUsrEPQmABeOIVznQfx2lA2/NNU0RFRRvpqZDTe8Ab8Yea4jw6uUWsfqIjAahoqb+qdH7flBrbf/v2ZRHGcs8U3AoA4zG+pqbkCmbSuPUJhESy8mFJ/A980CjIjGxaQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791715168; c=relaxed/simple;
	bh=6sJVPk7LBYVykQunv6b3DjggB6B3BT/6e9dshRMj/Og=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=V5ixRrHIp2VH0S1eWCDG2tFChwhimf2gpTy6d5SnLkpD8PE6QUR6RvGXtRv2TENnM5dHft3YARtfg1gfa9Uh3DWTWOYMI/kzDPbSKAZH+pgJwirZuoJmPQYAGAtpjkrMfxb0iObs0rJrJXyRUfuegcm1/qUvDNzaJE+rMtWqlV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Op+oiNcH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Op+oiNcH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79D91F0089B;
	Sun, 11 Oct 2026 10:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791715167;
	bh=0DELuz0KdW8Gq9t3vOvxzFvqjRFsLQexgQHFEeZbUAQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Op+oiNcHw9jdzGYEAr9e7f5S50X4Tqjq0gXRCb29+iPFrTWQAmm7FINGdlmez2hMf
	 PUwM4CPhJ0sXchKrgXN3tkkY++DEG98yABJv+yTJIsh6T3d/854aS+yLmAvY6AfJkN
	 0R0JH0c6kLjhE5uteQGipLHRDclUn/QnRinVt+oJIPzSWa5g/SAJRJdByv3qCrSbW+
	 zlmoQ/ivJh0U5LyVBglSPJSQwsrDzoYPjj4xHZJ/zIWLnGtea9euIezeBNozgbP1Bm
	 BcK2axiONyoaFS5vpu9yifNNZ8R6BXDy9vnbSDLNLPHaotn6TqSyCWqx7qsOYJ2bbi
	 FCgEIdrL5BxBA==
Message-ID: <sashiko-outbox-167170@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vhost-vdpa: initialize state before publishing cdev
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linfeng Sun" <linfeng.sun.dev@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev
In-Reply-To: <20261011-fix-null-pointer-in-vhost_vdpa_release-v2-1-66ba929971ce@gmail.com>
References: <20261011-fix-null-pointer-in-vhost_vdpa_release-v2-1-66ba929971ce@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 10:39:26 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] vhost_vdpa: spurious -EBUSY on open() due to uevent race during =
probe
--

commit cef3a58744e8aa0a22f86fbbe577797fa0a78e31
Author: Linfeng Sun <linfeng.sun.dev@gmail.com>

vhost-vdpa: initialize state before publishing cdev

Initialize the completion and as hash buckets before cdev_device_add()
makes the device accessible.

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ff7d907191712..6cff1ed2004ee 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1655,7 +1655,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdp=
a)
>  		return minor;
>  	}
> =20
> -	atomic_set(&v->opened, 0);
> +	atomic_set(&v->opened, 1);
>  	spin_lock_init(&v->config_lock);
>  	v->minor =3D minor;
>  	v->vdpa =3D vdpa;
> @@ -1678,16 +1678,17 @@ static int vhost_vdpa_probe(struct vdpa_device *v=
dpa)
> =20
>  	cdev_init(&v->cdev, &vhost_vdpa_fops);
>  	v->cdev.owner =3D THIS_MODULE;
> +	init_completion(&v->completion);
> +	for (i =3D 0; i < VHOST_VDPA_IOTLB_BUCKETS; i++)
> +		INIT_HLIST_HEAD(&v->as[i]);
> =20
>  	r =3D cdev_device_add(&v->cdev, &v->dev);
>  	if (r)
>  		goto err;
> =20
> -	init_completion(&v->completion);
>  	vdpa_set_drvdata(vdpa, v);
> =20
> -	for (i =3D 0; i < VHOST_VDPA_IOTLB_BUCKETS; i++)
> -		INIT_HLIST_HEAD(&v->as[i]);
> +	atomic_set_release(&v->opened, 0);

[Severity: Medium]
Will this cause a spurious -EBUSY for userspace orchestration tools like ud=
ev?

When cdev_device_add() registers the character device, it fires a KOBJ_ADD
uevent. If userspace reacts immediately by calling open(), it will hit
vhost_vdpa_open():

drivers/vhost/vdpa.c:vhost_vdpa_open() {
	...
	opened =3D atomic_cmpxchg(&v->opened, 0, 1);
	if (opened)
		return -EBUSY;
	...
}

Since v->opened was artificially set to 1 earlier in probe, open() will be
rejected with -EBUSY until atomic_set_release() clears it, which might
break normal userspace orchestration that attempts to open the device right
after the uevent.

> =20
>  	return 0;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-fix-null-p=
ointer-in-vhost_vdpa_release-v2-1-66ba929971ce@gmail.com?part=3D1
