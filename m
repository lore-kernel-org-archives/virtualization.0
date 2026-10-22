Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792631779;
	b=ARTJkJb9fgMBMSI8ltGgQ3MnmtExaEFw5ukTj5zByXHzmp99QcRtVNd2/wBK94ShZFqm
	 GcIkPf2gjmi9b3BzgzBg8DO4i36BA/eCB0DeboYXfHX+mOuwY4ac2dUFIluGzBYhE0P+4
	 mPtLjvatqbzWpkVHmtrtk5tirjnT+gOj7U6vx95NUAGmd4fuY7toHIe2QlTE/JoKQl6Ne
	 2yOYBS8vghIssowbYty9D0ARWH2/57X/ben+97BtuyZSlYu1mnNgkfb38Oy51OPpeSnON
	 pCIKpMZEBbgXTJRvT02AquCAlYC5zrrjDVoX+XBiAQmJ9RmvHLbYNAL/GjuLpC8OSsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792631779;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SdVJw9iOwBGVI63XUD09SC3zWe+ik1tQJKtt0TDGir0=;
	b=O43WHMIWlESVyXtD8ioyV9dspclqkXZedW34XxeTqhh6gnW4G4FqaF/7/gIOOfuR9MmX
	 JnbhuHrZE+LXgVHlC5aqByCKR0rolBDne65jZRl78P/7bVncwtCuLOoOzdaNTOzr+8l63
	 aqhPmG66go73iqJdvr5fhfJa2gc3Lk0wSHVzi7p0I7ryjv5/+ltyLlUgYDJIp23T7Jl+v
	 QZjgd3XX24cYGJiMUkelMCxiamgRFEkmN6D9vTdkOW4wV5lotYwRXfohKFaOPzGpRA77G
	 sYIBg6tl7OWiXZS2RYYnz8d4LO2JguXOvYQ5ZFcxNkB4IeYbi0Rmjha2SAxcWcXhg7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DaTEU5wh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7387606A319
	for <virtualization@lists.linux.dev>; Thu, 22 Oct 2026 01:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DaTEU5wh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4841F000C1;
	Thu, 22 Oct 2026 01:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792631779;
	bh=SdVJw9iOwBGVI63XUD09SC3zWe+ik1tQJKtt0TDGir0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DaTEU5whBdxz7HQkdxbLnWGnf9ZzONMkaOesprGjWwDr8QT0P8mhOOPynoaDFyEzl
	 2CAb4hhq8WU2cvixA1nBop2BtPn9bL1mWxOJjEjcH43Bb/RNPhk1g0xpQn2M1/cAcx
	 RaRO8GFGd48Pa4uWxbK2maQkPTFlcqqeAArwJD1XBFg0f9If/5RrgYlO85LycYPn+D
	 k+vlUL1nl6GN+THswnbaUcElxxt61mkRkuXLVFFCauVr4Oji+HPfcZlDVSDwtcwH2w
	 ffpxC5P9kjaPC9lsTXvCb6tY/8yx5Sw7Veo4MxdiAP2Zc/rj8z2j4l/mIvaVYuYgd3
	 LaljXl22cDn6A==
Message-ID: <sashiko-outbox-180838@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 1/7] vsock: constify the transport in
 vsock_for_each_connected_socket()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261020-vsock-guest-ns-v4-1-047527cfccfc@meta.com>
References: <20261020-vsock-guest-ns-v4-0-047527cfccfc@meta.com>
 <20261020-vsock-guest-ns-v4-1-047527cfccfc@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 01:16:18 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Allow const transports to be passed too. The function only compares the
> pointer against vsk->transport, which is itself const, and never writes
> through it.
>=20
> No functional change.
>=20
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-vsock-gues=
t-ns-v4-0-047527cfccfc@meta.com?part=3D1

