Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923876;
	b=KCj8ZsGmc452FpSJm0np5YrtGFZVVP37s6jdlzPk9I29GUeRZ4ua9Q2czPjnXsGZjxaT
	 D9V9ZByWatUj3ekyWW07hlbhPJAIoe7teX49WVJKxWXG+lxKjPAy/tQp8EN0JbDTcW5gr
	 rOEAG/H5/QDXEJWBTEzdy19iZBW7/riLd0IKr/LCx7X/vpQQqw4dI6K2Tf+tpfRqm7WL/
	 KXA4GgCQZvBlLLLJFrjEMdl30BjtmF/GD7eAJBD7KPYnsNsAmJDpGDaL75MCi9xbUol0y
	 LY1j+FZ3kZ8PKGfnhCw2Kc/YvCr4wHoLR1oixKXXZZT4s/3ym8+2fgapfdotkg04Z9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923876;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iGZN8Cv6jUpZLrZFjqXKcTdshNmbk7mR7malSXUjQ20=;
	b=emV2KnhGahBvDFwOGN0o2QarA1sK5H9GiUDHDWwQ5TfK40ralY02LD6yxAPYxjgQq/eG
	 LYsxDTJzVyxYG/86wkGZrIgrhajpJpDhZonmqN0u1HANuhwE5eTkxV3qgPTpzm9roPFhL
	 V9Lq2XLmSXw+g2vDiDX3zlr1IOi/4BIL3qZxHOgNLI4uXDnAJclqN0VrgYOa6O6B/gWXU
	 JPPQbYEeT+QAvWWaNMLv2apkvL1vb1vZP2GKWg8NpVpaITfKW9E66hZiE9OLx2sLYB8IN
	 iMWRXtkKBH//+YZVmA2o9sMawUvO9m0CUbmh+zDCIqrpSayn+NBroAt3gx4VfslcFrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmQkjpVM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C128606A31B
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmQkjpVM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B5D1F0089F;
	Fri,  6 Nov 2026 00:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793923876;
	bh=iGZN8Cv6jUpZLrZFjqXKcTdshNmbk7mR7malSXUjQ20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VmQkjpVMQD1Ev9cO2QnCeQ3FvVr8xc7ydZpCdcT+5udbmXGhQ+889Kj91IlVld7bS
	 98wOOFkaDSciGkSXD/brPjs0yAwku99HMOZGSaCQi8Ml2GygUdg1cg15wsa5ev/aNU
	 80MckuZ2saIbVzXfwT99T43+/mVFF7uGz0BFC09TkwH8/xVPtF2/cJ1cPOO68nZSRT
	 G8L4DLlndI+697116TSj8HuwR5dvUYYyQBDwjV/yLxRymgAEDrqwZYWZoqSyhTHz9g
	 MG4SIYNeQS7spRciYwySCQ24Yj9MftQmyTpRDo17buxiVbhldkENPEGEgmYa4lGobj
	 xH9IJGFDr9yng==
Message-ID: <sashiko-outbox-200427@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 02/12] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106000644.20460-3-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
 <20261106000644.20460-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:11:15 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Staged capture can make readable data available before a complete period
> has elapsed. Skipping notification leaves a blocked reader asleep, while
> using the period-interrupt path for this event can infer a false ring
> wrap when the notification is delayed.
>=20
> Add snd_pcm_progress_under_stream_lock() to update the hardware pointer
> through the non-interrupt path and notify readers and fasync listeners.
> It runs under the caller's PCM stream lock and does not tick the PCM
> timer. The driver must release its pointer and trigger locks before
> calling it. Existing period notification callers keep their current
> behavior.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106000644.2046=
0-1-mynameisjune111@gmail.com?part=3D2

