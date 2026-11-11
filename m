Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794375252;
	b=eepJg65kZbGN5y9z1RkLJkEvencp7LeHf6pmrDXa4d/+vljwJBe713W4aY1EgZ5JalKo
	 gC+/5+mAuDaxZgC+E0U1oLK8ZBpJfGscCcqiz+xHu16RbQSyPBQU0+pTdJFa4zCSC0DH+
	 EVwFBnXH/+ZVzcURjf2edLPhWDg/C5T4Ql3fA1MFy3ScDoZcgK2Bu6AC/h4BZXPTYYSSw
	 lrMVncOee2LwcB6dXc6Vv+YsATTYoFQYXW0DESUaLLkDxJFxd9yYj6j7x8lIWCzq6nlq2
	 Dz+sUKRE6uUsbAICPcPcgfSxczAGr26xHgK+no4ceH0HGiVaM8Jh9Ut6nIrOUYa9aaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794375252;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4cg36Tcz38ZnUQxwcdlGiAH4ZKIFW2iggF4VrKk6MII=;
	b=r6TXM8BkUoveFUK5v37jF5vPRXmK3jAqYdojXSh9zg7y6ajiLfIgJHbRToHQa4sLgFFF
	 +KUJ+jQMV/RtILKlpV4CXgrvETM47xql3mV/2XbotSLkHHyhJZkWk/ntcFj7FSGiwR8jl
	 TPpUNlpsETEFRknxaPhz1JXjvj0d7YtPpiKitoVz5KJ2cQcuzvwvmcanZHqdkUn3ujNRN
	 AYIu5oD0Q99/KyWMvXm+wmvNKSMQJBI65F7KLPrDFgVCnnOIWCsh/8kSBxbmxZPI7cNWI
	 B8KyQosFWaKaE/JmVyR8NqzpXPmyNOQRWADgaSgJ2EOc4LykrUBurQl05V2+/4GHE3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yclrlaj5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B16606A31C;
	Wed, 11 Nov 2026 05:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yclrlaj5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2552A1F0089F;
	Wed, 11 Nov 2026 05:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794375252;
	bh=4cg36Tcz38ZnUQxwcdlGiAH4ZKIFW2iggF4VrKk6MII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yclrlaj5Y60pC0vNuMjTVjlAtHgBmbGJSDwXbTrIeAAB3Ku8vtHDN+NGAwtIL/NC3
	 WGouuz/WMuIPV286MaWw2hlDfFdzxy+KtcjG5E6VAGjn+Mb/h0j/Z+P+RiyWYIbcQ/
	 NBSxa2ZmpILYHrqEGxQVdpVpBu/Itoo0PujnDIjN3i8TWyUNu2A6kOj22X8WCykEyd
	 hLpED0buQtMLTbzD7jwXoNYI2lvZtpT52smy4VKz4pGRxRF64ronjr4c8890yVw1sW
	 YUwNs1qkHOf4LOY0QNaZ7wumzLa6bZRHUe7aaNXv6GaxsriOStmoD4JM4owt3K+RXI
	 xOKENfsfvRwTw==
Message-ID: <sashiko-outbox-208354@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 09/16] ALSA: virtio: bound PCM transfers and retain
 DMA buffers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>, linux-sound@vger.kernel.org
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261111025655.63951-10-mynameisjune111@gmail.com>
References: <20261111025655.63951-1-mynameisjune111@gmail.com>
 <20261111025655.63951-10-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 05:34:11 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] ALSA: virtio: missing Fixes trailer for PCM DMA page retention
  and bounds fix
--

commit 119548f8da39346df59cd856937f2c76e6900cb9
Author: Joonho Lee <mynameisjune111@gmail.com>

> ALSA: virtio: bound PCM transfers and retain DMA buffers
>
> Validate ACK geometry, conversion bounds and queued-byte accounting
> before submitting transfers. Retain the backing DMA pages until message
> retirement. Check RX status and upper payload bounds while accepting
> bounded short responses, including at STOP and PAUSE. Preserve the
> legacy RX completion and ACK policy until the request-owned conversion,
> including the legacy handling of empty PAUSE returns. The fixed-offset
> layout still has short-response data gaps; request-owned capture and its
> queue/accounting contract arrive together in patch 12. Non-MMU copies
> use only the validated returned payload length.
>
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

[Severity: Low]
This fixes DMA page lifetime and transfer bounds handling in
virtsnd_pcm_msg_alloc() and virtsnd_pcm_msg_complete().  Should this
include:

  Fixes: f40a28679e0b ("ALSA: virtio: handling control and I/O messages for=
 the PCM device")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111025655.6395=
1-1-mynameisjune111@gmail.com?part=3D9
