Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566529;
	b=PAnSkZqzNQZ6/2+b8Q7qEVvvKiQZ76/7UqN4SH8ekoYajZ9lVw7gM17ico5BZcDECW0Q
	 UvOV6IMLam7zQZP1JepVYdmGwv9LGzGynw5V6RUMiQgULV9GO0OoR6ZD8Y9y2WEOxy0nT
	 niSf7xpsdKL4O7CYVWTlwzeIRol4nGcS21T6NNedA/O9Ls/V6ZOY26KDYotc37R8yLONw
	 WM0M5ZPkLFTlQWqx32p+lzYzQTTEywrihqxMp8Ly7OulalnAXT9/AqSYhc76dYBlK6XRE
	 xZBC3DStJqJbrZkf/AKupp1gqiQcekM3g8W42qrTCOAxFjFlnWJr2y2Rzn83iTnYLSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566529;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sXTe5w35ds3H2/uN1H+httW4e6gCEIoQ6kelC0Vj2XI=;
	b=kt9RetsXFKD3gqpsKUIkUmwpoiLLYBx94lABnejzoDnwQAiVQ/uBTZmXUJZCq85lqhIV
	 EMDRdgC3duy697fXCHVK2S7HaW59vXYTzoScM6QELSRFZAKHrYKMND2V1sGTMP2wdBUXP
	 xPI4gUFK0jNHozJUfyR2PqEaPPJOng3cH/O8nJc8Vci2+AIgoCIVPPpkrPSwkICfkwZcQ
	 w341j5r3F/zJ3xFtqzacuqGaMSf9rCrkmH9G/+oCM7NYtxPFQHnqPnf6Y6BCFUSBEF9Ld
	 tMTYhuwbYzivkTrdgDZWFHEBZtm0B97JyObn7/Oio377904OxpYyHwJiVBRT0YMWQFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSPPC3X4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86E606A338
	for <virtualization@lists.linux.dev>; Wed, 21 Oct 2026 07:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSPPC3X4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0031F000C9;
	Wed, 21 Oct 2026 07:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792566529;
	bh=sXTe5w35ds3H2/uN1H+httW4e6gCEIoQ6kelC0Vj2XI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OSPPC3X4ElLQ68+Jb3SPK6L7Iec4zTlSwOemVnpIzrSuxrgneXzC/OXb6zcgMVGla
	 cd/TQmikqzuSZPYn8tyJ88PhVFjzFgjptQW0NhMLln8klzmLnTJyuwBY/+xFcEldnx
	 ZtkLRgoWRQb7umrJK9p3gJZe4jjGKXiyfxbRejuehFCR+9/KdESZGDrVz7VXCHk4xI
	 TCp+4LUDTiNaAnbmrXdlqsNtFtCw20quGohucXk6lmnAp7VT+yT4sNO/gtQ5U+jqJD
	 q+dqLyZId82pEk8L97Ql9tlgEhBQ6PRB9q82DZezuFLxMRX5ySCGP/nJtRKOJK+e+q
	 5tDGQHtX7lxrQ==
Message-ID: <sashiko-outbox-179857@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost/vringh: reject zero-length indirect descriptor
 tables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fang Xieyan" <fangxy@xiaopeng.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261021070242.75009-1-fangxy@xiaopeng.com>
References: <20261021070242.75009-1-fangxy@xiaopeng.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 07:08:48 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> move_to_indirect() accepts an indirect descriptor with a zero length,
> setting desc_max to 0. __vringh_iov() then reads descs[0] before
> checking the descriptor bounds, resulting in an out-of-bounds read.
>=20
> Reject a zero-length indirect table in move_to_indirect() so the
> caller returns -EINVAL before dereferencing the table. Also use the
> converted length in the warning to report invalid lengths correctly
> when the vring byte order differs from the CPU byte order.
>=20
> Fixes: f87d0fbb5798 ("vringh: host-side implementation of virtio rings.")
> Cc: stable@vger.kernel.org
> Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021070242.7500=
9-1-fangxy@xiaopeng.com?part=3D1

