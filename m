Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451047;
	b=c9MrhotNnWzadSiQWIdk8P04N27UgNL+JB42y13iJifDu7WkX9i4Pu4824xavcSr7Hv5
	 ql0k98mVCqVyTA2GauvMXU6zHZgWkKXEvRTdULRrRrLFRaVwxNWqEY9SHtKWaD2M6pbum
	 JgnHm0W488Lif3A5nrpURNOFKddLjGTx62tzEEC/rZzSS4z6JwpGS15dFIDouLrIy9eyW
	 GRxURNNMdX8XHgDkE0nm0xxSp/4IFWAYQVe2sM8/MQVZEfei7ELe96jXXYPWh30yobDcd
	 UOSyUXsCEUKp8rFkzjEB3hPazRI0sPS4XVvnSSBbwO2pYJAJf0eIBRbCbsNJwa4MJ+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451047;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zHVJWHKEBFMHY22XFs/vaPj8xzPYelhqB6cxVL6BqN8=;
	b=iM7K+FHoPNq7M3c2ONiIwn1wkEzi+SCqaCX0e2kbgotzbLdqyXMjkBgpQNaJ/jCZroJi
	 mR7mwhnlcpCdaR2LQk6GrLKZpeo2FjTfcfvXFqmt1pDRB4rkGvE1OT1A9nQdO6jomuAYt
	 nrEkwGSFGqdCQONrrFPaC+S9ia99s5E5B34QLsky/205RBC8hBrEqFD4QiMbo/GhPm79g
	 yWzxycLP1cdRUt7oPRUUEjZc4Lc4uyqHy9ngv0OhN4XMy+s3bFkZOf1FR2v7uhU5/e3F3
	 ySx1Jm7bql1ANZ6uWJImSaIjdEhusK0CoAuTgBuhKpVvt68QobApgOaIVAckRvKgIoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Rdla/Lw0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825F6606A31C
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rdla/Lw0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6CA1F00A05;
	Thu, 12 Nov 2026 02:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794451047;
	bh=zHVJWHKEBFMHY22XFs/vaPj8xzPYelhqB6cxVL6BqN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rdla/Lw0d+bYQ/kjdo5AopE97LWB9iVrZFIwi0bCNnCOBhC1iRuFS0CPZk9eKyIXA
	 GQG0fJ5W1GunEfNf/olfjX5BOc0UmEvJVAS1LHA7J+WOA+xyyslTAWu40GO6a7jB0U
	 /ojbm7WoDKvF4/6MSDzcUhY5BBZhSibXfUxJYc0769Ny4ADmxwDZwGWc/Xwmn4ZE02
	 R/F9idwAr8/g7wH5frix0/K5kA8dpReLQz8hJPGccE1baQnz9aBUJmSkgYl4O6RARX
	 YQ/maKbd8EqiFQFzCUrJ/VG1OZrark0KMbDkL2yvW1/goNh7jlDgazhko9UlCwoVl5
	 sFTFvY+UXS0jA==
Message-ID: <sashiko-outbox-210210@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v27 09/17] ALSA: virtio: bound PCM transfers and retain
 DMA buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261112004704.49758-10-mynameisjune111@gmail.com>
References: <20261112004704.49758-1-mynameisjune111@gmail.com>
 <20261112004704.49758-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 02:37:26 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Validate ACK geometry, conversion bounds and queued-byte accounting
> before submitting transfers. Retain the backing DMA pages until message
> retirement. Check RX status and upper payload bounds while accepting
> bounded short responses, including at STOP and PAUSE. Preserve the
> legacy RX completion and ACK policy until the request-owned conversion,
> including the legacy handling of empty PAUSE returns. The fixed-offset
> layout still has short-response data gaps; request-owned capture and its
> queue/accounting contract arrive together in patch 12. Non-MMU copies
> use only the validated returned payload length.
>=20
> Fixes: f40a28679e0b ("ALSA: virtio: handling control and I/O messages for=
 the PCM device")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112004704.4975=
8-1-mynameisjune111@gmail.com?part=3D9

