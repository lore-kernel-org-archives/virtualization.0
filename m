Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1313939DA
	for <virtualization@lists.linux.dev>; Sun, 13 Sep 2026 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789305363; cv=none; b=fxzehXubHCTf2PULIskTe0seE0UPdRj1rqBnARVX5H246FkfdWGmekpgQJ8qBxGI542gf5jTOYjn+npOMR92EhwSoeF+0HfjDRxUg1bkjNgNaqBVDAFuU5dzbdD6eJAO5Z4x1O+hXvhhvBZtVwONti2FBlTQzHqvjlkrOzc1RmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789305363; c=relaxed/simple;
	bh=tQg/2j67dLnN/EhaMSil25O2gnFyndL/HgIp5r4wkrQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dpr4Kd1xtopNZzCHfklCQm2fHhCHGdxHK+t5H/GHAF0CQFt0E7sR/ri6Le4tYXfhT9lKlMY6P+OK0IdNvb0qiOySRwfpgK112rQxHmDnRF4CYrLPt6TyTLgpESui2vWkgmc1PfgpLtTAJeSfNyUS07zNX0zEcL6y4eeC9yXqC/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mT04x6gg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mT04x6gg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6121D1F000FF;
	Sun, 13 Sep 2026 13:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789305360;
	bh=g3giTzn9wr562XsmhWTDXi7z77MijgkXroJ/t7FMmc8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mT04x6ggQG2kMLNMOwhl4CGqXl1RwzLuEAu3RlEvWx5QVgy9gbGb59OnvBjhiEx3m
	 cFqclkktqtnl9IyxTlGSJLPV2yDEU9T+1bYOfOkOcWkD2pH+UFmqCABR74gU/uWKxd
	 svQK8Ht7/O4ApD8p6SQ4+GmepHRA6g7RW0r2hdHWbihm6OGm0T3tKyfXfbPdwD8QxQ
	 6L2wyE2Xsk1H7cgcWAi0OJA31m0kB3WpHTZtoZ+tdXVrleaOjvb0JY5zE9zvGpuXjB
	 SUi08QeDt8uKYzgb7F87xczMm/8ozH7doOTHrnBumhtIY5LSRSARgd+M5ZK9zh4P3F
	 YjlRROZUXAswQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost: reject invalid IOTLB update permissions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Linfeng Sun" <linfeng.sun.dev@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260913-fix-vhost_chr_write_iter-v1-1-76bf1f436cfe@gmail.com>
References: <20260913-fix-vhost_chr_write_iter-v1-1-76bf1f436cfe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 13:15:59 +0000
Message-Id: <20260913131600.6121D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing validation for `msg.size =3D=3D 0` during `VHOST_IOTLB_INV=
ALIDATE` leads to integer underflow and unintended interval tree queries.
--

commit b0f07892733bab641caa79a8f76f81c291b22034
Author: Linfeng Sun <linfeng.sun.dev@gmail.com>

vhost: reject invalid IOTLB update permissions

This commit adds validation for the permission field of IOTLB update
messages in vhost_chr_write_iter(). It rejects messages with empty or
invalid permissions to prevent warnings when these are dispatched to the
vDPA backend.

> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 44cac11b68d2a..0adf0fea97b41 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -1750,7 +1750,8 @@ ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
>  		goto done;
>  	}
> =20
> -	if (msg.type =3D=3D VHOST_IOTLB_UPDATE && msg.size =3D=3D 0) {
> +	if (msg.type =3D=3D VHOST_IOTLB_UPDATE &&
> +	    (!msg.size || !msg.perm || (msg.perm & ~VHOST_ACCESS_RW))) {
>  		ret =3D -EINVAL;
>  		goto done;
>  	}

[Severity: High]
This is a pre-existing issue, but since we are validating message sizes
here, is there a missing size =3D=3D 0 check for VHOST_IOTLB_INVALIDATE mes=
sages
that can lead to an integer underflow?

If a userspace process sends a VHOST_IOTLB_INVALIDATE message with size =3D=
=3D 0,
the generic vhost_process_iotlb_msg() handler explicitly checks for this and
returns -EINVAL. However, the custom vDPA handler does not:

drivers/vhost/vdpa.c:vhost_vdpa_process_iotlb_msg() {
    ...
	case VHOST_IOTLB_INVALIDATE:
		vhost_vdpa_unmap(v, iotlb, msg->iova, msg->size);
		break;
    ...
}

This gets passed to vhost_vdpa_unmap() which performs this calculation:

drivers/vhost/vdpa.c:vhost_vdpa_unmap() {
    ...
	vhost_vdpa_iotlb_unmap(v, iotlb, iova, iova + size - 1, asid);
    ...
}

Does this calculation underflow when size is 0?=20

If iova =3D=3D 0, the last index (iova + size - 1) would wrap to ULLONG_MAX,
silently unmapping the entire IOTLB. If iova > 0, it creates an inverted
interval where start > last. The interval tree incorrectly handles this by
finding and unmapping any valid intervals that straddle both start and last,
corrupting the device's internal tree representation.

Should we add a similar size =3D=3D 0 check for VHOST_IOTLB_INVALIDATE eith=
er
here in vhost_chr_write_iter() or directly inside
vhost_vdpa_process_iotlb_msg()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913-fix-vhost_=
chr_write_iter-v1-1-76bf1f436cfe@gmail.com?part=3D1
