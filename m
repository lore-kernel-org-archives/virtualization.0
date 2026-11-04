Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793763798;
	b=VZx84MOnAAI7oGCewfctFzrppbOvyYkk1ZugbwvJZQNrIkPH3sDTwi1ZK0kOnejPk6hn
	 I51eJ5sXNgkk+iVV22vvcwR4vI8l3bI04ouLtXVKhNcCnwg2Sdo/WSKKq9uhcihPT5Ndk
	 68Bp9oBcHuFkCrCAGvmiHJNtpF0bZArifDUD2C1tz1BzPxMgdwbuVydKzWqf7XZLNLbBR
	 ZpHFGlmqFElB01WnMpDg95Th045a11BnJOD3tH5fCSBHMMuxhG4zsqYTo9U7Dm9CuU1Mx
	 0jzI1W2xkqyi3Xp8JW4jxmD+v8UJwa040eAfloknmYzAK2D7EzitAtnFRJ5bDYrz/QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793763798;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DwAzPn59wnEzoOKzrvhq9Vm1AruLEDIEMHaLLimt544=;
	b=M06WuSZPN5p2puS0v1tjwUXt5rnokGo0Kf4yrqxDfJj/YgkIhfzg3ze8eEzlOvJLM/on
	 qp3R2ZBnxXtXvjPd2XfGY6ZC1oC+nu09fL+yaqNgGHwF3SQQ9agJQD1EeuW3T0u6pQ9WD
	 TTRXbz48PgPFSbylwQrTkfu1QdgUY9YICLw7By27hX3fwVt0RrvFcDr8bECHIdtKuWH9W
	 QXLO34Ph8aJzO0dg+b9ZyUyGzJPRG39lC/aGwSwtWHUlVvOoihUGhNc2h50qvPAZXZSXN
	 8eMuOhRS7Qh4AWh9URWJF5j+g5yrXuAJsLwRVicaAmROVnERw81vH0+aq+w7NdtxWlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbnbhZg4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF59606A326
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 03:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dbnbhZg4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00921F000C1;
	Wed,  4 Nov 2026 03:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793763798;
	bh=DwAzPn59wnEzoOKzrvhq9Vm1AruLEDIEMHaLLimt544=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dbnbhZg4G2Cu74Hz2W77itUY+uXqcSZXzkfqEkU3lu5JxW7tDRrliX6n11U/ivLPE
	 FGfGbL5NP6oUI1JTQDuWr0x1K0mM9EFPQNeAje1daSnj+tZcQ50+PSaBQJekriHndR
	 8GvvM9UdpzhIJYs/JcR+enx/ky83jjTVhwBxsUqF7fh6ipIMUnRtQ5mChapKQwKlN0
	 JKJszQ3DkreJGgiiRyTVNQ6MKid4Kad6twQKjwsJenLaixrkokVOPPftE49GAIWmg7
	 RVDcDU2rS1wNLnSKGC6h/wijxl7x8Q4gdVM250Ktxvzd6cIOHHLeXNcSgNXoJMSUOp
	 l/TMZ2ZE/diEQ==
Message-ID: <sashiko-outbox-196623@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 11/12] ALSA: virtio: prioritize staged capture
 period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261104021745.57733-12-mynameisjune111@gmail.com>
References: <20261104021745.57733-1-mynameisjune111@gmail.com>
 <20261104021745.57733-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:43:17 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104021745.5773=
3-1-mynameisjune111@gmail.com?part=3D11

