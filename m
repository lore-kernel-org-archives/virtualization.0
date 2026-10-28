Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203923;
	b=R24XezsCYFMoz2M5REAmMourClEiGcjrVFlvIOEsgTDIXchfRdGGRlABscjWartzlnye
	 8CSaNhWTjUKAXeWwka2idrw4QGyK6tGVB44w+JB03/nW0Qx5eFxHd55D2PdA355mqaz1f
	 qCXFYavaB9AVTUgCKB7+pOtqgtR9RXAtYf50AgtdPXYDda8bTRe1XMzGOcCgnJIU2/Vn8
	 9TlZeIMnUxBFbdmP12e092GKr55LbUL70lEIP1j9/1LenP7Ju5n/8VEFjSfWMMeNX6O0p
	 qMWJ3TwGJvTZ8PxpZM+vo68yqsbPe763OUmA1HgXd7URS+f5Lt2xQVFQmA4XOW9KeLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203923;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GPLY75xbvQfteqIkWugfas8ty8khlOP2EQ/uAUihMMs=;
	b=xdyI/bR7Y2zJ5wROlBi/IIjbPrAPs1118Quw1gydnpodYRdaaRYMtqt+oVBvzpA6Xuez
	 E+DQkWFLFhcaq881sYSdh52h1upbm654/3Vsj+/yTuofasUQbqkiPmhR6kXn5hOb52nRG
	 /czVawi1lf/Q1vjkW/C1AVF2MFbqd3UKOUy9yRWaN+5v1I64pzv36HoOelmj3+c9YiGcr
	 jfB7ZZP7MH0kyWgaD32LfvoisSewHqF60xSMouyIC1GyXRxbjM1HPrw+43aFn4D9nuS7m
	 AGcr6o3T1ebH4uAS6O+P/mlXTROTPMqNI47LS8oC2uxHsZ3okSIIQ26SxzHGlAvbGAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Su3ToomQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51232606A31D
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Su3ToomQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63161F01825;
	Wed, 28 Oct 2026 16:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793203923;
	bh=GPLY75xbvQfteqIkWugfas8ty8khlOP2EQ/uAUihMMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Su3ToomQndUbKaeh1Zls6s2839juscLdIuFzgnY/EZiu/CqYZvi1QDkv2J8MgUnkB
	 9fmE296AfWj5Ps4pRu873Y06zsCfabK0UBj8f05lfo3dFJCePpImsNLkNMSLCxZ19U
	 YqlUMY4oBQ0Y7k4FOSO+QFcN2hVdoksmTMQCKR/ASVzEH88p7sQvrpan5tyPzEF4Hz
	 VVonzqHPVswpGE2twKqkHrJvJvJfn2jY5NZUoUr2AA/PzVl38ciwuraGDCRYxLUSkL
	 UoRXTN+Kn3aeoh6ZRSLf3jD7x7EtQX2aYRgYWc7N6fSqJrzMzigOUygOd1zc9GSF7T
	 Cx//zMdg/O0zw==
Message-ID: <sashiko-outbox-188126@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 2/8] vsock: report datagram receive and send queue
 state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028-vsock-dgram-support-v1-2-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
 <20261028-vsock-dgram-support-v1-2-e457cf7cee78@sinrega.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 16:12:02 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Datagram receive queues hold whole messages, and transports may charge
> queued datagrams to the socket send buffer. Report the size of the
> next datagram payload for SIOCINQ under the receive-queue lock, so
> concurrent recvmsg() cannot free the skb during the query. Let
> transports override the length calculation to exclude headers such as
> VMCI's.
>=20
> Report datagram write readiness only while the send buffer has space.
> Set the asynchronous no-space flag when it is full so freeing pending
> send buffers can wake poll waiters.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-vsock-dgra=
m-support-v1-0-e457cf7cee78@sinrega.org?part=3D2

