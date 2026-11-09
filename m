Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794201937;
	b=XykZ8hmpapClJ56nApjXbKd4zIiZ6Ql+Ss+OGrr2Rn0o6n69lZc+FZFmGZOoV9rmVsCn
	 5occJbBbm3ZSDr1vtlJQuD3Po+S5GoX/iC8HJUHkL+IWKbkC5i2h2dG86aUJPchgwBagR
	 otiXQ1iKHkcNXQG7+GgQQjy9BTebTxTd+GOyauDev2pNfyp4OjlQAnSOw4FDQZhMtysEJ
	 YRhWHM/h0lKidGxAXOQaioyJ5+a1X+K9b7yH7sH6TNhqTaSTAlfOCSYFhucwMKocqF/hL
	 dZFbmrUjZkp4bHyW9eXQ7AY7hLtCAIT0Dd23gfs9SafwjJOojGJO9lnoKY12xoZ8iKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201937;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=68NZ1/exFlsFcIBIDxMRsHsph16pNQBOOY8Ytw1EFA0=;
	b=rqTm3yyNHVKyIFHu/FAMUiwyXX8lNXlmNfboOJFZHYtoPtHc78v+Ull3sdaZIHVPbZdF
	 0T4hHRb60NQ2GA1WJCmeVBKP+AldVaRQ7JQbRZlU9HJshWRHJA8GGTrOZWjIBCdc7kbdG
	 C0R6fCw65s845pj2TT/kcNRs136GRIzikDsWkiTZwfq7w2WT+/ddxId5Tn6ZkRRk+v0cG
	 ULnwqVGnQrGlrIoKmahHwedhdCVuGRbKKDK49rNN4wYQWwYIZjrifckLzrAzISCbV1EwA
	 fOl+dZ92lRF+rRxn03SJ4O6wiCY6FJ+nqjjINxIoVlQtnNwxgK/Ler8oW3UZA+eVeSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXu+Ksj9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F650606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 05:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXu+Ksj9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CB91F0089F;
	Mon,  9 Nov 2026 05:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794201936;
	bh=68NZ1/exFlsFcIBIDxMRsHsph16pNQBOOY8Ytw1EFA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WXu+Ksj9GL09MldySm0OVAZMAr70d8ew3biaOxf0RucXo1GvAJZAba5Ah2Fxl0kbz
	 bTsgTaOIlAvacowLNvZcaBsQKX6x2EBSmH0SYlShXAcLiaLbnupvU1quyX7FgUv1UL
	 +HafVprRDZrHAusYRw/3ceqnrnRIF8edRUtnsson0x0/rhUYIHB2YnAwfiztGylLg9
	 VJaK1ReOyV9c7xTs9A7bcbhbYPuGlBxknbBUfjMKguA4Yt5eVTVYoGSBgElDCqY3Xm
	 MwqqYodZ0/dEK8Exyl/Ko/madjckgt8S0ufC+5/6ErlonOsW8lZ4U7P5vbI0jSjcrL
	 Z3AIYYFCEJkaA==
Message-ID: <sashiko-outbox-204434@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 03/13] ALSA: pcm: add an optional reset operation
 under the stream lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261109051618.22506-4-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261109051618.22506-1-mynameisjune111@gmail.com>
 <20261109051618.22506-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 05:25:36 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109051618.2250=
6-1-mynameisjune111@gmail.com?part=3D3

