Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484284;
	b=zX2qWwUAG2ALTUqVbwfeUVogAvBlRQbwJbz4EcUAh/dFwQRkkpm+IiEnhbKLGCuiVACX
	 967+ipfpDIIGiXMww5kfFJ4ZS2TpT+QRgZgqzsERNhQoZOnY0aUb53/6ElfKUgMQziEGD
	 L5atzrhz/pOMSKDQ4ib51Sc50PJSLKGSR7Ax8OCX90qOeUIoO7M8siHWncLAOPMc6bpIw
	 frxO6ropbXqQY+MQqkQnzwzOAzc3bCKgN3Lw40lB5t9ukbwBw4O3oNqWfFoH+MWcTlXpJ
	 vt14lnRRDSqv5mvxMIqgB2Pv2DQvWRqQU9cTeSdjhQ7l+5zPlgGVTcTmXv2xvCtt4lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484284;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8uNAHxMqL8hDgk8TqQOXoobGgWrCIpgzfB+1RT3xPB8=;
	b=apc5qf/DOtpNX7z1pQYQG+bST0bbtyQbjzfkAT2B/S559rb9pQz/tF3j6nXxxy+5Tunt
	 mIQehHoamrSwrdUoz694vdU/DT9FMyYrmBWTLYEOwrNwk/g0THyWzYOUcivdm10zCA0ar
	 2OjjpdorqU7htBgJjOVZKo7+CDWW6CjGdeZqQ018WZZGOfxOIRTQhQW1cAyqtvbF4DZEa
	 cB9CVLuQolAMo1xUIQoKfUFCsaWkS9MxUHqaINdItlB7jAhipRyPFY+ZD8wQe8GZpbujP
	 aaZXwEgwjTx7cRqIDuHqkKqbiNrTN2/YxzuVLPv4FD/rmjSwiVs81fszHVa3IORdJQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWMmctbf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B02606A31C
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 08:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWMmctbf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575161F000C4;
	Tue, 20 Oct 2026 08:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792484283;
	bh=8uNAHxMqL8hDgk8TqQOXoobGgWrCIpgzfB+1RT3xPB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bWMmctbfJENsjh8g+BXr79B3ceGGX66uGB2Mu2tQgFi6NqUZv+7XjX9FlAiMBkRtK
	 bIB/RmZpqKfLiwWqvuhm3tuLWXt6YWmEY+xI/ZdjLtsTc5CYNgGWR4vo7oYIljNdet
	 pEtxPKC5n4VWFe7hJOCRo7UebR5fUG6NwgcCCf52N/dB8s8h2mtxujI6jkdEwlPq+m
	 eFsBFonk/z25oZFn0GHJ0FLcMM4OjVSwIv2CbkzHP24ur8D23fuZ3Fkjf6q4wOl7to
	 YqilK0oP9IJcWODfFx9aEXu0lUk2LLc/wrKf12hm+RsDHT5HgQBtHTN72cd3+kpqep
	 VSRgLF2ZRsBag==
Message-ID: <sashiko-outbox-178512@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] tools/virtio: check posix_memalign() for failure
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TGlhbSBSLiBIb3dsZXR0IChHb29nbGUp?= <liam@infradead.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261020032958.1930203-3-liam@infradead.org>
References: <20261020032958.1930203-1-liam@infradead.org>
 <20261020032958.1930203-3-liam@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:18:02 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> posix_memalign() returns zero or a positive error number and does not set
> errno.  virtio_test and vhost_net_test assert that the return is not
> negative, which will always be true, and the userspace __get_free_page()
> ignores it, so a failed allocation continues without setting the pointer
>=20
> Assert a zero return in the tests, and return 0 from __get_free_page() on
> failure, as the kernel's does.
>=20
> Signed-off-by: Liam R. Howlett (Google) <liam@infradead.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020032958.1930=
203-1-liam@infradead.org?part=3D2

