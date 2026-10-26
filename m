Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016707;
	b=rD5SgjJUErf7WcRjXlSMqXaVCGu4EWfAU0RmclwNSLgIn3x/ixAPvbFfXAXtb+trmt4+
	 3xMLLyMaC0nT057tG62lncnl8WUyhoQ6rexWF6QNE1+i2NlYTPPmvIwC4ZyNas8HIQVKX
	 t1LUqB2a2MPJ/T7XMCI+Oq5cSym+YyoyYlsjiXj+rDy1qw9QErW6XlLRlPTQKPn9JEpcU
	 89z9H3I13/+tGlDj4BvINLyOyxG5pFzWsqkLy8BJa43LhJWstdICwhwzaUgzwAtKKzMPA
	 neqtoLiozLrMfg/c1yz/859VrJwQiB+Dmp5tUZWDWgbJQU3otCzwFyIoW2PEiOzD4jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016707;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pggJlINKz2IhjNaJOqdqtptZ0+BGi78XBoGF4t0L9F0=;
	b=reOW5Ta0nxCp8a294MeDDZvMeEL1V0PN9/tVgy5ky4uQCVAw1Ldk7XljL8cNb9UedymG
	 X3bz+XT6GTTBiAqYPQQeWdNHHR3UR/+NmwciS51MmkeBqR1FwmdfxMPi8ZFsWZAiw+KEL
	 5VP54rucb7C1VaZnp1dD4k6Mvua21RB0sYaY8RsC+KZATJS5Fh2ccBAYrrpDVKaFm8DGZ
	 jb3htZn3E9lO0bg5fZZ9fgJH37rC5AQxHKbRJhSovfPCnD0rJfEenAf6Vn/KKbLoqNAyo
	 YaDKgs3wxf5RhviQAqSCeGhO/3fWuF3BC8QSIQwPnSydppL4bpO8UyL9Qx32GfTIJHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkMofZs8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA90606A31A
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkMofZs8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B0F1F01825;
	Mon, 26 Oct 2026 12:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793016706;
	bh=pggJlINKz2IhjNaJOqdqtptZ0+BGi78XBoGF4t0L9F0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bkMofZs8EKPyJ8gsuy5B4w1cVf67P/1z7Msmz5wLNIxukmz8XpS22mS54dqYUv07N
	 +g2OowaU+swbeGNwr1kb3R0ZlQA+crJvSjtOIJxGvmj4uUuKdMX2qzjFmfnikjH7vY
	 6q1O+QgLzkacWpw/L8MbP0TDj4BMQ8BVi6YDE+6QrDDb7i9RX2d6FHvyQSIgA8Y6w8
	 kzk5MWFn23e4d0B4w2063nS+/aURpUa8pKI0qTc9+6ZjXSawqDZtfXah2qZukllt6O
	 GMpNFBgZdwr71BoH9sZLbAfjAd1fRXl6ZOvlUvcEuIu0IS3kmXbwHo65GrqQwITe7c
	 dF1gYh00CzegA==
Message-ID: <sashiko-outbox-185178@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] virtio-blk: Fix zone append sector reporting in batched
 completion
Reply-To: sashiko-reviews@lists.linux.dev
To: shao.mingyin@zte.com.cn, virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <202610261955196384aSLGuy3_0MiTvlYXVdiC@zte.com.cn>
References: <202610261955196384aSLGuy3_0MiTvlYXVdiC@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:11:46 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Shao Mingyin <shao.mingyin@zte.com.cn>
>=20
> For zone append, the block layer copies req->__sector back into the
> bio in blk_zone_append_update_request_bio(), so the driver must update
> req->__sector with the sector reported by the device.
> virtblk_request_done() does that, but the batched completion path used
> by virtblk_poll() only unmaps and cleans up the requests before calling
> blk_mq_end_request_batch().
>=20
> A zone append completed through polling therefore keeps the sector that
> was assigned at submission time, and the file system or application sees
> the wrong LBA for the written data.
>=20
> Move the sector update into a helper and call it from both completion
> paths.
>=20
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/202610261955196384a=
SLGuy3_0MiTvlYXVdiC@zte.com.cn?part=3D1

