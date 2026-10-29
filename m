Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793252895;
	b=2AJ3y9SK4ii+y79gbxAQtATj70q8nF9LpjyHTswOAeTp3ADyizlL7MdhIkSO8ZcHZIqw
	 7VqfewvdMWFIrLGoHF+0+cYn7bmBds/S5PEEbsE0HmXiwiRxchrs1SfzUVqHxerHurdL9
	 Y6IUomQlBovkqRGCdyODJZmP9ZlNGlCY4H+iOzHb3BDbnfGD8NbN3cN2evmVpMgDRreLJ
	 2wgZbJ71fFYm3vz1oj8Nq0uhk5LvGbYDu+35V8v6teRWQALPWIBcngKtR09lH+WHuNORw
	 uwmohflsVZMibNIjfVzI0vziFlWW7Fdu2QA4z4KMDQBwQd8XcSDWeoLDUsvF64vWW6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793252895;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VBAKbfjr3xW/FwdqmxwBmnQrWx9xBgic+X1WQCmxorw=;
	b=z0U13FFMKqV10qWeaCrYy+hx7Ve0tE/C2nmLY8/UCs9zWjAkmd7fJMtoxEmfmY9azl8z
	 Lo+jlabo4EisuB2Konntuq4k0+zYm5/sIx6Zag0rxbPkJr/hVrv1+Ux6h/WY8QeE22nrz
	 Dsmm9d03eSXrgkDUmksutvvZRIYBRLHUNKoml1ncKw3pKKEDajycFO3LqCfn0XQbT47/j
	 cSkWNDP3bzB7csdXYz3VMZ9rg8PNGf0U0fzuY/a/F8Khlh90013kxEVOl8sSb7Nh73Mxp
	 kjfiQYsHd/TEX1SgZUrR/wh+VERIifx1sjGqr58OfbWueM8Bq23hL/7j7TSVI6ceWrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+pKBARE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C7606A31A
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+pKBARE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC431F01825;
	Thu, 29 Oct 2026 05:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793252894;
	bh=VBAKbfjr3xW/FwdqmxwBmnQrWx9xBgic+X1WQCmxorw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g+pKBAREIDRvfOIxtcgCu6YVXx1wNbiWyeZHfQg78WhCYOVIZUoUV3AWDT1ZXLtgR
	 HTnyGmDR3Cu8UOYaGp/ayC2XZ+NzgixD4pRuFo+j/s1aUAuUiH0iZ/ckJ3sm0YEc3V
	 7UHBayb+dD2crPX41cCVZOQjtj5i5nUpxWB0jxXM+DXZVIouTaKrhAxVorrCzeB3Ta
	 d/qfjEinAmY8pbGrptGl27IqFl8sMmtWv12Bqa7MYuZU4JfRDV7MUl8rAiSELGbTNH
	 9uxgykgnEi6vMlFyHK4v3CMhfTsw8l0Hhl5LUR3xxpBJMAEawhd1fUvxBcN+5IxG6R
	 oxuDV0ejQh5MA==
Message-ID: <sashiko-outbox-188772@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/14] ALSA: virtio: prioritize staged capture period
 work
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261029054354.2931-11-mynameisjune111@gmail.com>
References: <20261029054354.2931-1-mynameisjune111@gmail.com>
 <20261029054354.2931-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 05:48:14 +0000
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
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029054354.2931=
-1-mynameisjune111@gmail.com?part=3D10

