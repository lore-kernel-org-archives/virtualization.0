Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793182043;
	b=heRScgWHFL+CoStGG49bucuZDvUIkoaTmdVGZSqWKHfkGy66I5jKNC4/qDMcRMN/b2/U
	 TSPi+f/mMT4T7SsYdMhWFOA7qdctG7K0YeU31683zmNivlTFOumj3V/HGNuhDmevpr5Vy
	 QlLYX9koTtRvczcHVwdRjtHzR93cuE1nVEGitObGCkPG8wCFq9OqGH9WZZ8qzVS4zQyri
	 Pki0OBuaCcVCIGrz9pIDh1Yk64jlDczbb5HxOO2wU5ROQQ0Q++EE4tbgw5PIWjo8AFPtS
	 JDXuhpIup/rKpI8alLIVMuhnN4Dltrc50/6q9qpRElPcuVugz3dFrfrPL1mrAHyR+ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793182043;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N1Uuek1H+2UuKVrqES6JiYTrUQ666nUIxurAFyEhcYg=;
	b=rSDW9yLr/A4Eu/OAwG27YQBNrWLpte1092Os9hGnPWYButdi1OIXBwAZFiHIVksw0zDI
	 DBNucT5Po/rFAZF7JGhm2UOaRWjy7+ist8W22TV9HHXEISqOzerplPQzfdDGCPfQHpjU/
	 +ulpo2GNbg7bmEGkRDoGmZ9lAz0bQ8imQMz209qFdAFMh0k2prdbr2eehT5xMtls9zCue
	 RMf/5JnPPT3gNz8yh6khwRr7oXAbkSDtPbB87HtSgvgzLipaxaMJj3p4A98wPXY7djCUe
	 fHgzmWf71r+1GHjfQnMmHWxf2EvS0c2cN944KzOPMM1OZKolLAzAp55goegjxu2EUlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSQmtVTJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC65D606A31C
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gSQmtVTJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FCB1F01828;
	Wed, 28 Oct 2026 10:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793182042;
	bh=N1Uuek1H+2UuKVrqES6JiYTrUQ666nUIxurAFyEhcYg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gSQmtVTJCeCC5T5XhvFykG+sgYTn1ltxnQei41YjvAQPyOtQK1YyUiTQNrFzPmBTi
	 nLEvxjp93ispaXIuL9dhzmldkcG3m6hW+5StcQ+atiBqNoxkch/j32Z5Oisv16V7ze
	 02T1SRF3YLPizAjk1FgwgN6MTh34qKU4qRpSoM91Nhu893Mp22thjAdt9p5zdi7IDm
	 aaij2zdUFcvwTV9wQd2RqBxI36FJz4ej3ESV7rTDdutC1u1QSC8gKdXDiQLpkg0FNM
	 SYOumi+IW/ms58L4OxSDo+JtbBWN7W/nNtR+zROU0ensa06/2Kzrce9HL5LztpSMHi
	 PQKK9iHWnnFYg==
Message-ID: <sashiko-outbox-187723@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/16] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028094132.20364-2-mynameisjune111@gmail.com>
References: <20261028094132.20364-1-mynameisjune111@gmail.com>
 <20261028094132.20364-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 10:07:21 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtsnd_pcm_msg_send() can fail while queueing a transfer. Restore the
> failed message's length and notify the device about earlier messages
> queued by the same call, so they do not remain stranded.
>=20
> Propagate that failure through the indirect PCM transfer callback instead
> of discarding it. Commit the updated indirect state only after successful
> submission and stop further transfers when a send fails. Return an XRUN
> error to ALSA so the stream can recover.
>=20
> Keep the polling feature path unchanged.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028094132.2036=
4-1-mynameisjune111@gmail.com?part=3D1

