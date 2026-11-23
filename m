Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428032;
	b=NhfGadEK9505vu2h2RBuYjAs7coNCnglySaiv8WfyTWy3FDF4loq4ZWdvNiaxu/7rsSc
	 BS3wS0b/SzYL7QUE8Khbh6GET3dNfiMVfEoeI4lpdOH1TsM13fGHqjdGTMiJsKNuUhf+3
	 ka9YGuammjPTX5NnEpI39u4MBV8yoH6FszG8Zui6Hwp+aE6+UNdrlwu1dsjRvpJ3SEAzO
	 xKI5w3AjUsLnetvUhGiqXBMsQNGbjoG9ARbujRCAS4wUuVy3wfZ+p/Jv1gZ/OPiz5q+lj
	 TfUBcuxbDh1dRJGu8205vut5BgXFbdGpsF6Fx5oc+9FMe82NR3KFuaJArFtaV9yAVxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428032;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G2xITjz72XEcU91cNyVyrvjkxnIPvCgbzLVzYziaINU=;
	b=RKmZwvd6EoVKuageL7SS85M+37ar0U4orq35aad2tH18Tt8yrSaK9ZvAhNKkFFGy589p
	 EjkyzHYkG7aqn3Vhccde6rqU5Q+RNilYe1JK5XCk3lUmMpq1DVyi7kQiJp5vXUhE4c/oL
	 7S4tAWKnktXbqNOzyIrHFFzXxEuJGDhyUywb31GfqcydfQ8JimuXChClKtiPIpHN0CAhT
	 sHxgOfIfmjLzDWU/3Zpq2bgaMt5FYy68T7EvlnsuvU1+Wqja+ekphsuQ+i5LGvKMQxgrk
	 8+rCmnyBZ++L48YJgD+Ix7/Qay04A0/boWei3t7VLvf5hbFBXkqBIdBik9wHR89J1Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Om8A/KLj";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CD9606A321
	for <virtualization@lists.linux.dev>; Mon, 23 Nov 2026 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Om8A/KLj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FFB1F000C4;
	Mon, 23 Nov 2026 10:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795428032;
	bh=G2xITjz72XEcU91cNyVyrvjkxnIPvCgbzLVzYziaINU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Om8A/KLj1XKgBv6K+taInHbYQ8UcJULUpCN4g10oLRRlD1XFlpfLHYxqIl0JpmPS2
	 I5TE3mgNnWrUmZkE8VcDdqlXZXahfHOiMXP1AhZnnOobH4rOzfw+F4Mm9drZPRdijf
	 PGRhYE5dTqVXsuZ+/IeJZo4JVbbeqJDYeVGqpMkmVschGY+dfxexxvgTtXZ1R4mM5F
	 dMmf7PsOH7OM9t4k108tt1vyMh4dt4iMUgChRQQiOh2QLzF9Zw58UpC+NLEqwGdtpD
	 c5gjeJDxr1CPUQQtoR0TJSq43M9jHZmtpzyV7K8XAL04QlkzXRVGh+zGA4aSyk1Mzy
	 IB+IsLuOPvQXA==
Message-ID: <sashiko-outbox-229016@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtiofs: fix potential unmount or device removal hang
 due to stuck FORGETs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Wang" <liwang@kylinos.cn>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261123095455.88622-1-liwang@kylinos.cn>
References: <20261123095455.88622-1-liwang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 10:00:31 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtqueue_add_outbuf() returns -ENOSPC when the virtqueue is full.  On
> this path it can also return -ENOMEM, when a split-ring DMA mapping
> fails, or -EIO, when the virtqueue is broken or a packed-ring mapping
> fails.  send_forget_request() turns only -ENOSPC into 1, so
> virtio_fs_hiprio_dispatch_work() stops and waits for a completion.  Any
> other error frees that FORGET and drops its in_flight count, then
> returns the negative errno.  The worker treats every non-zero return as
> a reason to stop, so the rest of queued_reqs is left unexamined.
>=20
> hiprio dispatch_work is scheduled only from
> virtio_fs_hiprio_done_work(), which runs from that virtqueue interrupt.
> Once no descriptor is outstanding, the device raises no interrupt and
> nothing walks the list.  virtio_fs_send_forget() submits a new FORGET
> directly and does not schedule the worker.  The queued entries are
> reached again only if that new FORGET is placed on the virtqueue and
> [ ... ]
> continues with the rest of queued_reqs.  A full queue still returns 1.
>=20
> Fixes: a62a8ef9d97d ("virtio-fs: add virtiofs filesystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Wang <liwang@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123095455.8862=
2-1-liwang@kylinos.cn?part=3D1
