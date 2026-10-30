Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793339608;
	b=YoV+hdqAmSAwX8TqFGQe7i67QoMSz7FVlcRN97+JXmsoeJVei5spc/b1AYukw5Cn1uD/
	 1FNerebScS1bI7bI/Of9wODV6KVJHno0BIRsUM8a5M+gDZ3LBazQPyy7zJ9bbJq+7V22+
	 p0i3oCfC8zUZThgueNthhE3d4zd/8l0Yt/sPiIgLg9hU0IkQ8aJggV8tLhQC2hRLiOblT
	 MjQs7f6dB23OlMh+dmOaO0sSU8DPCvvz60iBqPClSOKCdz3jTgFheY7xBAt/NZanmWE21
	 KIeMaNVBNLIiydKqblb6nsb4kyV/DYX055wCWLSAxE/t4kkgn3madWx5ZRPYLCUWFOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793339608;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3dip+/xUN9eodUmrcHIm1mlvf9/DF/tbMkEYUSu82m0=;
	b=z/DeIH93go7XI+GJqBgEr0dwMTmtzbfJom75d0d39gXqAqRXQOhuIuC0qwWqIEO2/6I+
	 MyLxi+MoIxPG/kiGKfTyBUmi4GuZCWwNvfGmz7hNG8kIAA8AofNAAE5K9546fki+H1MVA
	 VuhRRaWNq04z4/CmZ8rqr9FFgbfj7LEYS7mSmb/zWzhasAl4BbltyniS+UcQl0QYMuHIO
	 gD5L8hvbDZwEWTUYbfJElNZqxemYgbVv7yMs8eXlzju29IPpkkjXpD7EEVtA263ZBP8zN
	 lwrTlvu62Gl6Bu1ysn+ncMr9dQuj6vSprAVehquD58RBK7NJhYAoqiOIzuTrSFkQIRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpYQYhw1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DA1606A31C
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpYQYhw1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7B11F000C1;
	Fri, 30 Oct 2026 05:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793339608;
	bh=3dip+/xUN9eodUmrcHIm1mlvf9/DF/tbMkEYUSu82m0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kpYQYhw1CtDRldtTp7BlPQc54QuhL1WnvIyFLC9LB959iOPfC3uFl7YCUNpNjxW+p
	 SQzOZT16y41PZwnVPLkpwGl/MsgpcSoLqWpyuB3LHX7TrvGg8WjA9dau8NmzRcCSvO
	 gt4cPuwIEA0s9Qo20HV8vmUYbwNguUIyN4a70biqxRBp+K1SKOnfPTQ8CNr0UVBeF5
	 mIC5+atxEph3jADmwh1TgRasP5A4eC6sgq7s3A68lABjjfMTBASxEsIFhj1H0toYTQ
	 CfW6Fe4gkHRJgTaoJeoqMvkOXxUQE8zzSZlFyD6VryTI/jDJ+iHYWYraALvXRXSC09
	 ec34tFlPRhooQ==
Message-ID: <sashiko-outbox-190578@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 13/14] ALSA: virtio: synchronize staged capture
 accounting during RESET
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030052629.27742-14-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
 <20261030052629.27742-14-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 05:53:27 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Use the locked PCM reset operation for staged capture. Reclaim RX space
> at the same locked pointer observation used by the common reset and keep
> completions arriving after that observation. Rebase the notified-period
> counter there to avoid replaying old period notifications.
>=20
> After common pointer mutation, finish the matching core rebase even if
> refill fails. Latch XRUN and schedule notification. RESET can return zero
> before the asynchronous error is visible; userspace still needs ordinary
> XRUN recovery. A nonblocking read can initially return -EAGAIN and later
> -EPIPE. This avoids leaving core and driver positions partly rebased.
>=20
> A forced 90 ms RX interval reproduced -EPIPE with the earlier accounting.
> The corrected sequence matched the next 48,000 deterministic frames and
> passed reopen. Linked RESET and prepare partial-failure fixtures also
> passed with atomic and nonatomic stream locking.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030052629.2774=
2-1-mynameisjune111@gmail.com?part=3D13

