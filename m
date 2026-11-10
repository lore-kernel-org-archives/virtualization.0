Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268889;
	b=whoN4p1gUUwbkT/FsE8BSOCJV5c5a0/Fun7fBmNSoR2O/zR8X/M2FtRtErlToq74sNUv
	 nts753hwT87qGG53eTfjsmP9/b/KVjQx1Y+3MJyvd5AOEVMkUP9PYn8K1S4ItjWZwIGDw
	 HzB+RmSFTOBWz3qEx70wTqzvAKCqbMaFu1BhpQ+u+cGwDKzyScrpOLJ2CJGRNOlkoXN9u
	 Fo15jIXb0Ib3a23L1Clgzyy4+4Zeytj7AnqOghesMevUvMMwI2nuErXV7gn/QldJELZQ4
	 0cO10h0E/PJaxAhxNDmZ4BzS16Imo1lOwiviRqXstPNuSE3vzury7dZWoXNkyJLw2Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268889;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GzyGt0dK4K2WQ5Co2pGBNsKdfKdPBsDLMiDT0bzzSJg=;
	b=a5Y7g6+tfy3BF2zXkeyUxud9pUiNnlBGP5undut0cpl64OmO6/3OxVarpFa2sAElWoPP
	 2r2RU+1FcQFd/Vb16ai2nGe/CjADc4uvDkA7KF6nh2yJ9+F6CRoFnTdww0D1FpqiskQsx
	 D/woQjtUQoMK5JMMdVEqFgcAG7crmfm4iGl0PkD94TO+zSdAHR5M+tQohns/g/PvUhwtZ
	 jJlame1lTHbJ1spfNC7Klrvz9i+qolno27bdQ9CktSbCqeOICNNjkZmS3tt4b6imUnd9Y
	 5OuNDYRAVdc/DRlWXPEQ9lHFiOWdmGJOJdYMqV4nNndLQh+Ace1CnTh5Pu8aYXcK/3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYGawI+w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089F8606A330
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 00:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NYGawI+w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05DB1F008BD;
	Tue, 10 Nov 2026 00:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794268888;
	bh=GzyGt0dK4K2WQ5Co2pGBNsKdfKdPBsDLMiDT0bzzSJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NYGawI+wjJq/lps3vsIUyO8N2cxLUn5Yakxd0+B8+5TLNZtXGPcGTnGw9hpNXPiXi
	 pYevdo2L656pkYYkvjc21ZHsxtF7iUNX0jL42gfutiaTHTPCBmCIeh4G+yr/FkJczR
	 4tuvNPByUcODj7B/rO0/HvumSST4JzXf7BJrIHwMZxjU/fduOJbv7RAniVqKnML9GN
	 pxJLZr/rSt44M6CSx6XmbOKTyFf9rDi2Al4Sfr0AvIhnC1PfoZJn7abIDQw/3En3it
	 4WhafKaesuel3VTkG6LSq/mYn5Tm+1S/qax9vmB/eeaWmFxqaiWWd7pkJ/Cvniii1w
	 3sDdoJ9ghEEQA==
Message-ID: <sashiko-outbox-205805@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 04/14] ALSA: pcm: notify drivers after linked
 prepare completes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109234049.79534-5-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
 <20261109234049.79534-5-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 00:01:28 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A linked prepare can finish one member before another member's driver
> prepare or reset fails. Drivers that admit transfers after their own
> prepare callback can then accept an ACK while the group action is still
> incomplete.
>=20
> Add an optional prepare_complete callback. After all sleeping prepare
> and reset actions have succeeded, take the group and member PCM locks,
> publish every PREPARED state, and notify opted-in drivers before
> releasing those locks. Keep the buffer locks and access gates held
> throughout the operation. A concurrent DROP observes the group before or
> after this commit point.
>=20
> On a driver error, notify only the attempted prefix, including the
> failing member. Opted-in members in that prefix return to SETUP. Leave
> unreached members untouched. Preflight failures have no completion
> callback. Preserve SUSPENDED and DISCONNECTED states if finalization
> finds either in the affected group or prefix. Successful driver actions
> canceled by such a state return -ESTRPIPE or -EBADFD, respectively. A
> driver error keeps its original return value. DISCONNECTED takes
> precedence when a linked group contains both terminal states.
>=20
> Do not generate a stop-timer event while closing prepare admission.
> Ordinary legacy drivers keep their existing successful preparation and
> pointer rebasing. The new callback runs with the group and member locks
> held and must neither sleep nor acquire another PCM stream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109234049.7953=
4-1-mynameisjune111@gmail.com?part=3D4

