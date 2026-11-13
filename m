Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552835;
	b=x2jyvfxfJXahqxHJ9qp3sgSHb7dkFhOB0FXsoHWgMtQyG9ClstONA727ABDaL6aUkwo5
	 EoKAQMMAozcqxoZoa728vCk4w29qllHHdq2CnozhaOdZR4pmDE+ducSaX+R5rjKnQ2a6B
	 NV6V4wSBPr/gjE9edMrHuzIlXrRAMN+pVAx84BqcS/scr1N6aKqbXYaeY6wtn5yvqwhlk
	 692Ao/1+sgo3LDmC3q+cfKqLGr/BhyLoUmQkuV6dEaSkIXWmxyMkwfCC4OwMp9jnKvz7/
	 mmmYwy6xDwTbOp9jekCkDZhL/BNv2GTEiTpapV/rRoVrb7rjD+LHiAQnA5AufDJRwgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4+anOHuchfluOUGgJusdKt5vDqWQz2mEwE//6h/lgg8=;
	b=h8EMPeXHOwlpAb6q3y22H4ujhFS2zigEWw0gH5kmNvgYjuOhY/1TmT0RshUi/X8ZlYfD
	 jn4Y7FL8D4D0XfR8rdJt+Hz1tGCAbeoioONgzNAZmcTO54QeT9V0SbB+yzVd08m19rSk7
	 PZSXWfqFbEQs0MpKd+Qx/GqifYXk9mDttwjitb5Me6ucx3u4MV1vY7NLKLsDPqp7tTNR0
	 udVKia59MzjUogJJs0gxbYjAugN+/UTZiElA5b5HuYqOvGz7YDc0syp1uwmVHD1t7V/k2
	 TvsfMlTDpEJgoH7RuVD30xiSGmuxehhzu8TCsyp1AVWIjGb0wqBtQ9jjxqCpzpJwj6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXbk02Vp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E6F606A31C
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 06:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXbk02Vp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9DB1F000C4;
	Fri, 13 Nov 2026 06:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552835;
	bh=4+anOHuchfluOUGgJusdKt5vDqWQz2mEwE//6h/lgg8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MXbk02VpiS4z+qw6grGlksBF5ICgVyuTbldAnpbPTue17LKkFcNovPoN8eSMbI9KA
	 U64fqPmUtTsviLjyUZcHfgt882ppJEcUsy+9s/4U70wif1Mqa4bmoFSswArtiv44xf
	 WBqP0eQcf7JDiMCASfQ1zzAbkV6jrX5+CTg4Hhc95pmJI5ZESWoJ1ZBJhP7/QtVnzu
	 tq4e014TsrkFCLBcdSPV+n6ZkHH5fthxC0izOEr2S30egp9TDGGNF1WolccpEzhc5x
	 DXLVO6HVpgxL2DFWY9fxXzDuGtNXW6S6d1XoSqUS5Mn5ABoD10QPq/PvJeg0wRXU1A
	 GrVMtnGcsHINQ==
Message-ID: <sashiko-outbox-212294@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 04/20] ALSA: pcm: notify drivers after linked
 prepare completes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-4-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-4-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 06:53:54 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Joonho Lee <mynameisjune111@gmail.com>
>=20
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
> [ ... ]
> pointer rebasing. The new callback runs with the group and member locks
> held and must neither sleep nor acquire another PCM stream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D4

