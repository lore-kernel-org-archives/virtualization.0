Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793923815;
	b=LW6Es2OK/A7nq2pDLMY6sXMAcKSGSu5N989uznk79Cd/n/XuN8QIpRPrg1rmU+WgDI5d
	 B52b4G1fGpwJjIMbcJ2Yot6hkcp20Kb1Q5gqd51X/Cth4X2onlg+xDt/oBIGGV2KV5Zxr
	 fblxbNRUpXenVjdZRNUtzdqUXancJbt0ywzENkzntEcz7ubfoO28fXEpDvC3rjrVfPKuS
	 YwAqTcpvAmgCGYpRrl518H0AG3TwXtnWpy6S+4HCglBHaSoxE/N0pZW+kRjonU4ic2lGX
	 K8XbvCXEAD17NqXtjaPDziEH4QqoeIDtFZ73ShizDYYmSS9H2d2q4cTM2xfs29HQL7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793923815;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KH5S6yP1LuJWRG/4caLiCLwAosHaasyfNSk6SyGTpho=;
	b=0QknaSn2L4Y2b7xg17pISPY/U1bJLpeHh8AuGsdgwek8ipitfmBd1awPMIOAqbp7IQJ4
	 z5Gw/xVQLTlA3liWwhQcT0xv6duCbPU7Q4B5nSZhkb6tiy//r0KybJKqaIWwUzZFW6e/W
	 m4hOLy9nLsFlI7W3qMzMG5FOXcEj+w4zS9aNPLxbK/3LNmeX7MzS+Hh5NZLpnlT2ziEI+
	 ErAbxwB5ciFIGfc8rJFfVGq1BsVYhwxLM4bAf81d/vFT2TvbtLFJdn9nox3MsTEJ7n9JW
	 +7KnWfIdUuyEeTcuaukeaifDvW3yMuVtBFusnegiw70i3tIr3soMmHoZMGLfSBn/5Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b7DQrSc6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB3B606A31B
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b7DQrSc6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A0A1F0089F;
	Fri,  6 Nov 2026 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793923815;
	bh=KH5S6yP1LuJWRG/4caLiCLwAosHaasyfNSk6SyGTpho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b7DQrSc6fEX8vxcx3/MVjoYmfDZLsvl0eUPlairWIuD4I1UVg2LyVgVYRGycT/hO0
	 ustlK4nXJXLCqjQ7KAqoBZqX6N5FwTPoWwrupoe7ODAc+4r44uu50okp/Q+ZZnOjyg
	 xYrBpumBG0pdN02we9UpAvgtJxWXoqk5AqH52S6axibOirW4hTthOobDJgf8dN65nm
	 2IjjQ77+lJWwUs3sdnB+Eo1dFrNV6fhzUuicmR4HAZFpj6sKAdkpNTW/84giRaeRuK
	 zZx3M0E1/hu6OtxCtslu0Y6R0H7KBjufayhUoyVAWL3rV1LPScUNNecBZ+O0Sk3M5J
	 r0Kiw3uZS9EsA==
Message-ID: <sashiko-outbox-200426@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 01/12] ALSA: pcm: mark stop-threshold accesses for
 capture policy sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106000644.20460-2-mynameisjune111@gmail.com>
References: <20261106000644.20460-1-mynameisjune111@gmail.com>
 <20261106000644.20460-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:10:14 +0000
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
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106000644.2046=
0-1-mynameisjune111@gmail.com?part=3D1

