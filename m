Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794462691;
	b=o5MvKwQHGPXP8Cn0/rg+0hJr+atc8U23kw3yz72ToebzBygOhcRFaEXy38blhBoWEZGu
	 ub25ooBiH30ftK5rdhpxcnw0BlFeZgBluoHtgYN2HXRblEE0Wtdhs6ONiWITNA4VUahIt
	 XWwe570BrWDlzGvMitzKdmENSvdJvmIjtymSPJSSycFGH0G9Xpu5zLA1in1Qh4lCvL8wd
	 N/RQ+AhzfmhCPLAjwdX8yOWDhyLgbEXC8vBUNguvoGYt4CDU18cyn2eLnU02jk0IsSr/O
	 21Jxed3K3/WdPQ8G+HwlGblXSjM6POH+hhQvRHpRr6v6PgFgbBaq8w6y6x92G3A2yTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794462691;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UUjMnRBuU0Fh/rSw70zHrQI/AjCjxGaNjydeFjv+iVI=;
	b=FyCZ6mtHqJCOD7+PaVsanzA9RTix0TQuSwx4lo4iPtK7e9gbvrsbFab/p/82DDFcEpQP
	 mrNaExhU1kiKuMevXbm/ApVdDtdDVJf0oo+YVLRXtwEoJzRodH0mKog9uEQExKBlfoXhR
	 ljtbmORd6t+38EVgt+WC1xsL1SSgnWkLPVmoG9hdVm+l7YbXvrbp2WPnZNrbUuCPGsJTg
	 nDyuIbiZxIW9lBaESakOrzr1Do0YxaaPSp3N2EHW4h9w13CTbfJLIlkwe+W0V+m7dsFOM
	 jDAn+mVhxB8qW947fTGZMeh0NQ73GFc0/MDvMxDbUoadUNeJlHnordYlkcdlq6t8Jgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T39d0T4C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB13606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T39d0T4C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423291F00A05;
	Thu, 12 Nov 2026 05:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794462690;
	bh=UUjMnRBuU0Fh/rSw70zHrQI/AjCjxGaNjydeFjv+iVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T39d0T4CF+kXRVrJBtqAiX87OI41uiVbi66OivJSt5mzJYpsUWdn9a/U1lJw5rs5x
	 AvrhQXXUPEwIX+p7g4uUvzJETDuA70MZsdz6LIubynleZnNyRbiFRn6p5WtG0IjpvN
	 TwBDX00NCcW3eRqn4WhvIhPr0xBPBc7A8sjkk2jtwEvmCagkwjC+bLDa31MM/VuYhm
	 zmqkOdyaEoJ/8KcUvq/JOlR9b7Cj9/Z+aR4FOFJd/Q7HQLDxywT6xXH3QmK4S3f3WQ
	 +hE9Tg0hZYjU3OfyHm6nNAt2EIApWEhuBoti282VNWWvJqLnjwKinqmNh9HzIz7lq/
	 fkl5rgaWUNFrg==
Message-ID: <sashiko-outbox-210483@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v29 16/17] ALSA: pcm: add an explicit application
 pointer to indirect playback transfer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112053446.73504-17-mynameisjune111@gmail.com>
References: <20261112053446.73504-1-mynameisjune111@gmail.com>
 <20261112053446.73504-17-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 05:51:29 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The indirect playback transfer helper samples runtime->control->appl_ptr
> internally. A driver that needs to refill already committed data from a
> pointer callback cannot pass the application-pointer snapshot used for
> ACK validation.
>=20
> Add snd_pcm_indirect_playback_transfer_appl_ptr() so callers can supply
> that snapshot. Keep snd_pcm_indirect_playback_transfer() as a wrapper
> that samples the runtime pointer as before, preserving existing callers.
>=20
> The explicit-pointer form lets virtio refill accepted data without
> accepting new application progress while the ALSA buffer-access gate is
> closed.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112053446.7350=
4-1-mynameisjune111@gmail.com?part=3D16

