Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743272;
	b=fiy13Z9EZbxfw0HrNm7QFXvnAw/M+HHJSJ1lxd81dT61Eh5ORQzjLg+RHjkRJ6jEh8iL
	 hCRuzJThHLqHm2G82HAJDFryf7ZMzxtXUicYT5OwuhEyCqwSJW2PuofvPSObL4hfRxGqb
	 3QuSlmWgabP6h2UEpugHz+2WT0MKMrWG04gD+eSPZP+u/+2Oug1k87BgF74lmFYBJtnPb
	 1LFi2ECYZNYz9/a+1OsTnqttCAzuf2sHvfhM4e4/8cbyZKpk3bjM/HKiMez/pg7tlLDbW
	 8zFSaL8t4I+67zswSLLjzHD5POcBxj7K2HeNaLENQjBiFbKdG5Ny4IJzA/HZb9rpqkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743272;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UzMhM4GspVOap0gDuGvm+7UHIT6uKoemHjBTsIz6nK0=;
	b=AEHeqNstVRMjB7fwcOn1VrHRpharuH3rvfC7hgXADVRLcbrQDERJMNSwb09D5DtkAtVx
	 d2c0qV28PE8xZXX8zA3k02mmBiPIjvuBzA4+PGwBWN7Hyl2vxPukV8X8WilOBcpmhpOwh
	 wCNn1/IrcYiuqLKs22o1tsVNt5M7lJzC6lo3aDjvwd9OEVdrN9asrA8J227WJuRrTVzAI
	 6H/Rza8bxoixc/NdgIwgbjfdkRqazFLJrI04LCr9Hmzj0MaaWyd2d25ZbW98NjURwzkyj
	 eepGlZmgXTolyT7WpXXxHeAXXTgHRVsfKzDGUXI0Yeq7Cc82xpFaaUdLUHWnhiJXhyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2+rirnX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5449C606A31A
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j2+rirnX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B393D1F01825;
	Fri, 23 Oct 2026 08:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792743272;
	bh=UzMhM4GspVOap0gDuGvm+7UHIT6uKoemHjBTsIz6nK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j2+rirnXXFt83aXBtx8/0xwfQP+G0RobKsFhCAkjo3m3lQBxNMfAJNkNxFLgjkIDS
	 2P0mjOgdZOpbQSBWYpAHhYe8jZBw3ucYyMuTKEEbH/nd2SdJXSmBg8p7LZsKPtuuvi
	 sDXVf9BWU+9fGRnLPwHVC55CMNLLkK0XpSnENt/gDfNS+qCqr9Bym0et+Nt/UoQ6jD
	 kmepepvfdKqC0dvP0gSCP2BNzCZcxy/e5GEcoyApUobOEbFQKD2yKclNFB8HsnTB4s
	 Ldci8/20nyxhR13ULcJJv4jiIJMEKCa9wogPO+e0kEivZxUUN7757dOSh0ARytiQJg
	 hmzOOPn2CjVfw==
Message-ID: <sashiko-outbox-182492@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 4/5] vsock/virtio: coalesce native RX
 write-space notifications
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261023075140.9613-5-physicalmtea@gmail.com>
References: <20261023075140.9613-1-physicalmtea@gmail.com>
 <20261023075140.9613-5-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 08:14:31 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Each received packet can update peer credit and call sk_write_space(). A
> writer cannot consume that credit while the virtio RX worker retains the
> socket lock, so repeated native write-space notifications in one RX batch
> are unnecessary.
>=20
> This patch coalesces write-space notifications on the native AF_VSOCK pat=
h;
> data-ready remains per-packet here.
>=20
> The batching patch establishes batch ownership before its first packet.
> This lets this patch record a pending notification for that packet and
> flush it even if the packet immediately ends the batch. Deliver it while
> holding the socket lock to preserve the callback context of the existing
> receive path. A following patch changes that timing together with
> data-ready handling.
>=20
> Capture the native write-space callback before socket publication and
> access it through AF_VSOCK helpers. Sockmap can change the protocol,
> write-space callback, and psock marker without the socket lock. Serialize
> each batch eligibility check with sk_callback_lock; if a packet boundary
> observes a replacement, finish the batch and use the regular per-packet
> path.
>=20
> Packets admitted on the native path use the saved native callback at batch
> finish. Reloading a current sockmap callback would not synchronize its
> invocation with teardown; a wrapper seen before teardown need not forward
> the native wakeup after its psock is gone.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023075140.9613=
-1-physicalmtea@gmail.com?part=3D4

