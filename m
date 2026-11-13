Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562455;
	b=tTin89ZgFrJ4ZKlEKWjPRqWCR2lJzQhhnQxy3g3kpF2grGmQfjr5b+XgSO5rpa1KKv7z
	 j27/I1qh3Fo/XpEjSZpCwoBayAt/0WY46gD6SkZmmzyjpzElYXLu6MGpsh5vM5JdxOjMN
	 bPktUs9MGYesAx0o0lKt07ss85JfcQVAsgjvMuGt4muO1xb4TLPcn4YuTHUT+BkbXAToS
	 Uj4vzlgsK51KW/ca5e4zif6wzV92yKhI+Rgs/4gCT9FpskOwL4JXwtgtC5onInwHjdw5i
	 teUf88GOgzasKfT5A8KWEiW4yzbZCCPdgzzMtsnwQMj1AL+56GJeRKFDXPyvOfNr6AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562455;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ojr4CYkdD1lSNqGGp1I+Sfk8TsWHcldkdnaYMbocfSU=;
	b=tMMnmwualzeH2EkB6VrTaIoBKeyvFtakrEiTGTtJWmrgmODAUjmK5rYyOHJAPEuGlpPk
	 Te0aKaVJZtxRcEh/ptmbEqs9X0xSq1WWgH4We/ac80Hw7sGKXCglUcTLa0KVY4GzY3TnX
	 03wgVjWZQGdoojag9482e68xVJTTq1aVXdS3wRgws5Tt0mmMcZq8UX/b4KwGvOIvx/Uqn
	 dDwsUjR7BIrcK+m2UTZoB8wXknszNfVJ87+/FubueZPic1hmzYmvKaZtLagdkU50mfVHN
	 7XitmfWieD6dZFklCKwiFZpILms3ktxZWXvwRgefAgb6xm0WLWpU1reGTzwQqIx+R2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgXC4Smu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E67606A31C
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgXC4Smu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0064A1F000C4;
	Fri, 13 Nov 2026 09:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794562455;
	bh=Ojr4CYkdD1lSNqGGp1I+Sfk8TsWHcldkdnaYMbocfSU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fgXC4SmuXLtAG0gp2liM7jAVaBb1DzJwjl48KuLTkCdxDEOsAOL/SXYjtOkcFD2HK
	 Dz5HIdrxD/YtT5aPNHaiFzCD7MJ94dOqLFDWg64RfIT9jFuJuvhSsKNTuo5xAnrlBT
	 qaoc2tbUUxx1+otXqxxRh7dY3UcOdi3VhbSG0VFzsEs+aKb8R1EKEBauonKR9kNIrH
	 SVQ4CIjXp+4oLbl9IH+tB42W6MAgoYX2ypz0hL0h6VE4airGK5UeHz93uSLBn67weZ
	 T9bROxabqK3uo6zvFzTA/PUnHuCY8Ym97OEfEYuTW3JxTCY7izKKLQNnvrGKWilwuV
	 SoQqfNqaXPm1w==
Message-ID: <sashiko-outbox-212552@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v33 02/18] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-2-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v33-2-13a934ad5ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:34:14 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Joonho Lee <mynameisjune111@gmail.com>
>=20
> Allow a driver to publish subperiod progress under the PCM stream lock
> without generating a period timer notification. Use the ordinary pointer
> update, XRUN and wakeup path. Capture DRAINING can publish its final
> tail while playback and other inactive states retain their existing
> behavior.
>=20
> Handle capture DRAINING separately in the state update: a full buffer is
> still readable capture data, while progress beyond the buffer capacity
> is an overrun. Playback continues to finish draining when its buffer is
> empty.
>=20
> Refresh capture availability after the unlocked copy and application
> pointer commit while DRAINING. A final tail can arrive during the copy;
> subtracting only the copied frames from the earlier snapshot can
> otherwise finish draining with unread samples left in the ring.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v33-0-13a934ad5ece@gmail.com?part=3D2

