Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449114;
	b=vjiorlhvIBesJv3zVEp9gqlSzG/BIipXC4rUFaBe4oh4j+TMk1JjBqsawuJZ/GeF0SaY
	 eJqHLgsKCkvg1HatqIZAKfxzaAVOcxYMOV+6i+FDlOT5yA0puXDiXFoskhkyt+zvwzHl2
	 bcsI2NHdSbH9HoMBrCaASytr9iAaBEyuJm6d6ENs57nhcLj94kYljNZg5DevVqcQ6h+gk
	 WKyJXf7wA7in0zxGIlRv26ow+diGkp6F8SkEOIqtx4P4pR7KHcrSLWkwFT9UIFroslyLJ
	 PXpC8QljBfOfR3W6QebFOdspSm0nU04YsgnaXWT4GNlY3JLz2WolAgGRQ0inW/g0Dwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449114;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7/3djrFRKthQjwmpaTizZZXtiKyRGSRLL8QdFGcVqyU=;
	b=gJv9AA2gu0CFF2Od+mPjgjkPOEewkj/HXOEBneG4gNMLAW7pe4JaLnR0375kJyJy3Am/
	 RwpJ+fENomDkKUAPUdPR5ttKFDWKgcN7yOp+TPb6hwdG/TnIzdW1SaPyYF9fdb6d8Da+T
	 xixmC+tNDsSHnXfRLDf/g5dVbwlK6Dv9YvF/lSsYqbudipGnY8Pdt0g7s4fXKY78BpV8O
	 36+1lEVYFr5A45bUW0yBNvis+/ZYmvR17NNBrbzvjNjmWOobuQm/Wr4wNzcUKjj8lVz5D
	 PxhsxzyE2XBL1x39Mfw1LrhzkPNfVmRsVPns4ex5HVATGtZgXYnaFFe57JNR5YYpjBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9tEC3Ew;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2275A606A321
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 02:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9tEC3Ew
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D811F00A05;
	Thu, 12 Nov 2026 02:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794449113;
	bh=7/3djrFRKthQjwmpaTizZZXtiKyRGSRLL8QdFGcVqyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W9tEC3Ew3tDS/8ZBqlM/TxWHX/vW363whHwr2jFBGKFI/L66AFEpEajKN1zojjyKZ
	 8/WZYO3lD1EYSrsH1F4PqA+kas79FoxrWqsGv3ny+wiHZ3sXxZCUqMKOfujP8NBwYZ
	 XqqgOaNHbK3NGnW6l0uZXV0/SBThgknyPWoJfUEl4/QfRsKTII9MHxtZ6G5/F4o6b6
	 4/PQn62pvzwcuSCi2OPeQUo9qHWVMt58O90uCJnr6Uy6QQMW1mIZcUK/KEQ8wd8UDI
	 P5peJLdF+Ym0dQIR7KBmCwdrgjQTxEKXTTLmMlmbvz6qZx2HlExbcCAKiGcKFOYHL+
	 +jAobS2TCdQPQ==
Message-ID: <sashiko-outbox-210149@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 06/17] ALSA: virtio: propagate playback send
 failures through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112004704.49758-7-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
 <20261112004704.49758-7-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 02:05:12 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Propagate playback submission failures through ACK and commit indirect
> accounting only after transport submission succeeds. Keep the PCM state
> and buffer-access checks synchronized with playback transfer admission.
> The existing capture ACK callback and initial queue reservation behavior
> remain together until the request-owned capture conversion in patch 12.
> That conversion introduces RX reservation, validation and refill as one
> contract.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112004704.4975=
8-1-mynameisjune111@gmail.com?part=3D6

