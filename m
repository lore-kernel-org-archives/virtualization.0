Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794268097;
	b=FTw268+8N1ZCoAuso3JY3eDCLEkOJf51VzTiQ7sJaNUgwOFo2CjZmNxVRMOJ1/M7wrhl
	 Mx51n6DuEoZvdGxx3YlYv7fW0Pk8a1eqJofAGJAvLJoj+HcdWl4yJ+CSrzGDmhg0rNtbP
	 uvgQHI3Bmx0x6kBaCCDfFJwuXna2e8eV+nrfZlMdUH4FdnoWZWYgdpYPxxcE4VyCnVuSI
	 94sHsJJcnjFhp9ohNM/WmQoHZ7Qws2gP0Batgv/GNyyjaZn/Ys2SW7Ju7V/reguL1KoKV
	 P3gmgDrkJKaSXTYe1HvqxSyYLln1X7TGV8pEeYaz2WLZY/SqCvSNBHDvDdKBXsslWCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794268097;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=N8AMAbKKztXIN+qOyCR9gaImF4Akc9TcrOYDJOaNVRE=;
	b=5GG2/tIvnMtdbj6rSGA/Si2+v8LZX+DO3OouZOoAySUC9YdulWYqVvMOhM2xv/Ci03uW
	 MIGsGF4bFNeUbdqdrit6jIN0w3Re5tf2WMaUdtye5gDM4GJad36rcseEhwbNK5Yk4oyIg
	 PK121+IaynX6gifp3IlWbXF2cLWhg7jQ8zfDyzx1/1bawLiFnIJ2pxcTgMnZkEpWbUx1Y
	 LC63QkcdvwVLurPk3CwG4vldachrs1735dnAh2dcumAynD+btBtJiYBHm232nFpSnGO9g
	 mDNg+rgeQ5GU/ixfy3ACSH4e7+kORQns4TErSIg6YckM2XGLaG9+wowrx7CIcAVT14A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0HTylbm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3592B606A321
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E0HTylbm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A5C1F0089F;
	Mon,  9 Nov 2026 23:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794268096;
	bh=N8AMAbKKztXIN+qOyCR9gaImF4Akc9TcrOYDJOaNVRE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E0HTylbmECt2M8R8XU2CE0fsPjsLrzoUwqsuZL9Dd0Ewl30F721F8UeGXekGhIjtw
	 6g6FICkP9YzcvR/OjWYlvCDArnR3BACmpdrtfZWwJogC0cKW0AX72ir8OY86UpAg2E
	 uOBibIhC8HoIEfRHQcthlbnSYzGfsQ3UmynKBRa/05WO6QLGXPqixvUm2SlKqbXAar
	 ZW83d0+6Vw+LIp9bEmav45vpBPMD4it5wSUCG4VBQgo2JoYOODn5a/J5z6ahfXIO2Z
	 bYIAzvlikYROlh/YdCJioLqY3tYFoRMeTQOfTBBoYHbO7xFTylPJXtGg9Uejx8CRUT
	 e6nYV9x/1VrBw==
Message-ID: <sashiko-outbox-205796@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 03/14] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109234049.79534-4-mynameisjune111@gmail.com>
References: <20261109234049.79534-1-mynameisjune111@gmail.com>
 <20261109234049.79534-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 23:48:16 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A driver may need to synchronize private capture accounting with the
> common RESET pointer observation and the core's position rebase.
>=20
> Add an optional reset operation called under the member's stream lock.
> Expose snd_pcm_lib_reset() so the callback can retain common pointer and
> time handling. On zero return the core completes that member's rebase
> before unlocking it. Drivers without the callback retain the ioctl path.
> The operation is also used after a successful prepare.
>=20
> Zero permits the position rebase; it does not promise XRUN recovery. A
> negative return skips the core rebase, so a callback returning an error
> must leave coherent pointer state even after partial work.
>=20
> Linked RESET and prepare stop at the first error without rollback.
> Earlier callback members may already have completed. Legacy members keep
> the existing post_action policy. Applications must recover the group
> after partial failure before relying on shared positions.
>=20
> This adds an internal kernel operation and no userspace ioctl or layout.
> Out-of-tree modules using snd_pcm_ops need to be rebuilt.
>=20
> Complete appl_ptr rebasing once in the callback path. A later linked
> member can sleep in prepare while the earlier member accepts SYNC_PTR; a
> subsequent unlocked post_prepare assignment would overwrite that
> acknowledgment. Keep explicit RESET playback silence processing and
> leave prepare-time filling to the normal START path, preserving samples
> written and rewound after prepare.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109234049.7953=
4-1-mynameisjune111@gmail.com?part=3D3

