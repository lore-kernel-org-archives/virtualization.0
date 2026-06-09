Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA3647DF93
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017786; cv=none; b=iUB90taifzT2GQCnjz/y9zxD0/+iqq8W319ZmHl0ABh1+PzE3aw7EhQFgOQQR50366nKDiHx//rT6YxyEfA26Mky+NV+QBwmyhGzFcxQaf5FkQ8mLmKJPNM3VtDJR7OW7OZym+9EEijl1qa9Q9Mejp2KtKrpOzCslR5BAW3ZZU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017786; c=relaxed/simple;
	bh=O5XKRkoQdjmL/UWfTDl12QFCnFMOKjx4BUnWq82ThMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRKLB6xSpFZ8TokQxCgbNhLONeWT3K6CU9H6WrW+0oRIrBwYED6rBY+Z4caEyIoQ2LyF09q3rhE04i8uGXW7YQyUFp4D5K4hb7GIVjz8t3EpnHDvp86kptNYEz3a/r8q1b68NrOZuGH92mR/BqZuI/n69AGaW8rYdBtC6KCeJ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZcQ6GgD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZcQ6GgD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781017784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VXHffyBCPH7ubBJYAlBJR2395nJNCoGqlGt3bNjYf3Q=;
	b=SZcQ6GgDTYShp2sPGFnKa0H808kVh/mCjSZJ+D+RUqYeSXHIIdmIl8amamtRGya6AtHZcI
	/nDu0ZhLPi0mm9GiaDBkqwriEDwvvkCpqHQM2YigKssEvXxzO67hAogTEneE7xgRZfdAPV
	UvjWhJn8fOfrcNiALRTDWydbu5eab20=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-KQp7QHydNGinLi5ysmt3Lw-1; Tue,
 09 Jun 2026 11:09:40 -0400
X-MC-Unique: KQp7QHydNGinLi5ysmt3Lw-1
X-Mimecast-MFC-AGG-ID: KQp7QHydNGinLi5ysmt3Lw_1781017779
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE209195C248;
	Tue,  9 Jun 2026 15:09:38 +0000 (UTC)
Received: from localhost (unknown [10.2.16.141])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A22A936927;
	Tue,  9 Jun 2026 15:09:37 +0000 (UTC)
Date: Tue, 9 Jun 2026 11:09:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio-blk: clamp zone report to the report buffer
 capacity
Message-ID: <20260609150936.GB57581@fedora>
References: <20260607124834.3059944-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rUlFp7cNxuZOyAbC"
Content-Disposition: inline
In-Reply-To: <20260607124834.3059944-1-michael.bommarito@gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95


--rUlFp7cNxuZOyAbC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 07, 2026 at 08:48:34AM -0400, Michael Bommarito wrote:
> virtblk_report_zones() trusts the device-reported number of zones when
> walking the report buffer:
>=20
> 	nz =3D min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
> 		   nr_zones);
> 	...
> 	for (i =3D 0; i < nz && zone_idx < nr_zones; i++) {
> 		ret =3D virtblk_parse_zone(vblk, &report->zones[i], ...);
>=20
> The buffer is allocated by virtblk_alloc_report_buffer(), whose size is
> capped by the queue's max hardware sectors and max segments and can
> therefore hold fewer descriptors than nr_zones. nz is bounded only by
> the device-supplied report->nr_zones and the requested nr_zones, never
> by the buffer's descriptor capacity. At probe time the request count is
> unbounded (blk_revalidate_disk_zones() calls report_zones() with
> nr_zones =3D=3D UINT_MAX), so the device-supplied report->nr_zones is the
> sole gate: a device that reports more zones than fit in the buffer
> drives the loop to read report->zones[i] past the end of the allocation.
>=20
> A malicious or buggy virtio-blk device that reports an inflated nr_zones
> triggers this during zone revalidation at probe. KASAN reports a
> vmalloc-out-of-bounds read in virtblk_report_zones() against the report
> buffer allocated a few lines earlier.
>=20
> Clamp nz to the number of descriptors that actually fit in the report
> buffer.
>=20
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> v2: drop the explanatory comment per Michael S. Tsirkin's review; the
>     clamp itself is unchanged.
>=20
>  drivers/block/virtio_blk.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--rUlFp7cNxuZOyAbC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmooLLAACgkQnKSrs4Gr
c8iLEQgAhDb1MrzY00/WqtMnXWx3WDfzpd+QbRidYgHKTRfAADkmiU7vFSvCQza6
otrKhzylaqv9PmUW8L1/SzyiKkjk6omCv+U50xTkbl7fqZONpq1B1DK8L0OZRIIy
yu4ub39jGWD15NXr0xQvlcWuH/hq+ayEnHKUBe0OyC7oJs3CMSI8LsWR0wFdUWJt
3o9bG976oo+bsO5JwE95X+YH2fRrHDQlFkdbx4FaQoUtYS6CoVaYtlrY9tqP9YO8
2HJ88htlUfpw4LdliojMBFvG2FCNkFhlyRBR+ntwGPW6rBOZPnlq/9Fbk6YH4th1
EDOexdDUD0tc2D2AFoUYt1Sgv/7+Xg==
=XD3B
-----END PGP SIGNATURE-----

--rUlFp7cNxuZOyAbC--

