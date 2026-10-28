Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204887;
	b=UfovTJQMd32322oDh5syunkDF+JahGBRaIj4s1OZWhhvd9liQcZ2gMQgXH26VGLy6SK7
	 OHcq8n+VH+isd5xq7PBDsdwuQOjtLymewrS/k7s1Cl6zodZ+IMxGBOHCa6uwpvOKpEipH
	 XAO6SguI6GZh4UVzWRkcFoWVd3odir2jLSMhpb+vpdBX7mcmVGnEGzCm6M3fOzApJUerK
	 YVY8wUcicAK2V9wr4P5imYUeb6joPL3K9gi9+tZZszzT2ZwA9nAv7n1wTK8X0efpc4gCA
	 4h3UQ4r7c8p37qhaG0marK1zuiHbKtYi3LAWuSK+VcBS1/QyDxXHzowy2aQDHmP3tuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204887;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O5iK9J2Ubx/NpGxZl1W2zupI6bs5Kg6ySsX3Hg04T54=;
	b=CNauT9PMkh8+Z9m2CD8EtugqqA96fg55Ll3dCvZ7jh2jgb70JbvRgDwlnBebRf8AfSMJ
	 JYrrhHqovEzCsc1xU6GBdeIzrAY7eN9mJf/IVVCTMBoUk+N89KI8d959Lw8vliXJ5vPf6
	 cG1GfbCfSzN+qd7VS8mm6MrbeH1lLfuJdAtG+VKcuGLv9zjOX870fXgat0mJxqbWVGO/V
	 kugFisgoITcerJVzRKtUajb+n52UOMIKK0gpIIfQSovE6DdCpwl2WnzI8BI3Rk3eYYP8K
	 bUe4YVSdQkKVmFjF3R4A7pa6yYKBqDI8K5gCTMMpfmyzW0Z5OLG0++G0ZhvkGv80TYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=els1Bnpu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3E606A32A
	for <virtualization@lists.linux.dev>; Wed, 28 Oct 2026 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=els1Bnpu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDB11F01825;
	Wed, 28 Oct 2026 16:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793204886;
	bh=O5iK9J2Ubx/NpGxZl1W2zupI6bs5Kg6ySsX3Hg04T54=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=els1BnpuzhW0LXTepUSNEqvn1h1je6vjJE3do/iP9CYxKG5dARLYxYJ3Ord8ts86a
	 5ln5winuKsljebC/wCh8hpFCw93kodWeXmyDe11NKt21DB/RxObBORmdtDvulgyQWs
	 2nR7985Ve2dloS3PNaTkGrkAwh+GJPq3qjfBBX4JNSyRUEakpeNZJCEWQEJjE0/sok
	 0xHEy5AvhfBqEVIJjZrQKrSdixukosOsMSo2vIdjFJqFGraHOOYYykLYbqfzVLpXEG
	 0TPj7kiquhYYuLinRwrTM7Jpto/Dx+4cg5VkhEt9iNpI0lY9XfV2lJzbh3jd6pJSXV
	 F2fjIs/edkQfg==
Message-ID: <sashiko-outbox-188164@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 3/8] vsock/virtio: implement the datagram data path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261028-vsock-dgram-support-v1-3-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
 <20261028-vsock-dgram-support-v1-3-e457cf7cee78@sinrega.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 16:28:05 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Add the datagram feature bit and packet type, and implement the common
> virtio transport operations needed to bind, send, and receive
> datagrams.
>=20
> Send each message as an OP_RW packet with a maximum 64 KiB payload,
> including support for empty messages. Bound pending sends by the
> socket send buffer instead of connection-oriented peer credits. Charge
> pending payload bytes before handing the skb to the backend and
> release that charge exactly once on completion, rejection, or queued
> drops.
>=20
> Deliver incoming datagrams through the bound table without entering
> the connection state machine. Validate the transport and connected
> peer under the socket lock, including after shutdown, and silently
> discard undeliverable messages. Use the socket datagram queue for
> recvmsg(), including source addresses, peeking, and truncation
> reporting based on the payload length after socket filtering.  Reject
> MSG_OOB and MSG_ERRQUEUE before accessing the receive queue.  Reject
> datagram sockmap admission until its receive callbacks support it.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-vsock-dgra=
m-support-v1-0-e457cf7cee78@sinrega.org?part=3D3

