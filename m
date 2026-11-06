Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793924435;
	b=bwi3pKkTFsqbrmNOMtPcSlqiFtMB6b/xqsZ/dN7k92yAOOcDDzQresYmRrUIr5MIsgKe
	 mcY6f1l+7cxwMUQPMmezMdRulZxyjGTit+ibKRcMj2wJN7PC9r6kchwgSYCMCRhoK2GrV
	 krBnqLSOtVNGzJo5HWdS101xLjw9EsryvemdenMt3uLqOneuzg/RpYZqYxEcjKI0dVTAB
	 RZaKmDvMcKCKY6GFm9mCoYRDf2Y33nXXzi2rRONeCqjz0v20/l3+S0nThJwoJcSlz3fjW
	 Sf8JN2JwPlNEJTVxf0SKK6knnTvd9xV2qDYgB4dDFzqUiOLF9t27rRE1aXm8I7q3a2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924435;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lNaBs6RqZEaDxAZkQEod4InCRGY+yDftMepoH6iNeZw=;
	b=H+BWK3n+KW11NNuArgm8BPspUJ7Q1tM2gO9C2+93ujIn/Y/djqXhGlfeX7G41RQ7ITfw
	 u8kmIZEhOv4KfxR7ZSN2iW+U3j8GNKSPDha0h+JkKfLN9e0su09Lu9bm7iFq6Yx7wM5R6
	 3AHv7UTyVeHCuXLfPC6k4x9O/XhOyWtO6/8YhrtYyIAEixu4KuUoBlOczj5DiM6vwIoK+
	 gKZcw3h97hlDvO9c3z5dv4MJBYRSsYHj/RwkkC8wSriTatFID9g/PRCknX6Sxs9B+ypc7
	 hOv5rRy+AEk4YMSqa8s5CFCh9qR4DFhHKbv6bAxCu62xsvqWhuwYzfh85Z9KHazCRLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RWVKPPev;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F275F606A326
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RWVKPPev
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978331F0089F;
	Fri,  6 Nov 2026 00:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793924434;
	bh=lNaBs6RqZEaDxAZkQEod4InCRGY+yDftMepoH6iNeZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RWVKPPevLh5i5hYmERFQ15r63j5gvsFmpVF344ErfOgexdyNT2CtqeN2FBrHwrV+J
	 EQ+jHGeOdjolxIMk7zVFMRKe+bg3oR9S6fLhdSoGF9UlvA3MsquGXVW56Qd5/1aufe
	 NScoGU8i30hFIiqqLj3FtikrM89zdVlLgg3bzSk57dwDqw3ar7k7UEt6Iloqgsloe3
	 gGkGPppVebJHMjTkulxhMoDK9p622wDfu/Z4SwM5lq5Ok35g9koiwiBriMlxz8HNJ1
	 V2vt6peyRn1tFZA/+GqyMIZ0pDzFvP20HaLi9X2iJdSf+adMWgmzVYzqrK67DIKM23
	 bPXD++vd1HJ3Q==
Message-ID: <sashiko-outbox-200434@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 11/12] ALSA: virtio: prioritize staged capture
 period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106000644.20460-12-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
 <20261106000644.20460-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:20:34 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106000644.2046=
0-1-mynameisjune111@gmail.com?part=3D11

