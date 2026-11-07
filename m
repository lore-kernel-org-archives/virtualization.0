Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794030505;
	b=sfMLdNqhtDN+4cAPvhnaGddV1X9cMzpRHgcVvDKD/ypYPUMwWPh8eCfILoyCS7gvOJcD
	 CFPGRfb0fzmOIjXe0ULi0vbayS4ejLWo6u79Yz0se14Yqa+RVdusxqxdL49W1hu9EH9DZ
	 ekbTV7KIK78w4IgV9qGXjKKvghY4uQBEhPJsGw1wzgNHBIzJOTq+WTC3Q0UUFcQ+1ae7R
	 9dHPpXJfQF2hbjjTda5D46uijeEYzVDY2ZwjuwukF4Svb+g/Of6OvpdmaY51a8HjCh8mv
	 BCMk9Gl0C3g64bwWpQecMbvMHYQK5nAAswJ+zNzaWOfAb32zu+YYJMNB2FVJIZTs5OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794030505;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hvFgl/kjkWGXHr2H+iaJ4VFDZ4WhgKoJ1tIt3R676h8=;
	b=aCJhUe6By5rHRTiodelxTfz1KokhKcvL+zfOLKyLFKpggAKbvUyC8LbfTV+xhDqKx5Xj
	 /vhcUexdgsPieI9enFihI36e3QcHGhfON+SxG99hIV5wkBcJn1H7TywezXP3U8mYccuVb
	 OhU5NfLlwhynSogC6r6ocnahEeu8urI3KRkPNhbHIy4mKMdazK1qGR/r9mUVOTJnqll2a
	 v5NUP1h3EJO+GJvXXNc6K5sTvkNCVHf/3nRdzwCUkuWGCHR3WXEwmfWHrAxX8MLijL/T7
	 wv36YKqPdCGnc8DhTOtqYzakj543X4cYp8h0RoIhQuR/Mg2C1OhayDq4aAczjddSfUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RfEuxcl7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F6606A326;
	Sat,  7 Nov 2026 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RfEuxcl7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A503F1F0089F;
	Sat,  7 Nov 2026 05:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794030505;
	bh=hvFgl/kjkWGXHr2H+iaJ4VFDZ4WhgKoJ1tIt3R676h8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RfEuxcl7ZCvMlvzP+lq84O4g7AWja/wu7g2xOcuaorx1cNvXwIo+FgTv63OV5v+Lq
	 DXjzssfBTAspbK0cYN7yFLg1E2b0dI4mgCx8edKbcAeW7tYWREFKPas93GowaZIREO
	 InJS5qD9RHME/d63zszxv6K9FAdvZlriMVI5ivYy9W/By5/6b0sfexIrXndsq2qTTC
	 ahYnC0hy9im6P7zP3PiKFHCUhgzP0SDC1Zp48bUTDYar//QlF/jkAAlNW5kWYzdA+Z
	 JBD1AQBv2Qu/xvGj2uVO5Q91yFLppNznBd3Ec6lbID67thRIreuRGaUC+Bn96XJJxO
	 85x3b8oPJt5jA==
Message-ID: <sashiko-outbox-202636@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] vhost-scsi: do not validate vrings during endpoint
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <oss.patchbox@gmail.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106054811.281798-2-oss.patchbox@gmail.com>
References: <20261106054811.281798-2-oss.patchbox@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 05:48:24 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] vhost-scsi: unhandled vhost_vq_init_access() failure in
  vhost_scsi_set_endpoint() [1]
--

commit b696a8fa1d0b9b5e5c27a63e36f3d5e5c268720d
Author: Yuho Choi <oss.patchbox@gmail.com>

vhost-scsi: do not validate vrings during endpoint teardown

This commit removes the vhost_vq_access_ok() check from
vhost_scsi_clear_endpoint() so that endpoint teardown always disables the
virtqueue backends and waits for in-flight SCSI commands before state is
freed.

> diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> index e44044449cef8..f0966f25b09a9 100644
> --- a/drivers/vhost/scsi.c
> +++ b/drivers/vhost/scsi.c
> @@ -2194,17 +2194,10 @@ vhost_scsi_clear_endpoint(struct vhost_scsi *vs,
>  	struct vhost_scsi_tpg *tpg;
>  	struct vhost_virtqueue *vq;
>  	bool match =3D false;
> -	int index, ret, i;
> +	int ret, i;
>  	u8 target;
> =20
>  	mutex_lock(&vs->dev.mutex);
> -	/* Verify that ring has been setup correctly. */
> -	for (index =3D 0; index < vs->dev.nvqs; ++index) {
> -		if (!vhost_vq_access_ok(&vs->vqs[index].vq)) {
> -			ret =3D -EFAULT;
> -			goto err_dev;
> -		}
> -	}
> =20
>  	if (!vs->vs_tpg) {
>  		ret =3D 0;

[Severity: High]
This problem wasn't introduced by this patch, but should the paired
vhost_scsi_set_endpoint() path check the return value of
vhost_vq_init_access() [1]?

drivers/vhost/scsi.c:vhost_scsi_set_endpoint() {
    ...
		for (i =3D 0; i < vs->dev.nvqs; i++) {
			vq =3D &vs->vqs[i].vq;
			if (i >=3D VHOST_SCSI_VQ_IO && !vs->vqs[i].scsi_cmds)
				continue;

			mutex_lock(&vq->mutex);
			vhost_vq_set_backend(vq, vs_tpg);
			vhost_vq_init_access(vq);
			mutex_unlock(&vq->mutex);
		}
    ...
}

If userspace invokes VHOST_SCSI_SET_ENDPOINT before configuring the vring
addresses, vhost_vq_init_access() fails for the control and event
virtqueues while their backends remain set to vs_tpg, leaving
last_used_idx uninitialized and breaking event delivery and control
command handling.

[1] https://sashiko.dev/#/bug/linux-00d9df6c-e264-4a85-ae70-5ede3bace73b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106054811.2817=
98-2-oss.patchbox@gmail.com?part=3D1
