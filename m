Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990751;
	b=XGlR9H5FPWuvJeBYONZ5Q07/CIIiqzQG+ys6+xS2aVxW5hMYs6RUE7ByvNp0KvCPtuCC
	 AY5KiYQ+kt/69O1E1/4Fla4+jBkcrCWE9pK7A1zPsWC6denuibGBD5OteixKiKRANOHph
	 z7Xt7zc7aPA0ODptIrC7LcoKbIARwFUpYxrLdm5fNKmplgNjMdZOz68kR9k5fVu8QvjQR
	 MlozfV0oRAabtf9oSVjIxQX4yz1nwih/ddQtEpBeitXazq38FBCOBG5W9s5Qc7cz6nElo
	 wQVwdZQeQiT2ulAxIOiIGzk21edFTJts/nhkgKAOAX98/JZohiTSzlIm396fpukiwHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990751;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T8KVz4IoTBsBOUPEhHzDlIvOoODlTQfgTV7T4937Rqo=;
	b=Hqc1KSyfZOBO6rQgcsOeMCWkOsjo2RVUdTKxL/yFB6a4DkwQTR390K0hWTKZO5xPTEmK
	 2jFkRDkNGWKzRiCZyLiKEHuVr52okUzncGxGMDv83fCbBuYWJpuEChVck4DMOTkhhXmbq
	 zHgf1i88UYEoakrs/6l68svRa4WRaa1bDC95UZMMl4JRkxDySxG+8HmGsOdxQOQ3Irgcz
	 NOGz+gXjAzdr7mkoieNFj0kEOE8EKtOwwpzUSbD0ExBJrz6z8Li0FYG4nPehMXLBJNV2B
	 6TfXUEyyKqhdaHmZjbhlUPtG9w7H8bS8aC3RLtNjXar5LnA4UyejLTxkciLisxRs8DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChBw92CC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB7606A329
	for <virtualization@lists.linux.dev>; Fri,  6 Nov 2026 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChBw92CC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3991D1F0089F;
	Fri,  6 Nov 2026 18:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793990750;
	bh=T8KVz4IoTBsBOUPEhHzDlIvOoODlTQfgTV7T4937Rqo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ChBw92CC7IL+e4TCqYRGqSBwgdXCJ45tXWgLFUXzR66x15IagSId20XMJ2R5qOgIy
	 yb2QXQ2CED8DWIrAbVdBxVm5fNLrmFefHgLqIoR/JWcD1FKwDcX1dwfqIzX0WOyNDs
	 O25dlJwopRvvUWDpy6DF7HaLqixhdhoNKp3kzu/zxkzxmJt26ZwOjm0m+lbRNgwmZA
	 a4OmzSQPuUpCAS3u3ZAtDB5dWVYHI4iJ5rAR2pstIzaArIG9ijUXJcnSqUIqGIZJU5
	 Lh6YidOArUsLU4zitlBBR7ElYBrDmERoqPs631NViJUbwfBE/jBKcAPdjEQrqaT1Tg
	 hnu9ZWfEF2JJA==
Message-ID: <sashiko-outbox-202095@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 09/12] ALSA: virtio: wait through signals for PCM
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106161838.94308-10-mynameisjune111@gmail.com>
References: <20261106161838.94308-1-mynameisjune111@gmail.com>
 <20261106161838.94308-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:45:49 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> A signal can end the interruptible wait while a STOP or RELEASE request
> is still pending. A later teardown may then submit another RELEASE
> before the first request completes.
>=20
> Keep both waits non-interruptible and use the existing message timeout.
> Other control requests remain interruptible. Device reset still cancels
> the pending request and wakes the waiter.
>=20
> Keep timeout and wait results in the types returned by the kernel wait AP=
Is.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106161838.9430=
8-1-mynameisjune111@gmail.com?part=3D9

