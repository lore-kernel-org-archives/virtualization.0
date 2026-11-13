Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562563;
	b=3d2c1AXJr8DgCunywTXO1B1GhEaQNjdtZVawLjGGwD9Fpn1qQw7MRd2oWfKmi1Wf0KVW
	 Wcu4wA6895OpM3tXhdzgw+7XyvuC10bfKDRB9yqo0BVtZLYUXIwkRyaqduIdRkGe0AuN9
	 C6cYe3/5+ZYKLPFMw75tlQnX4/TwftNfXKXHIVfA2o3gnhGi0arEPbKYjxkHFKEFo3alg
	 JeBhx5GRKqqV4HRoho9kpzNQwmOhaC1CzHEg8IWVYZe25oMYWax+m1oNPRUI7UVbYhpdy
	 KXaObn4wlwh9IuVZkviluciVWvSKAAWiQfdH2TUGQVR79IgkL9GaeG5UMPZTwYp2mYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562563;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m5Jul/xD32jPaAql0U3QyYrC9eliFByC4RzTFy34VaI=;
	b=igRL7eMUL+OYWMa3EcvcXPhZe3VU9H0R+AMeF9vQQiA1NQwFucOr2Y1PJcwUruMVOKBj
	 cgzoVTw8m4Nsn7NHbEsowkyUeC59PlrQnwIHdA8sktj3bTd32HTyb26xQFKOMx1pJ3uZm
	 Kc385H89f2z80lY4Crz6ZNsmYNFDLAbZEig6tca6zBK4ceYWh1a4CN6U1uQZIK4g6HaWY
	 PQbRxEEBi/i18Zh1MvkixtbsHmiZDMq/drU8HJvy1FV2IaRSrAuIcs0f11Qok2kGnqL1i
	 aNq7QOzV0FeyjY7pFO6f+tJS5GpHNKkMxySbwgjxNnodX5rQolWLfMmRMg/uFxzSNdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZhLcwSye;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09C8606A323
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZhLcwSye
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050C81F000C4;
	Fri, 13 Nov 2026 09:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794562562;
	bh=m5Jul/xD32jPaAql0U3QyYrC9eliFByC4RzTFy34VaI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZhLcwSyesXcT2jQH9iEjCoFE7gUjAjbvoaEFUf84mo5iI8PqWuXxV3nHFDdwiXtcS
	 fDGzrBsgBYuFA5L4PppVmeTKr8GU1UdsvqkddMS5+JKDEj+YpY6U2/TS8yU1pDS19G
	 xxKqi59BO2fCKntxOgKGgkcocfW/ms7vqYhljt1N4FzEiaobzK0unG3699YrmkC9PS
	 ROYkoVeNvIvZeLKj1oBNWN7orv6VEIpAwf0z2Snc1ryBDqdzOs2/Cyb9i37h9ptDgb
	 8beWNo6PYeMAcdYjgLVbW5n25J03p4XRySU96LC3iqI5gKwdPJJ4COvey0UkPDZbo5
	 sJWDhhY/wf34A==
Message-ID: <sashiko-outbox-212555@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v33 16/18] ALSA: pcm: add an explicit application
 pointer to indirect playback transfer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v33-16-13a934ad5ece@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v33-0-13a934ad5ece@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v33-16-13a934ad5ece@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:36:01 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Joonho Lee <mynameisjune111@gmail.com>
>=20
> The indirect playback transfer helper samples runtime->control->appl_ptr
> internally. A driver that needs to refill already committed data from a
> pointer callback cannot pass the application-pointer snapshot used for
> ACK validation.
>=20
> Add snd_pcm_indirect_playback_transfer_appl_ptr() so callers can supply
> that snapshot. Keep snd_pcm_indirect_playback_transfer() as a wrapper
> that samples the runtime pointer as before, preserving existing callers.
>=20
> The explicit-pointer form lets virtio refill accepted data without
> accepting new application progress while the ALSA buffer-access gate is
> closed.
>=20
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v33-0-13a934ad5ece@gmail.com?part=3D16

