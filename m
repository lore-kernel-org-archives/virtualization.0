Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794182881;
	b=Cu+6J1Ia74CfUwo9HBHM4HflxkK8RrIa5vKR6rz3TdyN3n2nNk8m5hmMhJ1I31I1OImD
	 JrcMHLE7Gmx5ui/TsKY5M3uSafXsAUQ/v0nfT/nBpIq8GZSDkS+DnKXrvbinobD1HEYw8
	 xLRLheKL0zyBTOrqaaJKJ7J95vHxv4uCprYsbndsgZqW4ugTzCFF89l+EBaE+kyWQCC/X
	 ybeUoBl9xvC75x8g4HbMemHmXKqOoD11Rp1a0vpbFn0coxCADVNgmjhQ3KecKxYRBj6aB
	 WfEdNeuRijAVqVp1WnMWGNnOYQ3uWGSI5LTnQ/4I+BOlJGFz7OS0UmG/DFKAdEkab7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794182881;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=15ARQJYyx4e60tNl0Y4WKa8HCh8tSkSqS5XFX1et5XM=;
	b=Hssjv4hlBB1SK8pxUKnao23ds69UoQ4A2BhnRf45nlP5fpGGqSea7beE1Ud0MdvvM9zq
	 4XZub3u01XX8yU4PwyCmJxNbaMv5UsQbRsPjMfFzcyYmPdFZmOw0l8wbxOCZaZOAHh33m
	 BGuc7a2GoxYXv+srPS9otnt7uAg1p7O1Lb5ndg/k3UfcCqZwf1rvN6EQyd9IrEcheVVxO
	 wOelfYuswp54xLTUjQxxcuUf1ZW8JPq9LSnm1P8EzebR2AOmm3316Pv4D7U8tsf1Wws5O
	 7NSjCxtMZ5rx/OitGq/PxnwcXL4UMwx7UqT7oj9Yur/a6bMRlgKnM5ZrORMF438lDmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dE/mgscV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B324606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 00:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dE/mgscV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5801F0089F;
	Mon,  9 Nov 2026 00:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794182880;
	bh=15ARQJYyx4e60tNl0Y4WKa8HCh8tSkSqS5XFX1et5XM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dE/mgscVWxtOA+HGxZk5gcjabkkzTjVAuwSjSdv2+9GOOAuffknOadzJxrWKvixpu
	 lJ6fCzdOOIudNGz9s3KQ7Hm47Nc8Uv0vUiw9rFHmQJi5VqCJOsBll2GULbAuNUpH/3
	 QId1axeX8aXk4Y7GxQUDh1Zie+0QakgD3/iZUtHPERdHcO/zOnf9jeifnVRyCxp1iz
	 38fh2LNYkKQv4gW/TPe9VpbKzVCdT0QsZzPUpDm8DAIuXxmjND6CT1dCt3SNKZd1Q6
	 oIXj3smW7FS8wPQqXgH2fymhC1kcr9RvYsox0IePf/uH3dtnQZcUL/mRMP/9UenxKA
	 0U2HpoFvftquQ==
Message-ID: <sashiko-outbox-204193@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 11/12] ALSA: virtio: prioritize staged capture
 period work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261108235457.12688-12-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261108235457.12688-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:07:59 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Queue staged capture period notifications on system_highpri_wq through
> the common scheduling helper. This allows capture notifications to make
> progress when ordinary workqueue workers are delayed by CPU contention.
> Playback and ordinary capture keep schedule_work().
>=20
> This preserves the existing priority proposal without mixing RESET or
> lifecycle changes into it. It provides no hard real-time deadline and
> cannot prevent a userspace reader from overrunning its buffer.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108235457.1268=
8-1-mynameisjune111@gmail.com?part=3D11

