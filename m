Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553883;
	b=DDIul5SD0Y356yVgzP2A7Oglnz7bgl7zBD7sx1SdTRDvDdrxO62kGN44YvmWaUnpGW14
	 hzW1URAe00KTAvY0Gej5miZDnPvJrRoftm1PIHlajcfTciVrGCLZY3IWTNs3XyUWxjDRE
	 caMsM1ixaUcGSZ7BPlV6zJTTtChYalTgzmKOuzZUQHLZqsRqUeQdodl+mK48sKnwFImpX
	 WpRyHKVD9uHCCIyuwfIFw9xdL9eLfhqXNLaY1qQg1ZKoHxNUCiAVC6Vq0NKqzFh7Zx1Mz
	 pAHsQGnNPvvaCv3IFLwjdkkQm9nCWmnwNQCba6wgzB2xNkMqEgcyIBLnVrXAlaX5JrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553883;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=whM3FOgjO+EC3p2yXYT0ZEAhIjSplcP5ySoYr2i+rac=;
	b=PJmtEalUCtiAMZ6c/mp6J4oAJaKtx/CX6TSbUk6J94862K3hmpdG3llHTlDeEGJy1HFy
	 ptoTqB1ijUQfkaOgPQGDSVBKRyE1YLJuRvJtxHkT7YBlcZsLUvl56EqVv8S/+cha/FUWb
	 fPu0mIxt+ZeC9Aztofkul08ebiwTzscNeqVrksyjLaeeYGJwVEY+AAOSL64WT42I/mqtf
	 vLfU8zb3aare+gSvDVDaAshHLYISUXr7gUY+oYKDI5YBnC9wKmIHJgf8mPaOyY/oX9vs0
	 NCopzJm4RaBJzngbXQ4tMg0qrjIweEl6+1jCzre7fcn9CIUqvUd53BWn3OSYTVftT/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtZqwj9I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48769606A31C
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 07:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EtZqwj9I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35AB1F000C4;
	Fri, 13 Nov 2026 07:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794553883;
	bh=whM3FOgjO+EC3p2yXYT0ZEAhIjSplcP5ySoYr2i+rac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EtZqwj9IM7lvF+mOIElr8Za2khpk7aBrrQ9OaOSRyA4tsQ3afdkCEHhlqWrB7P2U9
	 wwROxbcRH+s+o0bmsteoypGuiVTd2bUsNBUl3vS47MDqb0Nj95plK7LsL/VEi/eeyM
	 9YmXYJUkKPr1wYHSguJmDhSlPzkkpy8+Af5bndxLugU6GLVmh/SoDKiHnV/+JOtuEY
	 MK2/1zsWjRKVA9T/zXOB4ARimvH9fLO10JaMiKRgjyUH5PiLmg9kcQg4+1ADx9CE6B
	 ouwUrlkwy1BRLOg2K4U0aPFYUHYXQc4clKm5PwTuL6tLHCRgNFRWbdx4Em8y3igbmk
	 KkNpXZ2tulUJw==
Message-ID: <sashiko-outbox-212326@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v32 09/20] ALSA: virtio: bound PCM transfers and retain
 DMA buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-fix-virtio-snd-recovery-final-v32-9-4e95979e312c@gmail.com>
References: <20261113-fix-virtio-snd-recovery-final-v32-0-4e95979e312c@gmail.com>
 <20261113-fix-virtio-snd-recovery-final-v32-9-4e95979e312c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 07:11:22 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-fix-virtio=
-snd-recovery-final-v32-0-4e95979e312c@gmail.com?part=3D9

