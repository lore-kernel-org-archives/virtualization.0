Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157386;
	b=kqGWMnQrfvvRhG6D9YmtdmHu1hFMwRnoo7/qHEkl3S+DOViIJgALQTRU2YjhDZwRheXL
	 fOGXHyOumSQUam9C//w7HJ3j5d/dbEIHmrGLGQM174O/kcejwf5LdrftJJkS4oR4rb8ht
	 tFsU1QD7VpeA0RvQ+VSXTSW2PNVv+SsDYPTm3YbHS9pB3jSVMgBFIsBaSFEZFKT48B/5z
	 do1cbnLymGckcA5Ns4htoB5xjZq6Qjg7LhmDyon/nLV0i7n7snjUPrpTXniYXVLdHYNMy
	 aeYONKWMmadnYFdwTwXaa4HTv8yNxIxTwy35gUwsjJ2UZQuCzV6uBGlJb64Rt+1fzlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157386;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Y4p1rYwQQcqSOcirkQiDoBVeSj01dmDU7tWNkFDlPQ4=;
	b=wwqxaEU/+aDzyTR2wLsNhFS79Y7OXZX4ZIhh23O4lwpl7unQIskOXDeBMVowv8RAB/WX
	 yZN+VrzAwxknybqcQRy+DKywfl3Z3BnrHzRZjle05imTPYdUwlvAt2RttIDQMVRtsvRQm
	 VPDsZP5lAffgjh0W2NnHsngISlYHi22syLRQ+87e05tJ6acfNNEp3mHdh9nTeTlR4wbo9
	 ntxF1AybBgmObftFbgUqB7x3mHZI680SarZ3nUJPpXCgRQhx//C6dCapxiM3ZGY6IjBcy
	 j0xjF6m9rpr5o1vJH+/srGmVenzJ31I8i6WkEWBCxPjkcfR5RjnJ4//TiYEY0HnZhcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aa/KbcVF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6506E606A31A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 03:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aa/KbcVF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D7E1F01829;
	Wed, 28 Oct 2026 03:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157386;
	bh=Y4p1rYwQQcqSOcirkQiDoBVeSj01dmDU7tWNkFDlPQ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aa/KbcVFZEcVkSXZyZVi0E23p3a+ceDOT4XKT51meDD93B2gePiNrNmRlDb+loqsg
	 kDN/ZCdKdykeNN8J9TXXEYBuo1Fi3rMGK3gcK/qLc4a6FhYcjAtKMkAq+JBofAPhla
	 PAus1PEcyU1ffy9vVVxYWB/C/wog+CMaFIbeXRG8D2UNpY+fIgBVBXqqX3O6su1FV+
	 wQToX5l+X9ku0AKMQlCrDN8I8TnvpVRTWTJ7F370hmPJ6QebhAQg+LYg0TJnyXfrOw
	 qxCfQcli3p8P6tIAeL1uts4PdsdYkK3xItduTsEnG4uUT4Rk4lXKJN7L7cpSaxL2uH
	 3erbH3K+nFBzg==
Message-ID: <sashiko-outbox-187407@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/14] ALSA: virtio-snd: fix dsnoop capture with
 staged buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028025317.92450-12-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
 <20261028025317.92450-12-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:16:25 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> dsnoop runs its hardware slave with stop_threshold =3D=3D boundary and can
> consume the mmap capture ring without advancing the hardware application
> pointer. Staged capture currently treats every stream as a bounded
> consumer: capture_ready grows until the completion capacity check fails.
>=20
> With a 48 kHz mono slave, 960-frame periods and a 7680-frame buffer, the
> baseline dsnoop reproduction stops after 6720 frames with -EPIPE and a
> ring_capacity rejection. Direct capture continues to work.
>=20
> Cache the prepared boundary and recognize the free-running policy under
> the substream lock. Keep RX requests supplied in that mode, while retaini=
ng
> payload, frame alignment, counter and pointer-window checks. Sample the
> policy once per completion so validation, copying and refill agree.
> Refresh it separately in the ACK accounting and refill critical sections.
>=20
> [ ... ]
> regression also pass with KASAN and lockdep. No new physical-device or
> KCSAN results are claimed for this revision.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028025317.9245=
0-1-mynameisjune111@gmail.com?part=3D11

