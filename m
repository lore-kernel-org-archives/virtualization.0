Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792912967;
	b=bfKyfXfnmJSeEmqt5Q1FMUlB908oClIrF9BxXQhYLp3IjEVWAxJHRCxwwLLv1PD3i2tV
	 Lcp4/BXx3ZF+L2sRr2JHFyKyo0JXV0lbMWgep4KWGp7+y/v7FuFqG6rhD/UKPEKDwktFr
	 qWHxFYGuZMua8jcLqpEQzrXM3L5nSjc4gPAfsKbXE4P4a6d+0omBUMfKin5RaB3JL/HKb
	 ZhYbQtiOIuTdIJU9aJ+6ZOrPRQbYfpbAjPKYc0V169woA+WnyumUA9t8G4MOGa32N+Kic
	 CcUVFZ6HsJdDX9zQDzWpu1MfykxXOA2WJyjN6A+Vf8PMDqEeyWUGj72GUUby/wl5hJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792912967;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=K/0flknEeRGwKASd/Z52+OT8ZwAgmoLsfNgcm+js0hs=;
	b=ognGMcq0fcQs8K0zonrgUdtYqMfcC6Pmedx9kyLIH6g0NjxplPWec0lawHuUBCPvYFCA
	 Rtn/IbmfCpLtQSAL8PQBSFgkaKIxxYAEL7yBxbEWaZMGkYm6KsxAU5IStih+nn0ijwPlJ
	 ir+gvz+gPv5odH8oOVvYCN8vfGcM2Pv0+QzNBwBuMlZ0Bl7Aq8PhTozdA5CFn6ULd1O50
	 O8irG8sQTX6evkKFirERcSqHoqtnAyZ/bGBQ3zT6xkzfxHDNyTVyu+Ijhc+b+UMToGfjX
	 8/i0kq3Yaao+zI7tzdgxrEdKXQ/GCBxdbkuG7+ibBYLowOh+pfUejIb8wcajig7IXfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="loe/+2dz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FBA606A31A
	for <virtualization@lists.linux.dev>; Sun, 25 Oct 2026 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=loe/+2dz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93E61F01825;
	Sun, 25 Oct 2026 07:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792912967;
	bh=K/0flknEeRGwKASd/Z52+OT8ZwAgmoLsfNgcm+js0hs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=loe/+2dzpUE3C1MZpyqNMG2UkOottdG1wF671IpBIPzxytuHhOPqJLFALmrHb1tcs
	 7GBth3uv9udw3yhdvqYJ183PT3oAtpEgqigR3SOFf8rl6twITf2fyqhWjM1GWtJm77
	 jquZeKQTj9B6YieNxS1m5YTDaAeKx1Lf0Q3vf6AdJvcOPMRrsJt9BkyKpOa6TtWpfl
	 BxApCr9DisKeqZs6TUzfJhYHELPT4MRsxItJWt31HBxkiKBbZ2hRlt9ZC8gBdOXSF5
	 HLvG54Ian5fXXHzff9ay5bgIY3cbTmR12nWm4yLHgQisNW7QMg7o623fddUjOse6ON
	 NA8P5ru3xSh+g==
Message-ID: <sashiko-outbox-184111@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] ALSA: virtio-snd: fix dsnoop capture with staged
 buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261025064038.81674-3-mynameisjune111@gmail.com>
References: <20261025064038.81674-1-mynameisjune111@gmail.com>
 <20261025064038.81674-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 07:22:46 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> dsnoop runs its hardware slave with stop_threshold =3D=3D boundary and can
> consume the mmap capture ring without advancing the hardware application
> pointer. Staged capture currently treats every stream as a bounded
> consumer: capture_ready grows until the completion capacity check fails.
>=20
> With a 48 kHz mono slave, 960-frame periods and a 7680-frame buffer, the
> baseline dsnoop reproduction stops after 6720 frames with -EPIPE and a
> ring_capacity rejection. Direct capture continues to work.
>=20
> Cache the prepared boundary and recognize the free-running policy under
> the substream lock. Keep RX requests supplied in that mode, while retaini=
ng
> payload, frame alignment, counter and pointer-window checks. Sample the
> policy once per completion so validation, copying and refill agree.
> Refresh it separately in the ACK accounting and refill critical sections.
>=20
> [ ... ]
> regression also pass with KASAN and lockdep. No new physical-device or
> KCSAN results are claimed for this revision.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025064038.8167=
4-1-mynameisjune111@gmail.com?part=3D2

