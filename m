Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991861;
	b=cDJ2hM6jGjqqH4nK6cBmNfFlofHJvdAvcCnjZgVMJe8GOxf6rI1XM6SNrTE2hTxXUsww
	 DkjBIRCHE/DCbkKbCMAooUNzM29RBy4ofr4/oiJJLVrJABloiWQSdHhCZZOwhjPzvPcux
	 qb7AlV34cYAGZz+TE48cBUOZ2JxBf3dV1HD87bZ2EEzSCDJpZWn6rEqqc2UEf7s1oj/bu
	 WJACQiO496YtiZbpJ68F4naKfiAoiVe5s1MGVhs9OJwir3MjVy4/2LSRGhRcolqs4+oLL
	 juqLeK+StEukhBZxHy5fZBhsLanNjtP9Tx8vdHkiybH/WC/ciJw4iSWLXYRhQQAPInw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991861;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bsaHJUL98+ooI7KAffhdw0rivdaYQ3nK3wkv6BjZg1k=;
	b=JORNm8yoXtfKBFURxyHujqt3QdwooGlsz2IA7Yu8biiL678c+cMIKBZL6A4U0ZLvkftq
	 zJyGmn3oYoc7mSIvQQwWtmbO3Z03JxKVUo6NZfEb3j1XK4+YMXzif+cREThQG8i6yNiGI
	 WwJr42pjp3YU+b8WDddCnRBvrdaCUHo73nZl9pmvKXmXXXjjisqxrs95jpsBBb/wuFiJW
	 AXIElBDQSLzlhQ4zjkLGhvDwx3D+kaYI7IOnH17oV1rMol/IMeB7MNaavF6rOKVZkgNL2
	 pmAJbDIEEPMu1MJ4G+/nTbPpqobvAQmRhAQpsrDcwQzVnDyazRZDQdGjBqiYmUQca4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KWQVSgyg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED07606A326
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KWQVSgyg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5821F0089F;
	Fri,  6 Nov 2026 19:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793991861;
	bh=bsaHJUL98+ooI7KAffhdw0rivdaYQ3nK3wkv6BjZg1k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KWQVSgygfxd7GZcFCcDMl5AgzaOUII87cvFF6sy4olrEnTjrOzWNrBiHon+PqfsL2
	 nGvE457tbzavIrpkFYm3/pcKku9NMNB3md4CxBESptdVuKJG0QE3UL1VmZe0oTAIUy
	 2nSdwb+EXziqgJe+Awsxu7ZW5w8Zk/DA/I4MTk3cAmxJwe6f9PK6zGW1xCFQPJZEV8
	 nRezX628MoyCP25vVaiJ8p0ErKwu2GcDwdtjj2OWxcs7/eKsoMFcLv32qfa4fa1KzF
	 JrABBYKCIqVsRUM5QQNpQvKb13Q3lUyeNGPW722aHB8YK+76z5Ke5onrecIYINPqSP
	 Q46SZb3pR90Zg==
Message-ID: <sashiko-outbox-202127@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 11/12] ALSA: virtio: prioritize staged capture
 period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106161838.94308-12-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
 <20261106161838.94308-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 19:04:20 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106161838.9430=
8-1-mynameisjune111@gmail.com?part=3D11

