Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987319;
	b=mqXbStESwRdzGkrd64qTOxg4RqSpPsFd/pgMqprbRNp9mUjD+TeGQ+hm0qjwOLvWwt44
	 OLgbNBqjvO4HCnYBJgTBLmGreLyyFTp3J9C91EnIG5x4d5GLxzwANh1QJ+9C+2U1F/FRv
	 7JVb76naTJYO4a4A6VvH/Ftdkehv3JBjTlRaIcllefLHecoleUDz5dHlS8GMIKVYJdjx5
	 cXim1zkH0fSBjmx2ROvI+096Hyolja4SgCJsEs6D7/Wwe/11b4U3dLxtPJbFmfPB1ViuJ
	 1uJXSjggTkDUQcAyr9BA5NaPIgRrrXGXspbeoreiCukgkwOrNOh6VZM990t+7A8GcCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987319;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bkvBCHPUHJiBQlG9kzI63biNVbS3bfGQy4YQfeBAC9M=;
	b=1Yh1BEyTUEg3CiIy6KPZVO76RGVVCOP+YKX8g4HRBEoTBKxm4g4nftcFAv2XjrmTwGgJ
	 LpJQeIldSNpbsNjweT4F7Jh4kGub7M800ofP7tlKAFMCyn2TImyT9BoD/BdOeX4kF3KWR
	 rAamhGGu3i1Sb4qM02zLCgfs+9JFaTF6RID6yeHX9rcwkxGxUYrkyW5Ypo8/hR2gNk1gU
	 JUFff+xlXrejuJ6TyIUAm1htKgSyodRBBlo7h+X0JWiZfLDrYPZdzPGMYz4NSozhBLvxC
	 XyLiSq4gwU8P+SKqwCz6U/Mhzu/Q5brV8q7clXRTHH8BXHFAf22J0sgSZxNaIpv/F7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QAiCPVa+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491CE606A326;
	Fri,  6 Nov 2026 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QAiCPVa+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61DC1F008A3;
	Fri,  6 Nov 2026 17:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793987318;
	bh=bkvBCHPUHJiBQlG9kzI63biNVbS3bfGQy4YQfeBAC9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QAiCPVa+xwdMgwLoV/pgKl0qCH+d6M2qDdvV9WEWoX9Uuwl+q4VpqcvrErc/TpxV3
	 hTELoj71jnCZ65gBPN2EeQl318sg1dR9Xmxw814zRqxLfenZUy90GbpLC0mYS50l14
	 tzDjt2uhZCspr/a/znJmfyqzLJtAYPZxhmt1dP4Q5adPGmVF1m1T07CJ4I4KXMuflH
	 6aFgcddr9ZVR3eydD4t48Z6XT96QdtGNZ+YhMiGmAiCMy+RV0ap+svckFdz2DUsUhQ
	 /vgittKEEnizdmkymSuwk11/ousMzn0o+LU7ZLeTbTSlh5qkzRUYDe+73L9WGcLGTg
	 uTlVXeYvMYXXw==
Message-ID: <sashiko-outbox-201969@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 06/12] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106161838.94308-7-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
 <20261106161838.94308-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:48:37 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] ALSA: virtio: misplaced prose and inaccurate event_msgs claim in
  commit log
--

commit 32df18a5fa7d41786115812b07c44152d5805142
Author: Joonho Lee <mynameisjune111@gmail.com>

ALSA: virtio: Retain queued messages through device reset

This commit keeps control and PCM virtqueue buffers alive until after
device reset and synchronizes event virtqueue callbacks during teardown
and restore.

> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
>=20
> Track virtqueue initialization across partial restore so rollback deletes=
 only queues created by the current attempt. Clear freed event-message owne=
rship before a later remove can reclaim it.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

[Severity: Low]
This paragraph is placed inside the trailer block after the Fixes: tag
instead of in the commit message body, and its second sentence does not
match the diff.  The patch does not change snd->event_msgs handling in
virtsnd_freeze() or virtsnd_remove().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106161838.9430=
8-1-mynameisjune111@gmail.com?part=3D6
