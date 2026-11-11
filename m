Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794356219;
	b=P1wHovUBoQ1bmizF6aOwDue6l03z3xKj4mf0Per6rxAa+J66YR40GLnwmwvsM4WOA00K
	 +HQbqfF70rJLIbi5GT8Z2Yq0QstOXzRGtsR1YbDH5H+gmi+p3v5ksNYlUOtR2Kx5tRfJT
	 e9f8JRA5cVNDxJS/1yn4N7z4PHuyzxvGCree1Rsm0qArecARi9fnPPMyXPrwMjQDChDHA
	 ExbdbWD+afBiD80di8NsqsrqUNDfrCAMzwD3Er6gHUDbgTnDffKQz7W7Y0LJhZqf7dK1i
	 UdxIN5v65vTR0xMhh45LomssbJbj62n0O2NCOUsMSxhUNkkJ7myXApjIghYygEH7Phg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794356219;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TIukAghquSYWCBmrgWtpHnkS0jLroFAYouW1aMVmt3w=;
	b=YLZa7REDWcc7kAIih13eTDNfY239GyevGH487PlDjeVWYlUR2XRwahnUpyBp0rvoE90H
	 LFhW9CkaQsX3jMSbOZXQriTbKfsHfsIYNK+LWuDXVlU/RNOXfxDyGwAQn/UIkbr2FZmIq
	 I/wuiYzD1gg29Fakfob+ruCiiu7Xa16iP7blhpfZG7R3SmzByUwTXXvTtDsheNd/bLZOb
	 gVRMgx0vaBiIgoWOO23Mtzm62XGawzrXKVteZwFV6wX1bbmed4UVP0sA2kL0gMmv8ul4w
	 ig/QZ8C8v9OXzLLYkXG+BEbkJsee+lSLaOUXb815wVz+kH3Z4Ufv5+9Zu4NFajAn0aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DS37ojzu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF35606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 00:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DS37ojzu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179071F0089F;
	Wed, 11 Nov 2026 00:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794356219;
	bh=TIukAghquSYWCBmrgWtpHnkS0jLroFAYouW1aMVmt3w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DS37ojzuS32ZzCWJA2TwVwdqnHLUSxpV/6iaIuMLk1UpJepS2TzI0iEL1bWGHg+vw
	 xUu3nfkBY2P5TMS/IP5r6HbU0RDylxT/Zrnzlg/nLek68l2K3fyffqgSfiT+uFvdVe
	 6fqpLz54pNAAge1DTw8hw0MX6TNu5rb0cG4cVONYYKL/ohya3U29ZPaCAWUHeWi8OV
	 HGZpQJ4a2zsPDcI3K9qb5Y+8nFUs4IMeX2D3YOiuQjKT0Wun8BECzFyDOK97E0qjyO
	 br5NSSmxAAgVmQl0zenVeS99usuFUQaxn8hyzsFqF2hn2DNp/FAGw/woNSmglktUMU
	 UGHIQyQzVh7Gw==
Message-ID: <sashiko-outbox-208006@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v24 10/16] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111000543.28550-11-mynameisjune111@gmail.com>
References: <20261111000543.28550-1-mynameisjune111@gmail.com>
 <20261111000543.28550-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:16:58 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Control requests can expose caller-owned payloads to the device after a
> synchronous send times out. Keep request and response headers and
> payloads in the reference-counted message so caller cleanup cannot
> invalidate DMA.
>=20
> Keep the queue reference until device completion or post-reset cleanup,
> even when the caller times out or is interrupted. Consume the caller's
> reference on every send path, and let response readers retain an extra
> reference through copyout. Check payload sizes and allocation arithmetic
> before building the scatterlists.
>=20
> A control value payload is also read by the CPU as a typed structure.
> DMA cacheline alignment alone does not guarantee the structure's CPU
> alignment. Align regions to the greater of the DMA cacheline and
> control-value type alignment, and reserve prefix slack from the buffer
> base so typed accesses remain aligned while scatterlist regions stay on
> cacheline boundaries.
>=20
> Keep response values in a separately allocated aligned response buffer
> so INTEGER64 control accesses are aligned from this patch onward.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111000543.2855=
0-1-mynameisjune111@gmail.com?part=3D10

