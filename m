Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794712876;
	b=JEk/6ONqWCGEXTh38znvH3iCNQYNfDf4Wu2Jx/21X/3uf3cnlTFW/smW0tWrAATNx5iQ
	 /hdqgQuAF9bjrLqG/ebXub3jEW6ZVQuVw6ygG2XVk2IQh4hv/D7JYR8LwYHRIYf1ZceWd
	 LFdRyu0rNHA+RNlOVK5FsWzRC/eSuW3jywspvqXTtQh/Vey6hg1YuEKXXysDI2/z24i5m
	 fvXRt7/NnSC1tfCEplAYqjn8lTg7nZoq9xbrzq33pmWxP9zJC18rvAkORtTdMHSB7Lr5/
	 nSuOul8eHafeD6FCo4Mu6Tb4N/s2MjpM2L69CJekvQguknk3HM8yDEM2Y/YQm/LABFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794712876;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hWaDPELek1zrapKISJDTc7LpqP2hw36q2gX9VgTDwB4=;
	b=L+FRKS+Dw/8hX3QDXPlpVP775/rAboQcMEE2UBllcfe4lfgNujEnJzw/18364St1BVpW
	 oDWmPtTt9Rq3hcEejS4DSorFkm8wXBJjClegytTXF1VfUn94ba0dedyhZwNBkZMVzqgsQ
	 bcbn69hDB2MgJnX2JznLu+nzhrqBIF7EsdPRzVtMEceP/gLNLWOMjQ/gVTObhJz06iVe3
	 NAlTmWoofAV8y830bDtx1AgZR15qaNLuqa7/1+cNtFNh93RCekHMW8bJNQZ2q/z6KYWDO
	 tHDa2lwPdhWqge6BpKgfaqARSV7zlOgkrjmkV4aeId5G4lK13/GDZJdDh+fzgfGh4sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awyBbef1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDC4606A889
	for <virtualization@lists.linux.dev>; Sun, 15 Nov 2026 03:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=awyBbef1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B291C1F000C6;
	Sun, 15 Nov 2026 03:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794712876;
	bh=hWaDPELek1zrapKISJDTc7LpqP2hw36q2gX9VgTDwB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=awyBbef1IUtYVZmWo3VVw9xd6Jf6xFNcnJ7IOlxZc43yWkw735voVSFvGyUi/X/Dh
	 9QExqIxBBBJx1nQiOOFVxULQFV6nwZ2vmTd8K1De/aKJ/dBH2ZXh7+wet6LrzRdAtS
	 WGcpibLNDEQxHxSATJnbnk+JeXqrItAd2fXtdZdsi5l5q/NaR7FbFdpWINSpiuMjBn
	 ATM2ErQaKuy1Z7ShK+gA+oqnjGqOytL+1uuP9GPIc6Z/1Ilb40vbOwhZCvdqBjEWsD
	 xN22Cp4Gi387SRo8UJNFgrBJyXCgRZ4qtS7X+Wdpa19cmEj0G25ECjBSCg02+WVhaj
	 xSp/oGeduzJ6g==
Message-ID: <sashiko-outbox-215201@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 8/8] selftests/vsock: test the netns assign
 privilege checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-guest-ns-v6-8-3737ce4673c0@meta.com>
References: <20261113-vsock-guest-ns-v6-0-3737ce4673c0@meta.com>
 <20261113-vsock-guest-ns-v6-8-3737ce4673c0@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 03:21:15 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> VSOCK_CMD_DEV_NETNS_SET refuses callers without CAP_NET_ADMIN in the
> init user namespace.
>=20
> Add two tests: one confirms that CAP_NET_ADMIN is required even by a
> privileged user and the other confirms that CAP_NET_ADMIN in an
> unprivileged user ns alone is insufficient.
>=20
> CONFIG_USER_NS is needed to test the CAP_NET_ADMIN + unprivileged user
> ns case.
>=20
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-gues=
t-ns-v6-0-3737ce4673c0@meta.com?part=3D8

