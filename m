Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794942472;
	b=U5fZVmykEbojjEJg16fVif2m9GPR8n3e9WeVWtiWWwpgoSuuSYECAkOVPxrAe3pWGo7l
	 tKl+TTLzbu7x4/Hawxb8MNFodrX8PcFZ9vPTGfVs3EVqiWL3KnbPTnYfpnuqpuUZx7/+t
	 swEKeU5hssZ4Z1rVLwi7bDWW0SYtsmi4So+s9B39BsPiRfZ/d5TIcZHMYKZP3xZErSLyP
	 GsZToMAIA/1fm2zJrdWKb+erxtXITbJieTnyfMuk4q3B9uinFrt6tnYknBIp6fBlaf6QO
	 x05nzPwpLOVd+BVX1hnuhw1QWTxdBEWiw7xj892Z8qTrfVt8wbpjbcyi1KXkO9cAmZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794942472;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8zAQ98QngNYNNOjdwl5zCxK/a6smycF13QtHaU/RfGo=;
	b=mMxngyLA6FNOklxqOw2CJ+6u68SwTbc2b5MRh4YFzL2i50Y/fadfm15GZ+RbqTZMDB4I
	 32YYTqS3EqDBxH6jSar0ulMQs0x7x6aijoH+8p9LxCBaNOoUYIWpi+k6EOu6Fc/kmWNYB
	 wO05DNrZQvVBtkkHh058jCrSEHjb+fTKaXSO3kAI15bxlpIAuwKWZ+nVA6HrAbh2sJ0Si
	 HUfb124HscHo7zMDf98WqqzEsZtanUU3dgb/YTH+pMRc9Dz8lfXFZWSUD33QgQjs2/uBa
	 RqdMl8N1K06jo9qS9oo9Y73eo3p1QmSA1rRaKf7T8FogY1g99XH6b3nAClmodylBzKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCHKkeb9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F47606A31C
	for <virtualization@lists.linux.dev>; Tue, 17 Nov 2026 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCHKkeb9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C0E1F000C4;
	Tue, 17 Nov 2026 19:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794942471;
	bh=8zAQ98QngNYNNOjdwl5zCxK/a6smycF13QtHaU/RfGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mCHKkeb9HTD8CpUxrvp1EgclCf5qEXcXaaDN3mkx9gG3HljWmgmVLj+aYxQ3lnhD3
	 3cTlAK9fd86Qkx48+QgBOv02ZiZP3DQyOOV/iwz3h0EaIEXW3e+bAu6nhXgLgUn5iz
	 XQYtAWZNIqvQ3lBBG+2tFiq/8DBvn3N9Z7rWMaNNoaxKsPL1R3tI2qxRmW1klWhXcn
	 zvsZFMWJu4BEllc2sNl3LCLZmoQDEtJE1dg590AhptuowjPDWvVKBxtgQfuBHIgGwA
	 Y2EqN7IYrXnYVrgOZFDD2S5lkbACgxH40CdrQRy4vk9sW/EjuNlLnir1MfeqlJow/v
	 CFwjX3f7ihfpA==
Message-ID: <sashiko-outbox-219439@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vsock/vmci: reject datagram binds in local network
 namespaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261117-vsock-vmci-netns-isolation-v2-1-d6f35e86416a@redhat.com>
References: <20261117-vsock-vmci-netns-isolation-v2-1-d6f35e86416a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:07:51 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> VMCI already rejects datagram sends from local network namespaces, but a
> datagram bind still creates a receive handle in VMCI's global port space.
> A VMCI sender outside the namespace can therefore deliver to the local
> socket. Its handle also prevents a global-namespace socket from binding
> the same port.
>=20
> Reject VMCI datagram binds in local namespaces. No namespace-local
> datagram transport exists, so EOPNOTSUPP reflects the available receive
> paths. Unbound datagram connect() and sendmsg() also return EOPNOTSUPP
> because both call vsock_auto_bind(). The receive callback rejects any
> local-mode socket as a defensive check.
>=20
> In a KASAN/lockdep QEMU guest, a reproducer observed cross-namespace
> delivery and the global port collision before the fix. After the fix,
> local bind returns EOPNOTSUPP, the global bind succeeds, and a global
> VMCI datagram still reaches the global socket.
>=20
> Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/sashiko-outbox-212907@kernel.org/
> Acked-by: Bobby Eshleman <bobbyeshleman@meta.com>
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-vsock-vmci=
-netns-isolation-v2-1-d6f35e86416a@redhat.com?part=3D1

