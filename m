Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793666407;
	b=y+FBHQ/lf3In6fR5fMryqu8iBaUyd8DVi6MyiVez8GdsNImGfX7CkYiVmwhq29bKMQPw
	 kxseVqRrPTibtgvfhEzf70Kaabj8DRLCPBEVNuNscXvTfQaS+3FiA+3CqSQl58JH2nyAm
	 6+K01aH2suQ7y3l0QpvS0SYQp67zL1hjIxYPZVGNoQvT/gFzpzffIQxPQBaENeIlkpdhQ
	 aHMkfaxB+Mho35fxeU0d2tC7xjY36py0j9vXFNRKchoVKWi0/Av79CUHn2q44Bfl/mb/T
	 zjEPZrMPlgUf8lCJjT449UHwE0QiOOGKly+jGOQQEcgueQ57Txo3+V2x+Clw1OwhtDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666407;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=loMMdDP1Fp7iAVjC/xwiZnXQK2PjO0bxQycILuy3L00=;
	b=qrYfVrvKUtuwiA474rpxKcPdDUQrSEIXltCRk2AqdE1yei5AtvniioDW0HyoME0RgAqu
	 2g0k63rFMzbmvtzgGGHgA+lz0TZIZsTT64LiV0n1C71weo8fyTK/syRlX5EOr7NkHeyZn
	 PNmM678PBWZHkFP/ikecnG5z/vQs8SlW0JM5Lhz9U74dp8hkNR63vMdmp+wv3L/ji+fqG
	 HuSTfBm2cgPGH6Z3aSJAldUs2J4pWgfZKXxF6rT74qHOL5Q4qawEyMDum2StilHJ7LmiY
	 5Qgs0ybOMVr5NmIMNaII3SK/3IIVG1gUQixsrPHy/cZTTI7ZQN6O04c8+fAIPVNTJvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AT6se87J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8E6606A326
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 00:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AT6se87J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354941F000C1;
	Tue,  3 Nov 2026 00:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793666406;
	bh=loMMdDP1Fp7iAVjC/xwiZnXQK2PjO0bxQycILuy3L00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AT6se87J9XsBAEoz3W03H1PlyPvJlZwGbHu0ceS01CQuIewEDHMVyrH7fOKL1axbQ
	 Z7woPLjHFXo39x1dlNW2zbE7H2MceWWbKr2EnqyYHlChpNlYlA+FiZfCf3dklG70uq
	 KJuqwhgMPf0dXdN8N2NmToVFal3cdoCYZeR5vAuYZZjXPS8e8qT/77gEO24MmE918b
	 SRRbt0flvccO1s35eQNAA1YV9p20m/N7dNhk+0xxHVWV6pTQnl3kvrmHLNPBKClqGD
	 9KDM4c1bwhQsUOmv5pefbZXmpxpCS9YPGoVyXHx26cyzeyZSj+FcIgpZe+Xhl/5ycn
	 y25igD93Kh6HA==
Message-ID: <sashiko-outbox-194385@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 03/12] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103000403.67106-4-mynameisjune111@gmail.com>
References: <20261103000403.67106-1-mynameisjune111@gmail.com>
 <20261103000403.67106-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 00:40:05 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Keep the control queue available through snd_card_free() so close-time
> STOP and RELEASE commands can still be submitted. Block new control
> requests and mark pending messages canceled before reset, then release
> their queue references only after reset and queue deletion.
>=20
> For PCM queues, detach each remaining virtqueue buffer after the device
> has stopped DMA and retire its message without reporting a normal
> completion. Detach all queues before deleting them so outstanding DMA
> mappings are unmapped and no token remains for a late device completion.
>=20
> Clear each queue wrapper inside the same critical section that detaches
> its buffers. Check the callback's queue identity under the wrapper lock
> for PCM, control and event queues. This makes queue retirement explicit
> through teardown and restore. A forced callback test passed on both
> versions; the proposed detached-ring IRQ failure was not reproduced on
> the tested PCI transport.
>=20
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103000403.6710=
6-1-mynameisjune111@gmail.com?part=3D3

