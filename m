Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184448;
	b=dU2xVyy9uWVKRrY1dQh8Ynjyc3QduqtP22uXX9Fr3VQFaCLk35nF0GSbnJLEw5zDX+8a
	 NqgIagsMJ8DyXVrO/lmqtXmBpCVJz6mNwOZ7wIYqvmfXxINNlhxnWSw/+MEtNwYJLTL1O
	 vCCugWcbTLMdKNOS0StNAs1IrM/LzBl3HjdLbFCrY4/nLdDVQR1pBZWU5J2bZ1+1zSQSE
	 hcf/pBrLhQjG6BWuvLgXl0GLQi6dcfRV/FXkcV9CHTtK9oLRlUl2KLcuJXNLIOEgGOk4x
	 rPXsOTm4dbJjNFJ5DvcBjStUYN17P7myORpVbf8K5Nw/hpIZm6W2fG6pfVYVLseYTBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184448;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FuhgV2WYgIQGCaMIia7Ac6oQ454Rrg37ZS8PR3FA1Gg=;
	b=QHHXnoCPpNb3F2PaaEpmYG//dtjhaF9K369MFZUuQTQzBGlG3ztO02iRsIXzF+D48tix
	 jEeS6G2mKHiODtN7fXGRbBs61Hq75DJJ2U8iBviJbryFnGwCMhj8ARJpcRzDGxMhILtwz
	 FhJ+S8BfQcB6J5Sghx37Q4n7Qc7GpvVW1PlEr6yvF7TX+B8xvWwSrwrCH2qKf8FXCsggl
	 pxckJP8RwAwaF3zHPnrWf5OeNA/JWxQZX0oTmiBsWlgA1BqGskn1I+wQbsHRn4jJNIqbe
	 J0f23VZQFC+LSXzrYg2ABD9ci5v2LKW00BAnO8ru5QNrckm8NsgUBkKWLyPQhUt2x5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNeXiqjB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66876606A337
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 00:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WNeXiqjB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4CF1F0089F;
	Mon,  9 Nov 2026 00:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184447;
	bh=FuhgV2WYgIQGCaMIia7Ac6oQ454Rrg37ZS8PR3FA1Gg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WNeXiqjBcbdMCqmbRbIr4unti+acGrf8jO5j/ARKzaELdBwScizaoj4KupEIPV3yC
	 s7u0hvNOcAf+ZCkamLmiPMFkfQgIup1D+HCvXQWoPcPgBaKyKLMsyKsV38+zY+p8Sy
	 NkF6tUJK273TeP2yUf+3xwfqgPZKQvLuqxIdQFIGv3BG98V1GiguEZcU2wTadLMv8u
	 43hjIs+0yRl0ZRR/w1lpStKgIb8bqVI29QipNPaHo76ZIyCzDznsjX+nNN+vdAB7qU
	 plp2v3FZWUoK8Fr+38O9856M36UJzFVftJshYNpnFQV1TLAizEbVloORax8fQJDA9g
	 XObj69Jgs9SoA==
Message-ID: <sashiko-outbox-204216@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 10/12] ALSA: virtio: gate starts during PCM prepare
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261108235457.12688-11-mynameisjune111@gmail.com>
References: <20261108235457.12688-1-mynameisjune111@gmail.com>
 <20261108235457.12688-11-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:34:07 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Use request-owned RX storage and separate produced, observed and
> consumed positions for shared capture clients. Serialize lifecycle
> operations with lifecycle_lock and ACK accounting with the PCM stream
> lock.
>=20
> Close ACK admission before any sleeping teardown and keep prepare's gate
> through the core pointer reset. Reject unavailable epochs with -EBADFD.
> Real transfer XRUNs arm stop_operating in ACK and pause/restart
> triggers, so DROP and prepare retire the remaining device state.
>=20
> Track RELEASE completion and rearm release_required immediately after a
> successful resume PREPARE. Publish the resumed prepared state before RX
> submission because a device can complete RX before the START response.
> Record suspend state even when the stopped stream has no queued
> messages.
> [ ... ]
>=20
> Restore full-ring occupancy after active RESET requeues discarded RX requ=
ests, including native paused RESET. Keep linked XRUNs latched while PAUSED=
; publish them after successful resume so the ordinary pointer path stops t=
he running group.
>=20
> Reject START and PAUSE_RELEASE while a PCM stream is preparing, before de=
ferred XRUN handling. Repeat the admission check at the native queue and pa=
use/restart helper entry points. In sync_stop(), treat stopped as pending t=
eardown: RELEASE can drain device ownership while the core still needs the =
stop_operating marker for later inactive teardown.
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108235457.1268=
8-1-mynameisjune111@gmail.com?part=3D10

