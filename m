Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664953;
	b=ximX5zqqVJTNiIEPh3caOvlZSlrWLKwR4Fq77MoyoQMzAsgg1QBwRiqwIWGw8yJUO+YN
	 cktZNOOaBQ/UVf0aDr67BYfvQEQ+yPqXKU1Xgbph+OTLpHMBznaXbBjytcSaqiqFYv7o7
	 +5sA/s2pyit7NmxAHjEYF8eiFNOQI9aqi9sk0P+hcr4rK1/d5478eQfwKOw7Ho74MYrMO
	 3jKFh797qBae7/3qJumSL+oIsp5xWZ9jGsrU+5/IqJzAqhRX0QPlnBbkw00LMT84gVg7G
	 GL3AzXasENlqK7OcEVg0WMMfxvNXNzGJNkwfjiF7EB/+e5MUDF7YojfYxP7KeL6ROIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664953;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=L2V0MJQ7TBJpW/LwS6/4gNmrCji+86F/IAy0UsQ4kBQ=;
	b=SohW82FYIsgwfTJ+5pGg/B1kZXDEA1+HiGirTHeqW2r8sCkimkiaiafxE6CULd6qzvP5
	 gPZebDU1448YZ48KC4svHIGYGYHwizqtkG5bsnqxDkvNiTXU0UangsYnCzHuBVLxEIpGV
	 oSlf6dpz5EqqBETKuwgoJ1hHrQk9ZU8rZ9M+nsBwurmauYi1+FgQu5dVraDdVB88Cod3O
	 9OlhX/8aW1Uy4MG1MRmWR0XDcvDKjlz71oG8JDMBFPTamCeIGw0Jp+8h4KCGB/2xtxdcT
	 lWymf1/29j7t8KPrCaH7oeB034AqLLGF2qsFVxcTcpDZIsI7FSKWv/NgDoFpB4jTaYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cGyVny5/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8CC606A324
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cGyVny5/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67381F000C1;
	Tue,  3 Nov 2026 00:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793664953;
	bh=L2V0MJQ7TBJpW/LwS6/4gNmrCji+86F/IAy0UsQ4kBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cGyVny5/Nu8R4R96LKV6Ci9wfzf9Lci9wZDwuPcyT0GRTkVgD9SUkvNlmQJVDVQ4r
	 udFkKkdHAUB/Yn1/onl8izpxa3sZmzEeQN4le4bMPQofGKzLjrG83uLQvtgp92BxSM
	 Tw7aeJRYQxpodLaffIas5BT6cMbQeKz4BhRloqTvGZG0W+q8KVr4GVuYZa7ZHk/IVH
	 mU8Y6XW6Ivfl/jwEbbZp2o1n/JMdvCOTNdIc+pGnuM2nws8hwkCqUw7qNKzBlsS2Dn
	 Rhgpo21rTsfm3Ztr9n349E4tybDQ6RYLl0RKqC4phv614ocrl5ztP+xfZKKJiDARli
	 aD7w6UzauqW0w==
Message-ID: <sashiko-outbox-194367@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 11/12] ALSA: virtio: prioritize staged capture
 period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103000403.67106-12-mynameisjune111@gmail.com>
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
 <20261103000403.67106-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 00:15:52 +0000
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
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103000403.6710=
6-1-mynameisjune111@gmail.com?part=3D11

