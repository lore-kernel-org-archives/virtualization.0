Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837750;
	b=SEMEELcwb2HugbOb/j0/QJo1UYUqaO+Xx7FHrBO8faryYtfLnVsNLLXPyhXYuOY0momH
	 /QuV1YfGMmAZYDOfsbj5fbt57G3T4QbO/KzC4CB22xs91cEu5pMoiuQJBWH3Hd18qZfYd
	 V+vBI5geuFZ7JNoCQK/rIToCDIjzh4N4UpYkNfklegpzfHWQYG1S1NS1PIgIKvZs2RpLi
	 Voix1NsxWbUfSwa1S5VvK2yo51wNtVNojZ5EBX5bh5K70x2rfdPdCcCxNxjF8CHoKmYkp
	 8QTGJk+yb03n01mc5gu89esDhhTqmyeOAa6H5K21mWesgEgYrtFOf5eRb74+dpkssBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837750;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BerBGoN1qSZ+ceAs90hdRrnGSuGJ3WKkM3hRbf5sLtk=;
	b=zJsLK0yMFX8LyyDtbt3y/EQATv938Qzwcor5Bna1O3vWPLT7aSYr7+HotdX74HxpBlq6
	 Y90yX2vaHYSjCdTDK88Rfhe28zrVaSVMTpryy40bR5yVD2lCjz/UyIzrQVkWEFtxgbGBF
	 qcvd3MDUrv36KcUlG72eTuM+6pdhEf6Jz2XS3DV8tdlZN0I99o8aKLdq2S0WUOw054mtu
	 FvfXJUQEzxIloamXgA4TNO/+mApd/EI4llf/cnfIZ9L8VomosHI1+zh5X4GF+ZOWO5VFs
	 4qL1OXQ7dsZElhqHR77ZiLZPcZCb3VfH8k1Q23RcX6vNp3opvxely7Y2D7vm6kJ3Qcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JwjdWDIu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC68C606A31B
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JwjdWDIu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552511F000C1;
	Thu,  5 Nov 2026 00:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793837749;
	bh=BerBGoN1qSZ+ceAs90hdRrnGSuGJ3WKkM3hRbf5sLtk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JwjdWDIu9goLg6quifeekjBZ3LOtetJj23Gg+Q4MBY7TUZRQksWndFvEaq/cYHW6C
	 PjK6BD3YxM9i7XZpdzBnAudt3IQnJ5AmqYvnOy8O7+NMk/KzG/dOJfOIbearbX+ry3
	 tDFuLPaEGCcdZc9ufYKwCYxHAF+36OiwV7VknB0y1mo3gs3qLcAgg8xJzW05fgQpH2
	 h1w1YdPaBoGXVrrABIy3WdUJgjDaPs4+8fgibmueQ5znKHR0Sy1ymkTLbGdAIRuIft
	 XNM8V+YKU2aCesQ5kqZB1n7Bfamp5GAG3RkybclrbJHCw4FmSoRF2A0sf9XxS7ZdZz
	 FKaKMYf/e9wGA==
Message-ID: <sashiko-outbox-198338@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 03/12] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261105000915.15177-4-mynameisjune111@gmail.com>
References: <20261105000915.15177-1-mynameisjune111@gmail.com>
 <20261105000915.15177-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 00:15:48 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A driver may need to synchronize private capture accounting with the
> common RESET pointer observation and the core's position rebase.
>=20
> Add an optional reset operation called under the member's stream lock.
> Expose snd_pcm_lib_reset() so the callback can retain common pointer and
> time handling. On zero return the core completes that member's rebase
> before unlocking it. Drivers without the callback retain the ioctl path.
> The operation is also used after a successful prepare.
>=20
> Zero permits the position rebase; it does not promise XRUN recovery.
> A negative return skips the core rebase, so a callback returning an error
> must leave coherent pointer state even after partial work.
>=20
> Linked RESET and prepare stop at the first error without rollback.
> Earlier callback members may already have completed. Legacy members keep
> [ ... ]
> callback retained an acknowledged appl_ptr of 64, and finite-silence
> playback kept the written prefix while clearing the rewound tail.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105000915.1517=
7-1-mynameisjune111@gmail.com?part=3D3

