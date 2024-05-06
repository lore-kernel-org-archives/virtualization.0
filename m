Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3F843687
	for <virtualization@lists.linux.dev>; Tue,  7 May 2024 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105292; cv=none; b=UA+C31PISzzO7rpnkXWJ28p+97cGClsqnNk/HrZsyM2ypb8aGawgZLgZ4CH73hVI2hlqfmh0Axgonv+TZ41XiLBRe4KHdR54fJoo+i4xFlMNoKZ7g22rchaoTo7lrLxbR82Lhi9UbNkiR401Jq5rWxPpSdspFcT27jZGjM2jKGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105292; c=relaxed/simple;
	bh=y7i2hEwDtLoAL0zN05ZxWAAqx2C0UDEA0eRWMmjynxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bn1nmKWiKpvxSt2lnGR/4+E7rTKxivQ0Tx9ixmO9tMlN7OwDpeY6LNFGd9y38qWfCwKv4uutP8t/fGXnp+67PWSw/Zo3oP5Kfg9ai9j3oPnJuLb2vxDgRtzCePKDDGzWsTX7lIlYAU1iy4EFpaMnc8VPnFTn7SE8+C7n4ufQdXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mq2EXEVa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mq2EXEVa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715105289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VXfQGtHTyEat9Ct9C3ASeBQzuOOjrHkeR8/RguPGAg8=;
	b=Mq2EXEVa/g1PJTnXXAdAoCshLBPb7OxPvTrJnf9gRcWXB1NIn0h55KLLAV7/zIjQElq5X1
	JXRT2ySVRK+0akxVcIkeVEbWQrUexqHQp50nHsg+tT3yZUymfk5EwfZyguRt7Q3DOieW+w
	fIGSZuVewK3D5b6+Kvi0NrxXOyRqeEw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-PzMpTi5oOh-haQOMbym06w-1; Tue,
 07 May 2024 14:08:05 -0400
X-MC-Unique: PzMpTi5oOh-haQOMbym06w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15D463802ACB;
	Tue,  7 May 2024 18:08:05 +0000 (UTC)
Received: from localhost (unknown [10.39.192.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1F92F40C6EB7;
	Tue,  7 May 2024 18:08:03 +0000 (UTC)
Date: Mon, 6 May 2024 15:52:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Cc: virtualization@lists.linux.dev, vgoyal@redhat.com, miklos@szeredi.hu,
	mst@redhat.com, dgilbert@redhat.com, yorayz@nvidia.com,
	gurtovoy@nvidia.com
Subject: Re: [PATCH 0/2] virtio-fs: introduce multi-queue support
Message-ID: <20240506195203.GE7375@fedora.redhat.com>
References: <20240501153817.540855-1-pgootzen@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oREzGKP2LNww9wyl"
Content-Disposition: inline
In-Reply-To: <20240501153817.540855-1-pgootzen@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


--oREzGKP2LNww9wyl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 05:38:15PM +0200, Peter-Jan Gootzen wrote:
> In this patch set we are adding multi-queue support in the virtio-fs
> driver to enhance performance.
> While multi-queue functionality has been in the virtio-fs specification
> since its inception, the current implementation in the Linux kernel
> creates multiple queues, but only enqueues requests on the first request
> queue.
>=20
> The first commit in this patch set limits the number of request queues
> to the number of CPUs in the system, to reduce unnecessary resource
> consumption on the device-side.
> The second commit adds a multi queue mapping to the virtio-fs device
> driver that is created using MSI-X affinity mappings or, in case of no
> existing mappings, by evenly grouping the CPUs and dividing the queues
> over these groups.
>=20
> Future work in this direction could include:
> - CPU hotplug support

It looks like this series is safe to merge as-is. Hotplugged CPUs
default to the first request queue. It's safe because mq_map[] is sized
to nr_cpu_ids (max number of possible CPUs) and mq_map[] is initialized
to 0 (first request queue). Hotplug can be added later.

> - In case of no MSI-X, using the created multi-queue mapping to set
>   interrupt affinities
>=20
> See the commit message of the second patch for performance results.
>=20
> Peter-Jan Gootzen (2):
>   virtio-fs: limit number of request queues
>   virtio-fs: add multi-queue support
>=20
>  fs/fuse/virtio_fs.c | 73 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 65 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--oREzGKP2LNww9wyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmY5NOMACgkQnKSrs4Gr
c8hjqwgApKT2neL4YdGuFVMy4X0okUKmc5wxaaPYRJR0OUt+0BvTal7ygmHLMx9h
t1rH2YxMCIrztuJT7iwYFlSJ8mjC+LGq3t9xW3XUDfksfVT2kcEXcKKHUUSHauFM
8ttm0skTTDEty7X/K1vYTa2jPr/IfRcPuolOjFwac6qfmCG/wTjdGWNV04GxbwtH
rvsuosGLFoOK5X7ol1/+oeSkJ64bA5yUMdt8Pc39R9VMuyQnZlydQtFX71ykYtcM
U2lWqNhQQFL1E6+nlL8bR89p45D9UeMeIxMfa5XEQ64PxB+H1iOr5AqKTZJoPWnL
ebEoeeHMUSkmk2q5c2KoEdmnmqL2Fw==
=8/F/
-----END PGP SIGNATURE-----

--oREzGKP2LNww9wyl--

