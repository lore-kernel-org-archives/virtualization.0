Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794712873;
	b=eUGSYzJ4xxDi7jskCL2rZTXo0U0XUEhVNcd1jvsp2YaxJ/8oBlAdX/hFtBjItMYtpXBQ
	 nWuMyeskO230ljbNRVmWJrGBhoRvasCegNY8L6oSoINbQaw2lTO5BChY4LO1gwrOeTsCk
	 E/PI9D7pDKSEf2BwuFcPukldbBN99CTeOeGF3aCSDNaf7spT4nYojVOkLYrGrui0QbK3L
	 2nwVskuhwX9uL4TCT4a2z8C1v5NMTFA1HO7eNBajCWTfYTzGdOxOWnfT4lguzxZlOdJ/5
	 EEL8FkamYM7IyGS7B/vo6iyatOFy13tK4QZ4mUPBudXj81Q69J6MjwcfBGiWH9WhoCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794712873;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PKZ77FVMLSmZNF0GCbmd7QxgB6U8yHVP2Z1cPIGmlvM=;
	b=1fuXAPexEqmI3xpbIaBK93HQxWVnhYbbReKyfzK9C5EuqJVdXm8BIXguErW34ZlSQ1kM
	 CQEcvbHJ2dNfYt1dl5uwMRz2V+ARtcjnqasUNDZROj3C3UrmZTmNhNat3wYdg2qSO04gZ
	 MDNdEK93QqG6XksrhIDbqMzoupdrk5+/YVvdVO9Ac7o4xfaJ5BF3u2krgqc15lO/mc0Bm
	 EU4xUtGTftiMRGr8BqvixqDrw6wBfBYtxTnLiEXekjbNygak+y04PBITr3+cbaUOQ9tBu
	 xWclRq4uf2GyuKCdyvdpiWrHgCpLBuKngfDsazoklenFd7or0fyrM1el3zd4f7PsRXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DorwJdVh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410A5606A337
	for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 03:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DorwJdVh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BC31F000CA;
	Sun, 15 Nov 2026 03:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794712873;
	bh=PKZ77FVMLSmZNF0GCbmd7QxgB6U8yHVP2Z1cPIGmlvM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DorwJdVhzFx9HhyygE80bFlEX27Jjb/F8DEnD2WJFBW4znhHjuXF0xbuyMYyV5qB5
	 bFl4E2iCVu9CR8aXnCaIofctqJ0p3qkRRamhf3F82Ct8TWSS153HzfvRvNabYterko
	 fC6yC2Im9rd+MeFU6JnAWsg3pLVZN9kNLgleMV7jlucBVEcQr4iklHIf94ZEXGTOVj
	 J5ynRa+1FKBXtB7VU7BsAIKE0Q7cFgDZ+myz4/0U8/ZJ8ISUyonsby7LZRUBSha8lH
	 h01qM7UAlid0u6kapIpq68nWnNt8gCjHjB6cRBMRArilpzU2F9V5iLJPBHWNBCDmBy
	 Z5YFqoRyqLG5g==
Message-ID: <sashiko-outbox-215197@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 4/8] vsock: pass the netns to
 ->has_remote_cid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-guest-ns-v6-4-3737ce4673c0@meta.com>
References: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
 <20261113-vsock-guest-ns-v6-4-3737ce4673c0@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 03:21:12 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The transports only use the socket to find its network namespace. Pass
> the namespace instead, so that a later patch can ask whether a CID is
> taken in a namespace without necessarily having a socket on hand. This
> will help with avoiding CID collisions when devices move between
> namespaces.
>=20
> No functional change.
>=20
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-gues=
t-ns-v6-0-3737ce4673c0@meta.com?part=3D4

