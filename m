Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793339340;
	b=GCNyMv2mbB3KOMeCUxumsbiJO8oKfKagcuOZ4OHoGOaJX664RyomOUKRmu5OFarDPUAX
	 QFAVhZwpiH79/UW5tsSISyBJ5gN3v1mS5ZRlYZJh88w2QFzHvSeWvYXPpTB9v6t0s1Azg
	 v13gzD1KP1Go+ktr7bsUJX0nNZc/aX/9czBd1PmdNGfBuQY1j/Wu3Yu7omD5sm0jeO0uH
	 fJ4VF+TWoXuKpDXRqACfUrHJEzU68SMDuEwcIMj59LFZX+F7nA4KZdi6rF2o/gik+1ggT
	 5o+rvLsdZgiYrM6Itv0PtMuoHgFLfU7V2/SQ/zj2Zg9L/h2XSE7DFCF4ZYg9Dbxv2QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793339340;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AMHyyBZ4D8IIRCZwHZepse9ccyhRMGroccoEGkFw4vQ=;
	b=B5wQQwdNBhvjd/+d1/BYyxGLJB6BOPMkUK87JWORaTo1NosNYkqh7JnK+0zw+JCvH/iF
	 ygz51uCOqIEHogdHv01efspglKOLZRf70sj4+fByAcrQVnp1rdA2/8F1oZROF4M6ZsBI7
	 El9Hy9/X9iIG+8aPR3ACNgBzNxIPiRngk6Zw0T7bGPgfOdfTCK0Ui4SWfp3e30L7RRTSC
	 l6kRzASw+WQJ5CLyd6kfNU8R4NKj5Vo7H1T/djharfEXyTGof7tYkAalEC8PDQeGqXKEO
	 JerkKbWukxET7VNsp/UrO23Tz8McfyRyMCXcHGUMvc8fgYVfsqdUN31/v0t1z1AT9aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTXA6fHQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBD2606A31A
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LTXA6fHQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9031F000C1;
	Fri, 30 Oct 2026 05:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793339339;
	bh=AMHyyBZ4D8IIRCZwHZepse9ccyhRMGroccoEGkFw4vQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LTXA6fHQ+Y0F5Osdvo3cD2TRbkgFRbxzvpfDlmlUuwvRxvSMQVx0E6k/r+7m3pTW5
	 ArUrOBM0jn0xdelZrz/hbbJbu4El0x1sSF12i+Hh/q+tiLRgeMzHxOMrGwqLoYqqsU
	 ApWIkuTgGEsFUdluA3syMCmJLF7ppVko5wfgJFbBxtmse4Nwi5/xaungFQMklWYv7R
	 w93cp9hqA0STh3ALGexiv/BLhw3ekIKdjzfqqAbsnDB+P38WlCbioAos9LE30wpuon
	 LdJZFl7cilWkTdpB/5H9gtXjeIXxA3hibLazz3ViGEjn1H8PtwXMB+0HokLcsaJGqB
	 uUKrLZpUiRlYw==
Message-ID: <sashiko-outbox-190576@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/14] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030052629.27742-2-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
 <20261030052629.27742-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 05:48:59 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030052629.2774=
2-1-mynameisjune111@gmail.com?part=3D1

