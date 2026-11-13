Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552896;
	b=1xl9CUX6ZGBUZ1EhjWUe7PkOP7XXokIMj0h0tgudXRE0F9c4cHzaoapUy+TVSxTGaSXl
	 pfBAlcnGhfxMYRBbwPXhn+gJnqYK7Wnh6mmv5kJl3GOdXnQFA7N2J9vjlpC4SZL3ycqnH
	 O66QzEgMSUJEx/alEwNhm9V78/gVnhN+RVXdrjuIULzgBm5/PkhhsXeZBjz70dQdo3C9E
	 L8pQPvrhb/v7LktgQN3JQ8K7ds7/lSdrM41KuHsieCsgRbl9WalgaKQhcUwvp0o1INDEC
	 IWsfZ4bDmmY6CvCGs8t8kOX3H8HezBVROnH+t00GorcoDW05Ecb62vQ7g0l5TUyLlbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552896;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6USOyil5rTCPBPAfirmKRPQTdVgCqESrYlsleH1R86g=;
	b=Y6aevuAgl4CNqlPPJhwe9DC9rs9q0u9j149VTMWDJkJbLJmXI8XQsoxR46DsAyi2hW5+
	 +SO7LRVCLX8xn+b/uTp09w5RBNDsV1NMcW/yEymfFwdQKPT/A/mlaiSAtnQYlThcH9kdH
	 IJHv5Rvq8cZxGvMvO5P1vUqkffE5vjjBG27rjbbPhREQNQz00b7fmy0V+iR+iSzbOamTP
	 BzmhSVZMBi9nehlIb40M5T671NyELmpUqVpK2ckPB21pVGXEF5L9oppTEWvgqBSfi65NO
	 3/pLW43/fD4c2T2ey37nLr4kg35werGXqEvl5oGI3SXuLNmI6RNaqPDq1oDDGERkpDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V58ilrQI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997AE606A321
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V58ilrQI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289161F000C4;
	Fri, 13 Nov 2026 06:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794552896;
	bh=6USOyil5rTCPBPAfirmKRPQTdVgCqESrYlsleH1R86g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V58ilrQIpaQU2jful8r6cc+oXUqPOJ8OEEX1mwMSIgHwO/JKboPk1vS73SZ/nMgOT
	 eUAqG5dAvP2w9gfKA3nLEE8J1AomFRSK6vK9TFQMX8aAKlKl6Yi7UU6S3ZUxF88Sss
	 A/7VMrbTbiF60hR2AJH+w6cFjSfm0Nx3lrNI7AvyuDVFB/jEUfgcJIWzKGuuB7v1a/
	 rDHuwy4nMTFBB9TQzqiFbIsCwVUFp5+mgCqqIy0TrR/JzTUpcuqQRiSkZ1ke2ll2d3
	 IMbzZXP1AfMyxWkiTluJmbp++GpEpHXId4sg4xUAkzTYy2lGZSTe3p8X6hHjprztED
	 LV1Cnvewqxeog==
Message-ID: <sashiko-outbox-212295@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 16/20] ALSA: pcm: add an explicit application
 pointer to indirect playback transfer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-16-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-16-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 06:54:55 +0000
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
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D16

