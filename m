Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262008;
	b=3FvY3EzTC0Ffpzji6yJI8xDaiQjUuZuGgN7HLF63SMVVpTwYsRb3EohbDKYcyiaKbo5j
	 dzuPe2hZYbb9T7Sh1ENb7FGrgNShr2AdjLz5UQA+FtFvknCVMu/cWjjAcu6gA6ikayGq3
	 areHNLOoojvxglQeWB9lLRY5tyCQp4Ftbici/doFuhTskA9hGifZO+2fvpnLMk7Nt+QH3
	 wfrseZPRguK1d1viiuQZIlXXlTpXhU/z3zmieQL5aWGh51OdsxcnHpS4RWKd6FvzHzYak
	 QvUzEV8HtAwrUFBwSIpe6QaIgGk0pTobDH8zM3SOiY/4x/MSKsYhLsaHrKo7nYzgT0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262008;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=F+LwRjK+p20GEld14uV3MKCgBzgkDmaf9BFeptI9gm0=;
	b=b1T/ssZuRe4ZeD4FXRcAvu4adRaXlPftXCvYSOfnRUxG6HBLjuZ8l1jG1/wWEdxhgOy0
	 59QjyuZ2EZWjaQRXZJgl9eKtSSWr7H5AZObyLWnlJ8CUtX8OuQuZpLYd994tXml5WpbJV
	 z+ZwNiP7xImXDa4edruzbExuqreSXNrfxZc3no+wx0YflAbqlJjKFzRF2YtV1WoR0N6Td
	 ZGy+hlpflfjf5DWyGrCQaCZYLGI74ZmgqpTZS4AD7j5GJviEj6wZzu4G1oQ4n52DtSPGr
	 5hhVp/ZYD43RnvYxGvu4m6zlgDau6LxXhLA7bxlKgXdqPobO1JKAeIn6Wx6HjZ3Pdsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THNWY7dB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F23606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THNWY7dB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E855C1F01828;
	Thu, 29 Oct 2026 08:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793262008;
	bh=F+LwRjK+p20GEld14uV3MKCgBzgkDmaf9BFeptI9gm0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=THNWY7dBdHELB5OyUI+FdQ25NtY8mknQ0sjC8oYvKFjQ/gw6FEKgAU4vheY2I6sFt
	 qL6wHBJniAL2y+6+zRpUPM3JLpELhQfR+g+I6lv+rV7i1sH/q2bCwlsQjCVtultuKa
	 CRUAEwmmkDiJnpHS5wbaMz4DrE6o9eUPlZ9InR8fgXsDkXyezz3kBLc7Z5fWk/ruxj
	 rJnnx0Tcx/DPR8sjq9nhNbtYRJFRlbNhLbL0EOK5lpQ8ocLv04WUqrzJwAYZnaJYtP
	 SsVgIQG3INVUW4WjFeoQ5+EYm6P8s7NJZGLnfy10plzvohjN1Ljuy2PzRbhs2mI3ZL
	 952wvziHf1G7w==
Message-ID: <sashiko-outbox-188954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] rpmb: stop the routing after unregister
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haruka Kuze" <harukak@zohomail.eu>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029081317.2264887-2-harukak@zohomail.eu>
References: <20261029081317.2264887-1-harukak@zohomail.eu>
 <20261029081317.2264887-2-harukak@zohomail.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 08:20:07 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029081317.2264=
887-1-harukak@zohomail.eu?part=3D1

