Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793338235;
	b=LsuRfdzrlerXRCBNruqSdSnOTsVu65eKBJNxxumMEQjRJA4H3RXI+UxMGhVW7syVjvGx
	 kDlTrrvUddoRh1RhXgE3DhO4XGAUB/2VJUK063xq9xQHP95RlwblfT3pGIOwkbd9edH55
	 35SCZ74wguJkCk9RWzMEyvqqnJ5TgXkolUs22PEn+/zwCO7kRCjsOczIDWtoMSK8bbKTH
	 icxk+zza7J2oLDFT/qLlET3WJkHR+o7vCRQzNGl0v3kHva7cB6eBNEfTeYeJdiiCf7gYX
	 X7o2n22KzuWXY9bjV9heTTUJJS+psHPRVnw/gAaRk0d4r+DVt4Jb4Tsp8Eo8OoITnDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793338235;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bTHOoPdmfkZgCvFuajhkSAVw0RDtB5TR5MLHKeBbDvc=;
	b=jFFd+BjHPTqFZLdSve2WhjMcTbx5cWY0ZCVkPhfE89eyOzoXdgtJ3MHSdWq765U4/n4R
	 l7ybk/a2AOcomPuuZdrDh26pDpz6xxd3ziQuPM/RsWiGHmuE6gmBZBdDUMZTws5aN4pJY
	 Ca2TYmxKA1thhfZY86LtTMhTYhGJmODbLsZXUhCtKXwzIm6bqT7fuaovJxTJhkDQEnUie
	 SxjKqlTAbcfsQZi7TqtNmamASQKoRwaFPbA0KAnyYG1mQLnwOfSWPZfob6XyAO6JBwlj5
	 ZTwIQ9nth8wZTn73tnMcozFUTZ8v/3+6UsQ6q23pfYjnfHAe0UNKUOFx3pSyLx/ESCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwVp3tEz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D3C606A31C
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 05:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lwVp3tEz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1711F000C1;
	Fri, 30 Oct 2026 05:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793338234;
	bh=bTHOoPdmfkZgCvFuajhkSAVw0RDtB5TR5MLHKeBbDvc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lwVp3tEzq/TDpeiwyplmiypsyTXmmypbydwYo8GZq3gadjsCLTN2/5NmTUe2ztCbw
	 w8gSqxCfrF8M+p+yM6sbKGVlqLY2+bwGevRW/t/2lHOX+XVMCDkXqsHfMBGIpDupqd
	 vFwbpHKLVsWfvn8R+bXeWQspAZ0vEW65uF3yNKps0urIQmV6AZ6bxi/S8FHkGJhUek
	 WiSSBZP/AnGtekQX8k0q1sRsMdFjd8aYZlAHjB+OHvQwq7SEzTDvpE9lzYOtjsJzs7
	 luXoR+gawZhNTxiY4/z7XFUoKuk3OUF356M8DyoXq+K8gaMItlUvmGO7rpL3OR51RZ
	 LE0vhgaenjaHA==
Message-ID: <sashiko-outbox-190560@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 07/14] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261030052629.27742-8-mynameisjune111@gmail.com>
References: <20261030052629.27742-1-mynameisjune111@gmail.com>
 <20261030052629.27742-8-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 05:30:33 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The staged virtio-snd capture path needs to sample stop_threshold from
> completion context to distinguish free-running capture from bounded
> capture. Software parameters can update this field while capture runs.
>=20
> Mark the runtime stop-threshold assignments with WRITE_ONCE and the proc
> status read with READ_ONCE. This pairs the assignments with the driver's
> READ_ONCE policy sampling in patch 9.
>=20
> These annotations do not provide a transaction for the entire sw_params
> update. The driver serializes its cached policy and accounting with its
> own substream lock.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030052629.2774=
2-1-mynameisjune111@gmail.com?part=3D7

