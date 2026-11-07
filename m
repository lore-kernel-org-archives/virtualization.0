Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063183;
	b=lqUQS7nmezxPpLtSetTRfMQOlnlKdYEjb65NxPy1QTX94mTJfIaYfwyZCnxHq7QJxDX1
	 1dshqU/JvMKv8pki2OtRggLN6qNDkOJPps1NfJSVHbXwViKD8CaLsC8qFECRIHDA1/YKM
	 lsD+rNnqK0GB4vq1wsSnkkruGEbwQIKzPDSB+sNpmA4Ryxfdi7nwpCGthtDfNBtRhLAQs
	 T517//EW3BCqyELx5eUSTKyyzoH/Jb80RK98KaEEzCbmfnwT9ASHpRNFly8TzvhkBkX02
	 2Kl6dU8mxShjFsJm+VFp5AVVWRIOMq4nWLDZSSy+B7HXhOCQy5ik9CtIUgnAyxTMP0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063183;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1NySNWZ+aAfQDW3VzeGTSg8yEzgaBstTNVbsnqEUqXQ=;
	b=sRRpRRpW3YZExhEX8KqMf6tFhEqV98CPGtDbKCtPV1YrgFmoQkSGhzko3MmfpHzjTyn9
	 nXdWrTr8MfF8MoccxqRdJ5kspVk0hzOvW8l7b1MgnRFjwugE45IIqpAAGU6tK7hLvp7kz
	 x0MTWT80FHwqOajG1Sag1rOGV+bcpQBA1EIHd1sVgj2JfmUEw2VeTJ5ZZRZsEkOxL15Tm
	 qU0Np/UL8wnnFKH9bRlJVHjZcKqVUBLuk8pRhwPNp29icBLfYfRxNnUPmBq96rM2dFD7Q
	 8depsjCemuAmHRUKWzeFYwMxIIet3sit5UZlKT/dt/hBYxXJbKX+EI9dOy4vsfxT5Jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5HocOXb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1707B606A330
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5HocOXb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08F21F008A1;
	Sat,  7 Nov 2026 14:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794063182;
	bh=1NySNWZ+aAfQDW3VzeGTSg8yEzgaBstTNVbsnqEUqXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I5HocOXbMy87o9ij+2U9cu2TDTTRRHqCrt3PoXa2514BzmtTYyvyzbNhnJY++m8bg
	 9poRHAdiDP8F/D+SP8MDweZY7n4bSd/LP0yQVNzB1GucWaqViMQE7kx+qyWkrnIroK
	 XiwnFsVGknWOEF2m/dnJSE0ZMsIy5znM8XTCbhHnj+2RuYr7Iawk4RWyPMpMjYAVDl
	 Jj8nVerJs/WbNyNezV2qjAe0k7OXB36SIWGag22RuDMPHDZFnRN4ZyvPWrTRm43GeS
	 qIo8pOlDZ0kwYW2oAIEiBzgKMDsx6xhX8g2g7wFVD16QBAaExTIa+I/mReKYocA69K
	 LP8YTwY2sJqxA==
Message-ID: <sashiko-outbox-202971@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 11/12] ALSA: virtio: prioritize staged capture
 period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261107143422.29319-12-mynameisjune111@gmail.com>
References: <20261107143422.29319-1-mynameisjune111@gmail.com>
 <20261107143422.29319-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 14:53:02 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Queue staged capture period notifications on system_highpri_wq through
> the common scheduling helper. This allows capture notifications to make
> progress when ordinary workqueue workers are delayed by CPU contention.
> Playback and ordinary capture keep schedule_work().
>=20
> This preserves the existing priority proposal without mixing RESET or
> lifecycle changes into it. It provides no hard real-time deadline and
> cannot prevent a userspace reader from overrunning its buffer.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107143422.2931=
9-1-mynameisjune111@gmail.com?part=3D11

