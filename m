Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156834;
	b=DO9NeLBLKLeKb8GOZMZov1bNpizpN/F/3YO4hUVLGioYtfk2EEUmtyqursFmnBM5Sy0k
	 OGL6C03czvHq4cMob9LqDvsrD2kvJgq6ehfVFUoZXvjZGe8H9ytg0pIrTHbG8GoWISKPF
	 J9Yj37E36sOyGleuCMDSUs2b0hQnkYMxYhDPP8xS4fuScIIVhI2MRHmNGmzzOdXnZ28LP
	 pYeuLXuKZk1Euo9Yt7GkkGt3IRAqO/borsHGcd1EY1u2sI2CCFSOgGEzf8RoWHHKFK13g
	 PxineNu3ZpgchroxhobHhFiVit8LJkPOMbBbMkjNsuvnYQEGwE1bEXIZDAwKbn3SG6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156834;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8Of8rEJMJYsSHlFr3P0/49GZ/vqz0SsZ6jHYkqOvlWM=;
	b=euXPpKydFfhflF4jbRkTAKG6cPdnmSMDWFoqW9+B5AanNLnZSxXWE4Stf9/Puxe1h3PW
	 K+JKjMhznniDpgik+8GvzyE7iu2+YFgIp8/Jt3YD3VxnuqwoKGVLOW/iMaD3tWSfezae2
	 Fec/rJxTebErZWNtJQDXiAqO6N/5jD68TaDOjPVPB9LDDPzmxV3+ZxmnyWRxig7Q1rUzt
	 a/ay3uEM0op6gvyu/x9QZy2mjYMs+0Ner0GFb0QBXUzF/iSGKXoMQlx7tRkTyUHjJ04Oq
	 RJMFjor7u1yYdip9xnW4WyHRA7l2VUZd/Do/rfyxTvqStCjohFoMgaf2orbA5T9+BEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SrsKPMYr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7B3606A31D
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 03:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SrsKPMYr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DDD1F031E3;
	Wed, 28 Oct 2026 03:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793156833;
	bh=8Of8rEJMJYsSHlFr3P0/49GZ/vqz0SsZ6jHYkqOvlWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SrsKPMYrDN2748G39/GTpgqZbdp4VRWH2jK/QbBUL2e2ZP0BSdemfsuXs3WuICbW0
	 SpNCPAEH8WQ4H+P8I4grxiFhAV9gowYyJdO4hJBMXkKiHT2f5tBagpcekOjcJllFan
	 PV0HEQ5C++iNf5OQyVzpMERjSJziphxfl+wLa0F3YxOaJ3Cm5gr0dqUSTcG+XEDTIX
	 BKVEkeEgkpVAYfl7Z3Ll42kLeuhBSlxThq5sV4mkgepBBdmcDjNYEdDuqEpeQhVDLn
	 6J5UPzc6o0FIF1RZibNfRtDxcdH4AQ44V71yX6FFC+4PF2X/N9DH1JiUfDUUrjACcF
	 kiXiRMplmV/jQ==
Message-ID: <sashiko-outbox-187382@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 05/14] ALSA: virtio: Keep control payloads alive
 through DMA completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028025317.92450-6-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
 <20261028025317.92450-6-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:07:13 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Control requests can expose caller-owned payloads to the device after a
> synchronous send times out. Keep request and response headers and payloads
> in the reference-counted message so caller cleanup cannot invalidate DMA.
>=20
> Keep the queue reference until device completion or post-reset cleanup,
> even when the caller times out or is interrupted. Consume the caller's
> reference on every send path, and let response readers retain an extra
> reference through copyout. Check payload sizes and allocation arithmetic
> before building the scatterlists.
>=20
> A control value payload is also read by the CPU as a typed structure. DMA
> cacheline alignment alone does not guarantee the structure's CPU alignmen=
t.
> Align regions to the greater of the DMA cacheline and control-value type
> alignment, and reserve prefix slack from the buffer base so typed accesses
> remain aligned while scatterlist regions stay on cacheline boundaries.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028025317.9245=
0-1-mynameisjune111@gmail.com?part=3D5

