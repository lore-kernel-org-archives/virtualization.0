Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879362;
	b=J2f1YjsfT+T+e9dVVudOCg5TllyKIIDkSjd4yX5i+Z9FxnDxjSXbgQKwlIlB3GEyzgmR
	 0xxB/MqLv7w44eQe6CZr3EYvv4ZTJ1HeQNhL9Wy7cree1+uI81bgfR4x2mpA2Ycy6qCr6
	 SZz1zImvST+geKUX2z99Ip+dOXKwg797ErxWEpET1P4AKx+kabMebtGQEeAcjspzopLvP
	 22HijsITCHS+VSSn+J3n+khm6K5bIDBR0Rvh86hYJiBqq+MwJxH+M0rzC23mrYsnO0TLh
	 fflYZGup/popTk7+Jg6Ii5jutsO4r7p2J1J/W2XBlcNcFp6/cRlc4U4qJAyUKJ53rkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879362;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5P9QqSL0sBMHpU5UnpArvmhKg15kVHNcfUou4tlvWbA=;
	b=onEnsdfAAajndi6hGqXFmS2G24KcFtMGdw3y/XGrj0TBeqFspiV76dnR4sL0cTaXbpS5
	 MVtXNPOjUsAqWu8X15OSY95FMU7QAnDdNX+EyeGpBQ+kpZPojb5ynF9Ocx2Q9XnCh6bUw
	 GNQHuRlgVi7W3shTvZz7MZVxJtMOiLsEinnONtCQxEjAMQfpzXRLHmi6Xql1On3ki9ydo
	 s+J9HRgu3wiIyUhJcJmWghSHJdE6xzqxKYoBm9XxUwITyE+6VIRGmHcyu4kE4Zcm2kTxG
	 SeaEk22kZkTQg0PmQw3NeyKb23P8k1sHLwan8FTvcP9PDDDiQgViiLie+/vaZqsGBTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UvwkIT4L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23282606A338;
	Thu,  5 Nov 2026 11:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UvwkIT4L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E70C1F00919;
	Thu,  5 Nov 2026 11:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879361;
	bh=5P9QqSL0sBMHpU5UnpArvmhKg15kVHNcfUou4tlvWbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UvwkIT4LA1+DuQgCF97YFeeyYCeG1YP9uDgM/SW3X0JsKEUJi13jGniw4wZ5pY2VZ
	 VIlqzdIYELn/0T38Qgs0Dbl4mKKoyRAGyGpq95Z59M/Ft2wcWzTwK6RCgK9nXIHIXg
	 /Rfq2XYp14w5GzdCXweaLioWjUDzqx4RPegeI3XgTd1zcNRwj/EQoqAB17cQTZ86B/
	 Sm0Vnl8deLqzjdESoJngpYOWMuZhytEUpXddOW/Ne3dwo5LD7aNkESaXLy7sXMWI5D
	 zhhxHB4E8l2ARyHAa+8Tyb82jvUUTUVz7seFcqyhxBCmahNqBRM/Nm/ttbk+oKd4vM
	 bxH4Ble6bW6YA==
Message-ID: <sashiko-outbox-198973@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] dma-buf: Port users of dma_fence_init64()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Philipp Stanner" <phasta@kernel.org>
Cc: virtualization@lists.linux.dev, linux-usb@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261105113529.1989375-4-phasta@kernel.org>
References: <20261105113529.1989375-2-phasta@kernel.org>
 <20261105113529.1989375-4-phasta@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:49:20 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> dma_fence_init() now natively allows for selecting 64-bit seqno support.
> Port all users of dma_fence_init64() to this unified method.
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105113529.1989=
375-2-phasta@kernel.org?part=3D2

