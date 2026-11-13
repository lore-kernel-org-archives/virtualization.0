Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794560970;
	b=B3TL4OBhzP+oI9amtFLA3pTuUZYTF48ACzwFIUcruFnw3WjwyNDieq9mu85gFnCr3xX/
	 FHjpyr4f7Vm5gjPIPfYO5gsCFmZoANUz0C9QJpjogBzwxN0B0Zl+cYurwv+4FJ2N820Nc
	 AI7zkR1cNaUUJfG+Dxnpb0Ybj0P6P5H+TqxbnwUmA2Wi+4U6iYygj69Bu9rDS+HM3GwXw
	 eWRXeqM0+82YcAgMMZ4dLnv5qzkXEoCgeMg4poiUs2YRAvicNTsmYCV50BzgmVk00PRJK
	 upe3vzsCzqvGLH6SM6PQ/knmxZ2f88o+ThydbQZIbdrdd1GP5nNKN+t67k5KC6jWV8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560970;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/UXKrJ1Awaj+cwMzC37t93YZv+3XlVFRLqOinaEwR4o=;
	b=vAA28WgWLtvYO1KmiXtY2eGKdn/EP6I5GABCJqAgONrQs+ZIMrHkuPXzXHY+64mE2Gji
	 bWwAXkfPegGvQI0QCZmcK8RQ7Kg7FPOVaWyDhq/DaggHXUO04/vq0MsHosyvozU69CeNM
	 r6VO8K9kHnSq7eIVU3ANSDFNei4mlC1OPi8xxZmV0C0avdQt+3+AN77PQXMGt5/aXC7fX
	 HDqGqWLbULub9YiJCGp9uLhhSBlfkMsCs+yfaqOqKMNnx0unyx6hFZ+T+1SsMbuyWhVHi
	 nl+BuacJ1oQb6Oo6JDqWenfpY5rNDQyuEDHyYc81/dUNjL8pR0rh3XamXQbBjJlrQBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhSUw4SJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0640606A31C
	for <virtualization@lists.linux.dev>; Fri, 13 Nov 2026 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lhSUw4SJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA4F1F000C4;
	Fri, 13 Nov 2026 09:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794560970;
	bh=/UXKrJ1Awaj+cwMzC37t93YZv+3XlVFRLqOinaEwR4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lhSUw4SJqXg6TMNAP5i6bkPGfrZipHnBTvGKmQJWfnwWSNTzowQkd8R/kTnoYD4cH
	 s+Y4IDTeEo1CqmeDB9GaF4TK2YW3r4dn6f1ViPAxGwm8awz22VLM2Tf1gi4Fa9mSZt
	 vR7URLn+z5x9ynMGZZuwoczXCBdNI/Fobo0YT5fjywZD6quSEflOhpXg8i0J8SJp2t
	 ukZOcEeKXGmsSUm4fHOaKk5ImgChAkhv5n2qe7egk46Un1CdMEIfYJbBulOORmxyKc
	 F/+VB9XcIETTBvv2x5lQs/mxCbjLVMt+J3zHol6K8LYKYF6OgQVJxgumxK51R0KBzI
	 L8PifZRCsHRig==
Message-ID: <sashiko-outbox-212507@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] virtio_console: fix buffer ownership and unplug
 races in the read path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yaohan Li" <shunsheng1218@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261113084952.211929-1-shunsheng1218@gmail.com>
References: <20261113084952.211929-1-shunsheng1218@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 09:09:29 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Two readers can use the same port at once. The read path checks for
> input under inbuf_lock, but fill_readbuf() copies to userspace after the
> lock is released. A second reader can take the same buffer, and the
> input callback can prefetch the next buffer while the first one is still
> in use. This can duplicate data or change its order.
>=20
> The read path can also touch the input virtqueue after unplug_port() has
> started tearing it down.
>=20
> Let one reader claim port->inbuf while it copies. The claim is published
> under inbuf_lock; other readers wait, and the input callback does not
> prefetch until the claim is released. If the reader does not consume the
> whole buffer, the remainder goes back to port->inbuf before another
> reader can use the next one.
>=20
> [ ... ]
> returned -ENODEV, and removing one port left the other port usable.
> CONFIG_CONSOLE_POLL and real remoteproc DMA were not runtime-tested.
>=20
> Fixes: 203baab8ba319 ("virtio: console: Introduce function to hand off da=
ta from host to readers")
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113084952.2119=
29-1-shunsheng1218@gmail.com?part=3D1

