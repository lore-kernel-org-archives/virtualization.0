Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157547;
	b=EIDrRUYX9LsTXv609y50TUaZ4QkK0jcQlDb0SYfxfo9WylUdmExhosCc/jfOsF4To1h0
	 4vWjzB9vv837I+XyCCaZeVBv3aKtBeKUSF6IO6FuI59RZiWYvUlNnJIjOq36uEN3sip4u
	 /2EOBda9EdmSyQ5y8XyqIsEDQOkXyvi0QaZAKocjb24rLU2QIy1FPdCZGxi6GPxxSeu/v
	 CwNsOPD175Eu45vc/5Xu+2NRE70ukAB89jafRHZ17i1SQwI0Q8yekfFNm+ua0RYAIUJki
	 /5jzcBRYzBPuGpn53MoEDsOppTmhGnI8ax1yfF0WTiDjEShZ4Cr0mm37KXW7C01/qXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157547;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xdMG4zQTSjW5C4GmglZj3VWpLN8ANR2Ijau/ORA4hs4=;
	b=OzWSyIlT2+VbTEASeNrnIrdE2uj9CajK2NuyuEJgUNbYROH/IQ9aXFOARZrrnP3OfkND
	 AeA4hRpG0R/a2z/6lIIAq8j4CEv+NW2Naslm9jt3eG8mmtRMfuLshJ0vBvI65wl+nM7JF
	 clp7qpLP/2wrva/lrV7rOIctHFuaueG6OhdmzOT7DK35oC8J3KuZazpRG25Pxao65Arws
	 naawo9CxS72zj/hPWPFxsAUUiPBEZ4UlDjD0fSNJCbXo0jO6+Hm94y6ldFlURYxIDHSXg
	 76P/Js6hbRoQttSLPvLZMPKa/GfVQtDYZmvD0ECUD24L8FpXMO9ij06h0IM4KjknVjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXWS1ic+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587A1606A31F
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXWS1ic+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075BC1F01828;
	Wed, 28 Oct 2026 03:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157547;
	bh=xdMG4zQTSjW5C4GmglZj3VWpLN8ANR2Ijau/ORA4hs4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PXWS1ic+w99WDhkNCZBy6oKtlm7dD36vdS/EmEixsVlPPKqJzFAsmHNzMMnuVUdPz
	 Wdm10ngPPTbCXmPq6eRMwV2p2DZAW5nDTkhuT32XN/uSCWgZ6GlrQulZweFjXACNbG
	 RluW8QdyOfZVRVkuUzfURDdYORYcfqAxqk+wDLht5LgItPMOciykl0XJ6yZxS9i6Au
	 XlJ35O3iYOnjZCnz3N9HqU7axHLutu/8QpSDbNjQItlx5wYVbyvYCANoCfpLf25qLZ
	 /vSJqxv6jhoDNxBCz+VZ8EbiOYUb+fsK1XavNAVC9T8Tc29aUaBg1dUjzEuqYuoJNI
	 ZLlwW/3yhR2bQ==
Message-ID: <sashiko-outbox-187414@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 03/14] ALSA: virtio: Retain queued messages through
 device reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028025317.92450-4-mynameisjune111@gmail.com>
References: <20261028025317.92450-1-mynameisjune111@gmail.com>
 <20261028025317.92450-4-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:19:06 +0000
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
> Fixes: 9d45e514da88 ("ALSA: virtio: handling control messages")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028025317.9245=
0-1-mynameisjune111@gmail.com?part=3D3

