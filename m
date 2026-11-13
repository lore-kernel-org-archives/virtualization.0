Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562439;
	b=KnCHMNE26iDUM+TAaY+fS+qCpwbQvNmbL7VZ9jTvfpEt1G/uTedRqakOqZnc2Oh2OfGQ
	 Bf/FGWbecUZuod5poILj8nr+l4jf6E4NUwFH6yG5A+lai9txdt88MOfOcLpyQchQS+Lgn
	 ykT9jrSytO0jADZHPMdMyaIkV2knd7O9ZzLv6uwJq3jy/KZ+i8na3OeYoP8yEkc1igleq
	 Y+mIEWptNnJBJml7y6z0Fq8iO4/o+7doerJ1jJqatPxLEH65/QzZlKj4xFgmjaqgGnBi5
	 pPBTQX3oHni3a/2EpO8ijfeBKsbmFRkc6Uek8YWIY1iVmOlY9lwxZhyhxGymt9WGFTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562439;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0CtGpfu82CxbL69sMWRHzPgBVDDH87edeYngL0ruNQM=;
	b=yTv3dlob6bvlTC010G+pgKjnb/U0PPASnFGZwfO+7QM/YJ3vMOkBHENXQzdKQySNeumj
	 Y/kkI9PqdFUwmDQcbo/qQophyMgCLJ7wDn5hRbkwfeD1C+StWMFlk+at+NPbXeRi+LGAj
	 /DmPyBueuHeBBf7uUKV/a0vBjUfAlw5M/8iWmZ+lXCL7xwPD9tQFaCBtYT78npY1IkZe7
	 UpjuktK+Tpa/ay/435yz0ggdIS4XXbvs+7gFhVDRHZrY5Zs7DKCceAdTSTRWzQB/Ia0A8
	 nI8YdM8ItnX5puAxd+dng4XVSjUazszMnb9of4lQ3D6giCbucz6ShKeX1cXtDmIv85w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AUwmB8Ev;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C445F606A321
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AUwmB8Ev
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461941F000C4;
	Fri, 13 Nov 2026 09:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794562439;
	bh=0CtGpfu82CxbL69sMWRHzPgBVDDH87edeYngL0ruNQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AUwmB8EvmpVlXKNoGMTLsDrcsa1YSOSnmPBMnXUi9UhES7Z0a4iqN9Sb7VFuIsMmC
	 ZLh93iu1LJggMqTksQjwJ91/DbW2cK4pNBAvyuo/qlfGiuaOsnXbODd4Uc8lWL7fm1
	 izx/0DV/+oY2nVM+aNQfYAW9tfYh2f3eHICuzHNbZt8Bxmp4QE5qwYlWq8Z4ehZLMr
	 r+Q7Ju077rbnEjvtQQDVduzRb4nqL646+qNn905DpGL929tuz+5CM/CAW7TPt8Axwa
	 8YnvE2JstT6xowcWgW0gUA9M9Q7gk/Sluul85/MSQBBqR2VqTLePp6WYS0Ap3K1yHw
	 n8HRQr9D01V6g==
Message-ID: <sashiko-outbox-212551@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v33 14/18] docs: describe virtio-sound capture options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-14-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v33-14-13a934ad5ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:33:58 +0000
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
> Document request-owned capture in the ALSA configuration guide. Describe
> `capture_packed_status` as default-off, reading a packed trailer after
> returned data while the fixed status scatterlist remains the default.
> Describe default-off `capture_pause_restart`: pause uses STOP and
> RELEASE, then resume uses PREPARE and START; disabled mode uses STOP and
> START while retaining the prepared stream.
>=20
> Note that on MMU systems request buffers are vmalloc-backed and
> page-rounded individually. They remain allocated from hw_params through
> hw_free, and capture data is copied into the ALSA ring.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v33-0-13a934ad5ece@gmail.com?part=3D14

