Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA6B42B324;
	Sun, 11 Oct 2026 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791709216; cv=none; b=KVkZkkbR0vuZEn2zZlOk8mRxk7TdZwZB01f0SMEBuEE5aYsFfzwbF0mBeF7o6WEDfcsaoBAVyovmwq1rBKwA27hemodT/BqZl6qMeoQF7XMkkQcjq2HCDcU0aNIHll2u91OxZIlB/8NZ66qmswoTEkBkkXm1EdofWcq3tUvfGCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791709216; c=relaxed/simple;
	bh=EmHyOirDOkYfzi4Y4J2mRpblcIDFRi6DTfbHn2VJZbc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=U9rr+9OrsDerukjR+d4A7qOHA8QxG1d+lIFxt4cKe0MspUVw/4H0/Tv9w+isa0134r8q6oYX1ytFu9ZzPXAkyJrYBLHj69nb0LUXaWibP2F4A1eQQ+Rdcgxg2Hz2eX4tLheUnxl5goi3EXV8B2aN+PNuY9DQAxmvs1xhiNCoQiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2dsjkvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2dsjkvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8EC1F0089B;
	Sun, 11 Oct 2026 09:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791709212;
	bh=r+BptpkQZtr4OIPIcsuP8Xj/UnxZ74orldA+7tJ9dpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H2dsjkvfF+O+EMJoBAFWgGN9CeOacZqpvKWtY13yOEEMgvSjtNYHfdVaxrbmMH7La
	 2wOYYA2Js57UGx5QPx5d/dgj5Au5pcluwxV7IfNzmAckR8/kockviLxPYv11zQoAeT
	 VoSVM5pWxxLN2dcR5xx1534cgdCc3npxro4n0Z6ciEPY6qAxlEfg6AvzGsXC1FJLal
	 dTiAXnZx7MXOOJXPMcT106GbSDfAktwfrJaS9FNaoWUD2y8bYL8stYGxwxrBXwP3TF
	 1tX28naggdeIYOmMNgrrh+AHfYKCDTbOJuhxquQ4LAbKXDv94UQFTBza4740V1/F/j
	 xD/L5IrvxdqlA==
Message-ID: <sashiko-outbox-167137@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost-vdpa: initialize state before publishing cdev
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linfeng Sun" <linfeng.sun.dev@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261011-fix-null-pointer-in-vhost_vdpa_release-v1-1-43ebc225f938@gmail.com>
References: <20261011-fix-null-pointer-in-vhost_vdpa_release-v1-1-43ebc225f938@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 09:00:11 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vhost_vdpa: Use-After-Free of parent vdpa_device on probe failure
--

commit b1425fc64c0e35d298bf8e859d19dd2bf03f896d
Author: Linfeng Sun <linfeng.sun.dev@gmail.com>

vhost-vdpa: initialize state before publishing cdev

Initialize the completion and as hash buckets before cdev_device_add()
makes the device accessible.

> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ff7d907191712..35e2f5b2293bf 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1678,17 +1678,16 @@ static int vhost_vdpa_probe(struct vdpa_device *v=
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

[Severity: High]
Is there a use-after-free risk on the error path if cdev_device_add()
returns an error?

If device_add() fails within cdev_device_add(), the character device might
have already been added successfully via cdev_add(), allowing a concurrent
open() to succeed. In this scenario, vhost_vdpa_probe() jumps to err and
returns an error, causing the driver core to abandon the device bind and
free the parent vdpa_device.

However, the successfully opened file descriptor pins the vhost_vdpa object
and its file operations. When this file descriptor is later closed,
vhost_vdpa_release() is called and attempts to reset the device:

vhost_vdpa_release()
  vhost_vdpa_reset()
    _compat_vdpa_reset()
      struct vdpa_device *vdpa =3D v->vdpa;
      const struct vdpa_config_ops *ops =3D vdpa->config;

Since the parent vdpa_device has already been freed, will this dereference
result in a use-after-free?

> =20
> -	init_completion(&v->completion);
>  	vdpa_set_drvdata(vdpa, v);
> =20
> -	for (i =3D 0; i < VHOST_VDPA_IOTLB_BUCKETS; i++)
> -		INIT_HLIST_HEAD(&v->as[i]);
> -
>  	return 0;
> =20
>  err:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-fix-null-p=
ointer-in-vhost_vdpa_release-v1-1-43ebc225f938@gmail.com?part=3D1
