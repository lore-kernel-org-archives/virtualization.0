Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497845;
	b=GBewBNuITsZ8VAf+njJ6QTCFOOCoo2jKn3laabcbKcDCyvfcedAmPeD5ge9c1Q19mStv
	 sXfeSe1gLLgXK90jPA762dN7lWsjhEJSx345rGPrP8m1gbAfL4xLVKUkPx3kHllyYJ6G7
	 qzTEa4hIhKKkImAVvMDKIdeseaSKG+Sj0KGsDdPnPDraSja9lTvcjG9PoSrCEZ/OswMFk
	 uQHBeEXaVBsR1xt7KJdq4v5yHr9EglHmxR/45WlctqZV9cu+OL6GsZ27A+nLatRA1lgcp
	 XacDabyhFX+JMh0xoUp0g/ZkAQqw4ZyLWLQUuJ+1PqiZgpIlWgiQxOVd452UbBI+JTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497845;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Iu6ghqYk9pxdw+HOfbHDT4sFbgm0pTOWC0xDILAmJ9Y=;
	b=zPiU55um0XTLGOrU5RyfCqEYXnpGh98QcVR22db3PPqY1BczeN/YHya8Iqn0nzXqNcjh
	 Cpnurf82+4dSoy3ykI/gN3en2BwClSzJW+BFwg8eFdj2vZYGvr4wRPdxazAvRwnEvLDZ8
	 rCgABVfd7SdpwvKXPDKg+XTi6qHObKmbCvn5q6W2AJ7sx/DZDpZZWliRZp+HcmBAmL5gI
	 U/Tc2kXlZVTHw+zu6zbRehVkIm2a+qrWYb4/KXT5eWhxH3cMOY7jUoJ4aj9KvF4cGCAn7
	 HLPcBBMv6Qzb5EE5KBFbS//Ve5IGvpUW/GbQbm+ANePl4L6C3B14gvl3tx/uGLFuW1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnjtWCKu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF00606A31B
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 12:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnjtWCKu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09B51F000C4;
	Tue, 20 Oct 2026 12:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792497844;
	bh=Iu6ghqYk9pxdw+HOfbHDT4sFbgm0pTOWC0xDILAmJ9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VnjtWCKu+p+VqARG9hFJ3Wy9br56rmoFcgFLFyVH1bOBbm9Qx53MzgjrGsdIYgNNm
	 0Pxhw6B6OlA7w1N5c5C9lA9Vsvuufi5NwgSlRXUnuQ9gW8f7D0Ysw7Msn8vOpTNkwL
	 vl85VLv6VnCQ5d0eroJfAsTqgNM8lZaDQPjBIWFSYmG//d+8ab10g4hAfS0dxUu6gL
	 Unf9JDJshmZcvWO7j3CpEQTMGSeHJuHHifpLRbOUxhrvPv3c4Za50zCrIGdc64zLAM
	 xb9cnaBJlAfWv1F3BjBOoNHfOzE0FB7+4T35O4fZgUkApaHYrylPX5O4xeHtSMt4xW
	 AHvzHcDMzkvlA==
Message-ID: <sashiko-outbox-178924@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3 8/8] virtio_net: cleanup protocol calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <13dd30912d6d03da7f432e115e9db1ea2d2cf37f.1792411304.git.mst@redhat.com>
References: <cover.1792411304.git.mst@redhat.com>
 <13dd30912d6d03da7f432e115e9db1ea2d2cf37f.1792411304.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 12:04:04 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A trivial cleanup removing a duplicated code line.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411304.gi=
t.mst@redhat.com?part=3D8

