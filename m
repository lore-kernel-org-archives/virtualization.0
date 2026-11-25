Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606344;
	b=kzLLAFzF5X+tEjIFN5nmOKhqrOYtltKQ/SGlB5RwMUzVOxVoO8mYvGQWw7pCn2v5LIZU
	 N66nXaqJ8eqvgiTeR03J4S/IblSSwipUPkXXsMojCbYlWzMsGHiD8kb5PfSY4aVqw4D2F
	 eboNzUI67tC4L35gWskhFYPeAsm30u6Vv5NPiHlmp3aoiBB6eTZva9eonhIJ8lecqQTPa
	 9nZQpmCn1Dn2QvljTpky4VZaommjVvZsN9rzR3IeEj8dOwY63s5s//rMeigYArf/Efo3M
	 Cm0OAVHdjiO14B871D8n/q99JaHzHo0EIPwbgxJdbMeAGz8JNSz6hQ2a5yz1vbvw1ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606344;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UZoc/645hI9oanx3wdZsEQpSlUwXzgLIQBBQs8jDPqc=;
	b=dF/yQPLrtaypgMqPYaZklyLiU4lKksyGLXQ6vrFMgjxoKkf8sJTUcyxVJ2t6MBugYDlt
	 9CYkeWGM8IVQcH4Y3vlu7I+x0O6HU4shffIP+5LmWkxIK4v55iAjwa11J61qfnH000q4V
	 V6OmBskw/N9wV21BZQFKHJ5J3ng0T4psWhroqsHHl22zK2P0KnsSjwiYIp5iIA433ZmeG
	 p/s3+DrT5lYxGnk2AienuSXuNMHzX8Z1aK2RoTEkcOBRdbnXhF155eoj0dUwum7B5XZvC
	 y/95s2XgN8t8harySIAaKVAtVlKGX6w/4Umi7XwSK6mqWSS9KMAEEr8DhSbjS8Miz+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7AXBTbA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F36606A321
	for <virtualization@lists.linux.dev>; Wed, 25 Nov 2026 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7AXBTbA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A7C1F000E0;
	Wed, 25 Nov 2026 11:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795606344;
	bh=UZoc/645hI9oanx3wdZsEQpSlUwXzgLIQBBQs8jDPqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O7AXBTbAvL/qCvZiPDfsenyDPOvZsuYAAbV/wtbPtsptFlRDmWaR1/3Ac7J4BvGKv
	 kjtiuVzq9y8X7plN+GfZbx9v3dI+1s8mxDBiw2m9fe0UhkIDdcaL69Um5s4WepOIuH
	 3LZ8KPQbSFgIZENubIP5Uw9PLuh5AV9CrhwdHQGQRoqiel1GzTPiFHKlsjAsuZ237A
	 FG+8lfvWGFCU0d587GmrHiDSOIvEIrP1DEXuSbvPk8NY+S+0TiN/zbPsiAr0dq8WrE
	 zdSgBHawrewzkpDs8c50Brhrah6CusVSTtf1DnBqhEOHT8w4VRnIX1oG74s/vh604y
	 G08HN1wX0sKhQ==
Message-ID: <sashiko-outbox-233257@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] virtio_console: Put device on failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michail Tatas" <michail.tatas@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <awbGObIpMjR21JSC@michalis-linux>
References: <awbGObIpMjR21JSC@michalis-linux>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 11:32:23 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] virtio_console: missing Fixes trailer for alloc_buf() device
  refcount fix
--

commit 0d2904b89fd07ffc0b8eae0baa3194301466a9a1
Author: Michail Tatas <michail.tatas@gmail.com>

> virtio_console: Put device on failure
>
> If dma_alloc_coherent() fails, the buffer is freed but not the
> reference which is acquired before calling dma_alloc_coherent().
> Fix by calling put_device in the error path.
>
> Signed-off-by: Michail Tatas <michail.tatas@gmail.com>

[Severity: Low]
This fixes a device reference leak in alloc_buf().  Should the commit
message include:

  Fixes: 1b6370463e88 ("virtio_console: Add support for remoteproc serial")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/awbGObIpMjR21JSC@mi=
chalis-linux?part=3D1
