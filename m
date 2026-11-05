Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793843682;
	b=iq5GxOHNtFWveBUuSQ1b4DAOZ+l9M8mNEgR6k8xrdbvJoExOdNhPFt3PyOo7DHvXQQkb
	 HKYGUui/TbIAtuyZX9H1Pj3xPni6WMZdeqVNQ7FTWaT2MuLEuE2rDzhXBLfbGwFJRl12m
	 LJaA3QX6MGb3m2UoSLp7lUVnWqxbP7yTJqJ6YZqDeDmW/w806rB3fAlgwc7MbiQyrKP/4
	 l2XJfUWWvJYUecPhVDWr/nqLFdE1TKjg28QZ9Bw53M6HWgl1wpApYGuQ/1G+zLftmWMbI
	 +N8CiaHuzsg9lcc6gBkmrzMwTn5bJXUFgmNdYilrr+aXE9fa2x+JzrmZ8BBFsGluC4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793843682;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l/vAaZ+djoPRECUQkyrpwQsI/+lHyaWHKOVGiTvqLdw=;
	b=wEbGkwbUMGqPVaVI5Vfe/ojuflPTcsS1gm212S5QuIuMOAd6L9Arqkhb4KOaaY41ClfW
	 9T/6ZFHPB+JJghXpcHRvq2FPWxDCEHAknOlE9nz3GXf/Gv3AAK0kUdNxCrMTGx4jviYmp
	 TBf4yht+vK42IULDFY1YJ7y3mis65E6psKjTwk6rs2ntd1rBnytQxkCOxcs1byCOqq35k
	 aJX1QktXD2urmn5c89J1egCLarXEhm/1y71dTGjCyiEGy7ytz0Z05F8lAvLM0fY3rguJd
	 5L7tip+qIJLTQLXwmcRD0NRt4xTiGtCxqTGjp88HJLLyj5dasn8Wu2kFLfOfDvPdOPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VUpo2syO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196A606D815
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 01:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VUpo2syO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47541F00A02;
	Thu,  5 Nov 2026 01:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793843681;
	bh=l/vAaZ+djoPRECUQkyrpwQsI/+lHyaWHKOVGiTvqLdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VUpo2syOdJlu6yGIZggUY1vgdhhEVdF4DSwQqrQK2a/nOTxNxm35G+cxLqPrI6PKB
	 MFQTQ4xux0UFpN8SwVcoZuMypHTh3NX7vXO6S/9IzHup7eJOIV4UTIsG3zxXhxxz8Z
	 yaG25nXSlzj/fhNHot3cw0eUX707fgR5ve8bwVQLpeKntOShjpjA/OeNUG7CkUTAsd
	 YYOC8sdIS98lXTgAgYnSGusyKsk5EXVHr6O4JzSUjZJwNYIDAMs9ukT4XXuAssNyd4
	 YRno/lmaAmZwVZ9rR0RjWL2DdwbdR9ndYEHUfoK+9LwlxchPyvuXmBSaDc9fEeX7WD
	 KJATObk5VMFqg==
Message-ID: <sashiko-outbox-198423@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 7/7] selftests/vsock: test the netns assign
 privilege checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103-vsock-guest-ns-v5-7-48179b9b66b8@meta.com>
References: <20261103-vsock-guest-ns-v5-0-48179b9b66b8@meta.com>
 <20261103-vsock-guest-ns-v5-7-48179b9b66b8@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 01:54:41 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-vsock-gues=
t-ns-v5-0-48179b9b66b8@meta.com?part=3D7

