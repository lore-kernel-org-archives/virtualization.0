Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366970;
	b=lusX4EnKacWqmDBm6BKWInfqRmdAIMruUKLIRiUK9r+ReE8G6rZDotVn4ON3OHC/v7N7
	 2jMYY4JFml4eo40WkynAW6KrSMKPxkcz7txWiEl1SSir8eXJ/fiPleMfsUf0FNTXoOxMS
	 V9MBHpY3vLHcOtXIKpEXYRjr+kCZM36z7cuT9T57xM1v0UveZMLoqCl+3tCIXnudgmKli
	 KFLPr1Yce7DM6JGhvcIMz6SHUFHiHB4W2oxNELvrTMIYAA6QfO/ziyzgEYpS8YQ0LDV12
	 cCu+GHMyc5K/fQDpp6QVEzZGI6P8KY6Mf0DFY9Ukw8WZ+/zEy/qEXMRJihsjqWvLqqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366970;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rllUzOQam7x4eqYrG+gg2s4blSkGSwD474tM5XvKs3s=;
	b=2vQwZCDhRzeZ1tTXDSncJ92+QPrxJW/OY0ZgnTU2yimdM/9ivWwqUJpdm4IJz68EXr65
	 0pkCDrvrsEE2HJGmvxQt38mQkyogxdfTtxayMxpnxsRCgEqW28ekosMDBmjCdm/Du9PxA
	 y8+5pj3zAYoHnU9yBzKLeZMJIZ0aqfbaOTygGqjcFAEXaob9Ww4ouoBfU/Qzhje09ZZVt
	 bwcmLEht6Q4Tp5kgre+Kaw5+9Vsl05iyXexu3TT1QjX3QXrYqqDRGsmCpQI8L84Jqe2i1
	 UAVvl5JtbAWqBTv0kKItctNoU3ogVFPKPbnGx9fTrQR8eWB72vHAzU9yy3Vbnxr09mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="M/Y/u4iK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748B8606A320
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M/Y/u4iK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065561F0089F;
	Wed, 11 Nov 2026 03:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366970;
	bh=rllUzOQam7x4eqYrG+gg2s4blSkGSwD474tM5XvKs3s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M/Y/u4iKT1kCPMNs1KSjPa88TKFesXQMW/6hEhfkj8QdyqUQ3EU8VkD0JyNUMqs20
	 1U1v8GMzLZxOiWMkGboTSiUHqAD71m2hpJc9khQFX4GEwzyPlJMQI+G/1JpPIi3god
	 YheMrNcamDR8VTHGeAItgyIgz9cu27HWiiaV7FRtkbtIwZes0XJTetm7kAAegXg0bk
	 3J/nfasiB8R1OTsn9cSgG99RTt4Jfad1xna9dTnTL22vTevnAOKpxcrQ6AWddquV3J
	 wUGDkJNbHelCWR+tw51AJxPXwLcjfsn5Yw1nReZSbVmLubu8mPJt+mJYX2gKr3MgfV
	 7onUdLIXflF4Q==
Message-ID: <sashiko-outbox-208167@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 02/16] ALSA: pcm: report partial progress under the
 stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111025655.63951-3-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
 <20261111025655.63951-3-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 03:16:09 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111025655.6395=
1-1-mynameisjune111@gmail.com?part=3D2

