Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6FA43933A
	for <virtualization@lists.linux.dev>; Thu, 30 Jul 2026 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419719; cv=none; b=lRi8wJuXHUQxXLJqGLFoe9tbGi4a/NOLuPOyleQHak4NRjVU5REjzZn34P+I4PTGr+GvJJvgiUfBstFDpGE8CfzxvUV+gQq7vx7flcH1zPUw0R1CnV52uZAbaerEKuzi3gD3+oknsFV1x6kah0S+F05exeKrlA+4hm9koCNSIiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419719; c=relaxed/simple;
	bh=jw2FzdY8gX+RdVSUNHD/1Z45SnK0pCPcHOh2A+Uq9oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxei5mIEUp3jnxFZApXONjLrJTrIZLvQwxrDYes/S0qkTAbUMkbdYy8tKKw62QcSWg4jwdG9ru6fYDJSsFMHlT6319esq89dJES12VIJTAamY6GndCMB8bf8Wztt3hOTAQpZDpZ5+iyYeyto57b993qnsLsKGFb+07TzO2TJDcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K1UD4rZf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1UD4rZf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785419716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kA6RdxhutI1Br8ceaw7LS/E/bmiLwIkU0wCTumrQB6I=;
	b=K1UD4rZflgk2j9n55IdrEcVM53/5xk+XmCWaEAs07biSLOvR26oyRBen/0Eoq7s0XxGqgY
	JoxihF16hUgo+oFb7YjA+KGdb/g2C19zJ8wRIW+u1ngSHWdlhxt+57oeBkL28y+o+LRlZX
	DKe4nzmWDMLivNiylSRyePOK9Vy1HX8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-tegOc7dLPx2YyIio0TIW2w-1; Thu,
 30 Jul 2026 09:55:12 -0400
X-MC-Unique: tegOc7dLPx2YyIio0TIW2w-1
X-Mimecast-MFC-AGG-ID: tegOc7dLPx2YyIio0TIW2w_1785419710
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54EE718004A9;
	Thu, 30 Jul 2026 13:55:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.133])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A7A85180049F;
	Thu, 30 Jul 2026 13:55:09 +0000 (UTC)
Date: Thu, 30 Jul 2026 09:55:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, jasowang@gmail.com,
	eperezma@redhat.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: prevent stale IOTLB after ACCESS_PLATFORM
 changes
Message-ID: <20260730135508.GC1442692@fedora>
References: <20260730040938.1725757-1-physicalmtea@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SVDwW4C3wzVzfyYK"
Content-Disposition: inline
In-Reply-To: <20260730040938.1725757-1-physicalmtea@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

--SVDwW4C3wzVzfyYK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 12:09:38PM +0800, Jia Jia wrote:
> vhost_vsock_set_features() initializes dev->iotlb when
> VIRTIO_F_ACCESS_PLATFORM is enabled. It does not remove that IOTLB
> when the feature is later cleared. The virtqueue still points at the
> old IOTLB, and vhost_vsock_handle_tx_kick() passes descriptors to
> vhost_get_vq_desc(), which translates them through that mapping.
>=20
> A userspace backend can enable ACCESS_PLATFORM, install an IOTLB entry
> for a payload GPA, start the device, clear ACCESS_PLATFORM, replace the
> memory table, and reuse the old HVA before submitting the same GPA
> again. The feature state then says direct memory access is in use
> while the TX path still uses the old IOTLB HVA.
>=20
> Reject clearing ACCESS_PLATFORM while the device IOTLB exists. Also
> keep the existing IOTLB when a feature update leaves ACCESS_PLATFORM
> enabled; VHOST_SET_FEATURES is used for runtime log updates and must
> not discard the current translations by allocating an empty IOTLB.
>=20
> Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> ---
>  drivers/vhost/vsock.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index ae01457ea2cd..57e8fd1eb670 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -798,6 +798,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vs=
ock, u64 guest_cid)
>  static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 featu=
res)
>  {
>  	struct vhost_virtqueue *vq;
> +	int ret =3D -EFAULT;
>  	int i;
> =20
>  	if (features & ~VHOST_VSOCK_FEATURES)
> @@ -809,7 +810,14 @@ static int vhost_vsock_set_features(struct vhost_vso=
ck *vsock, u64 features)
>  		goto err;
>  	}
> =20
> -	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
> +	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> +	    vsock->dev.iotlb) {
> +		ret =3D -EBUSY;
> +		goto err;
> +	}

This prevents one problem but there are still other issues with how
feature bit negotiation and the IOTLB are implemented:

1. VIRTIO_F_ACCESS_PLATFORM is defined by the VIRTIO spec and must not
   be change after feature bit negotiation. Please reject all feature
   bit updates except VHOST_F_LOG_ALL to comply with the VIRTIO spec and
   eliminate potential bugs in drivers/vhost/vsock.c.

2. When the device is reset, the iotlb cannot be left initialized
   because there is no guarantee that VIRTIO_F_ACCESS_PLATFORM will be
   negotiated again.

> +	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)) &&
> +	    !vsock->dev.iotlb) {
>  		if (vhost_init_device_iotlb(&vsock->dev))
>  			goto err;
>  	}
> @@ -827,7 +835,7 @@ static int vhost_vsock_set_features(struct vhost_vsoc=
k *vsock, u64 features)
> =20
>  err:
>  	mutex_unlock(&vsock->dev.mutex);
> -	return -EFAULT;
> +	return ret;
>  }
> =20
>  static long vhost_vsock_dev_ioctl(struct file *f, unsigned int ioctl,
> --=20
> 2.34.1
>=20

--SVDwW4C3wzVzfyYK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmprV7wACgkQnKSrs4Gr
c8iuEAf7BOAf4LqI2+MgMLd+yvBG8EGJT86K0c+qhFk2J8MtCQRS8WaKnPJmnDvS
/oDOhvCpPZa1U07FFcrabv3hRF9pgJavgivzWwfOUyyb64tDiF71MhXv6dgv4Dh0
048zctZ5eP1okqvt1jWTFWKAZwzcluvV5cwIt0BmqRqfpFmH0b2zMZy71opBE56Q
dVgsw6ae4axuoZZZYsokOQ1JKzvRIQKj9oWlysHUhyL9WLsogB8wyKLi4F5KGcwk
bZZWNbGffs2v8olgI+Iffni89ziilv+/3OL7lFlu4W6V9zIzbDjBFEaMJnqBWyYz
YfZoegWbYr4DmbjdNnqH19M2He8wWQ==
=0EEQ
-----END PGP SIGNATURE-----

--SVDwW4C3wzVzfyYK--

