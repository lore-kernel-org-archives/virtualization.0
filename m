Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568594;
	b=2Egw9vWcoMQrHGKaMVjSlP2RhMM++tchQzJn1+3s+FAe1OikuhOggNF8348uJMqc/WIO
	 XBkEuThPKYW2i6tTnjQ0+mN+XfVEjAD3Je6CYQijM/bgBpa9MenJaBz6jOLEzMxd2lmeZ
	 /5QEX/uCxzK2cGweCZbzcMnBCuoIwgFIryTwZo5ttKiY/MBgztrRO9AdwpQcZOZh4WaRw
	 ZBv+5DM4LBG+UsOzFIQ6gDDzeRwItQmKPkSVmY3sgkDtiQB8XHZK4apF+tml9Zzsd6L9Y
	 KFmfh+gq1FyewXaQ94wjZe72d0phTY3zLd1o+VoRwq9UAV2voS2WeN+QCLKOYbL2Bog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568594;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kZPffcSA50IDQ0mH4+5kfQNBQo4hwiixPozpez+fQt4=;
	b=U5mw//lgOZzylXRPFWhaONtZ0jbjY/aD78LrWJoJiuNAiBmzgbcYqOmKjdfY7lymXZIE
	 WDXdh9S7WyDb/2WXpEwzR6FvHj/U9ajD+WiWX9vkh0guEud71tObScTRqxTlXReFm6YA3
	 YT01GpF2yJXwdyqbVecQC04us8s815kTpRkzKGyi4yPBGU1YMUagt9LupWZDd2wjSc737
	 n2ro9+YKLRjjhbBwTgENaiySJfARsRcd9lmCM/601jffPq66PR4ynLu3eH4qkyNqfsQG4
	 2SmjooKHJsfnqZor6HVDt5usa4+qASavM0j6VSdvp8GysabwiHsVSD2gnHthdf0X+Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ki5ogUbZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB07606A321
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ki5ogUbZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682761F000C4;
	Fri, 13 Nov 2026 11:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794568594;
	bh=kZPffcSA50IDQ0mH4+5kfQNBQo4hwiixPozpez+fQt4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ki5ogUbZX9NZsUBaGTE1x/vbdEn6dQsc2LYwwqvCs7/bDl44lHcJvc8S3JoV1GO+n
	 NlInkIPqeiPk70YUrOm2P8O5o2RJL8s1VE8l4TmSjqs3vqZm2vQuAlqRnOgH8GaOjC
	 Fmkuwx3iZ1nFjxYIfq9vbv/zE78llZRprkqA2P7v9x6sPmF7hdFgyxt5J6LwR8R6DC
	 tw6OIEiGD3gD+nVlbNkqY5djyOtIqb6oRM4QOfAc7aiF9aqqCtq0W1Nx03Hhixw18O
	 cmMa7exueRCOz7s4yR0xazii1SS/bi8mZMhuTQdb8wYHJJbJ80NTcnsLvi/Sbs8ma0
	 J14ksj3nuJeog==
Message-ID: <sashiko-outbox-212694@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/qxl: Handle failure to reference the surface
 release buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Kazinsky" <a.kazinsky@ideco.ru>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113110658.4188477-1-a.kazinsky@ideco.ru>
References: <20261113110658.4188477-1-a.kazinsky@ideco.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 11:16:34 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> When allocating a surface destroy release, qxl_release_list_add()
> takes a reference to the buffer shared with the create release.
> If allocation of the list entry fails, the error is ignored and
> the destroy command is submitted without holding that reference.
>=20
> Once the current release buffer has changed and the create release
> has been freed, the buffer may be freed while the destroy release
> still points to it. Garbage collection can then access the freed
> buffer through qxl_release_map().
>=20
> Check the return value, free the new release and propagate the error
> before submitting the command. Increment release_count after successful
> release allocation to balance the decrement in qxl_release_free() on
> both the error and normal completion paths.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE static
> analysis tool.
>=20
> Fixes: 8002db6336dd ("qxl: convert qxl driver to proper use for reservati=
ons")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113110658.4188=
477-1-a.kazinsky@ideco.ru?part=3D1

