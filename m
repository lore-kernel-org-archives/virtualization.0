Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793367648;
	b=F0TFpSgIeDGERDgClicBY5h6EAh0lFPazig6cPZi0Xe9INWW6Pp/c8XnlnCquF52v4Vz
	 g76RDzM3ZwSdG85hDkNoAqPaVDYO3B3HrhlwnWqOGPIg9mUQg2ayRGexnXYUnQvbNn+IJ
	 EwMaEcXcnbDAfCcpTTDJ7VziCHjQxlavtZJQktf0DKMNBl12Bz4riUP9nQFahrIirHKyX
	 FvoHODIXTK6oyL2tnsXErjDHiqw/ixFAE32jWGggIceqjlw0czABHiQUc5TYt5DGLX1c4
	 +1AGaXgIaWaogZPoYaqQDPBxj0cMEu8cO0igLZyCGUCLpT41xGwA6dpO48FdQIm7VHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367648;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=F4jA2sGet+wo1wAPwIFRYYY6CIoJUevKac623tueKBo=;
	b=hh5ujPog4uix30PgWn2bdXItQnxI7PNBASSUIRXd5AeYFAUsO++nIq7WVhHEQp7B+qpC
	 SLKGd3wiuJWz7S3+uz/QDyPc/bpzBRotrnXhC+OgT1jYLYr3uC6qxZIGpXM/UTrI+8wco
	 pnEHtOkziv1bcpI0EgAmMae8OA8tEimIKYKO9xsW03RYASP4D+yLDaOtC1vVpLtrlo15X
	 +vKis6xNzWJDE11SUrK0GNFKhHJkKXBSR5Qd/4wXcIxHg6qW/NaF+xt7LMl9exmqe7ucO
	 XkxuHZwzikq6UP0TcDWc7KMiLfXTiQs1wmUSxCEkpnRMVyeiNLZ8TTTHvrzNX7s4cFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhnW9STm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922A606A31A
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HhnW9STm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E41881F000C1;
	Fri, 30 Oct 2026 13:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793367648;
	bh=F4jA2sGet+wo1wAPwIFRYYY6CIoJUevKac623tueKBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HhnW9STml8l/aei694UThwnVwzp8pKed0Hac2K1bP16HMljKpJ00Q31Y+dLH9erNP
	 KUSrUH35tv/tlXiQze6uG+8NZVSl+TeQwBmPZ6V939ZKZ0ISb9/1Hh3Eh67Ve3WKVv
	 gpjQZmTq+BrlYHTwQPvNwW7nTfSCyNavj5o7KcAZYvwmKKq464TekaCKfdScAgvX5j
	 lvRN2pi55ZUDAOQzjom0e7iZ3g3kOfPCAcI/5gkXtxi6H+AyBRtM0Bt0rC3tDKuLOL
	 tciXeEnkdFLOwKPqRupU6EkWUdSW5vtIbYeRZIWswmuIwu/7e1yKAUrXwwcYE2d82h
	 KUqWyXeK0FeyQ==
Message-ID: <sashiko-outbox-191077@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] rpmb: stop the routing after unregister
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haruka Kuze" <harukak@zohomail.eu>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030133000.24147-2-harukak@zohomail.eu>
References: <20261030133000.24147-1-harukak@zohomail.eu>
 <20261030133000.24147-2-harukak@zohomail.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 13:40:47 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Haruka Kuze <harukak@zohomail.eu>
>=20
> OP-TEE has a reference of RPMB device it used. So, it can route
> frames through the device after rpmb_dev_unregister() is called.
> Therefore, the parent device passed to route_frames() can be
> already freed, for example, mmc_blk_remove_rpmb_part() drops the
> last reference after rpmb unregister.
>=20
> This patch clears the route_frames when the device is going to
> be removed by getting new rwsem and makes rpmb_route_frames()
> return -ENODEV if the device is gone.
>=20
> Fixes: 1e9046e3a154 ("rpmb: add Replay Protected Memory Block (RPMB) subs=
ystem")
> Assisted-by: LLM
> Signed-off-by: Haruka Kuze <harukak@zohomail.eu>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030133000.2414=
7-1-harukak@zohomail.eu?part=3D1

