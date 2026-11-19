Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795053338;
	b=PLIUFz3vS4GWho4G0qLKTJ9YeUcztl6h0BU2dDRnq+ncD3jBMG+KnYGJJl1awQJ3IDgl
	 OCAte1r91c0q7ASv79e3/s/tTPUeRHFxKHXSlBhOLUVEYUVbfnEGAnhl+oJ5S565PzSHg
	 +sPh97RfES6OOi/ftVClfpEbwP1K9QkTPBG81R2IYEV1ONldTGTChVFhLPuO+yS4ZQDPj
	 1+CHxDxC0eGpZlp/j09GxiQlSekpzPunWMyJ2KTuQZUZKR02I2+BXijsSJ/Xml+LY5ygy
	 644dyo+mqfPbphMhJyxjnXrQZLg8DVmQoSf3LbmEFWXfWfwViO9+C4GYVVAWltlKOuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795053338;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f63d+nQc084IJfZifehklVaKlBi03Z+swVEimcyOlCc=;
	b=o35K/dgxzwguVYnNsw5RbR2qmEDHB/SmRU6++BTbVl0AtpnvBShTMk+X0KLB/BEbbcCD
	 wfbtfU+wvpGvY7Ty6KzqfYfNk37lurR+9UvHRXVa7P3VI6Kx6pOpOWAl5gbQpML1F23xT
	 MqkocJ6qSgxypn3qHLb3ph9HyV5CQkWgVeTd8Igo6Z29Jisb5BTHroT81/IXpJvgYfy8A
	 /ZNTIoLIL0V/WE1vTaazC/eIdifT5UCrd5/kNy+EhuphoIHNw8j4n3ke9jvc3cM4SEKZH
	 H3+diqicgy9QZFKDoYZGnglihptyu+/6U5HQrjhaJS7EdDlQw81n4PPEES2AC/b/X/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e8jtHoe+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A4460A2622
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 01:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e8jtHoe+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FB41F000C8;
	Thu, 19 Nov 2026 01:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795053338;
	bh=f63d+nQc084IJfZifehklVaKlBi03Z+swVEimcyOlCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e8jtHoe+uJhOcNLiO0EWYokGLdY0iuI2l0OoAqCopl8rvseMn5RQASQMI4McMlA2I
	 zZSNIJJ5Wl3V+87CBN7tWmc8+hzqSc2HjrpICVvoPil5FSTpGOx1nREV1elkgURQXL
	 qkY9Y/TAG1Qh7C9kFM1/84NIRWAIFoq30s65TkEYwrxkhPRf+e02VmoCqa/cHjHsWc
	 tUhrHXVui6keLMKzLeFmJiDQB5lM9L+GEAgW/nB3Tl5wxq2NCJ6VKKlIW2WNyUY9W0
	 9JxGQ2Rp0iZ2Ac5U+Ik3FD2nt4BIimjXb7gm/F6PzYP99bDzA/1mC1KXIxtvgCbUe2
	 Rdqep+o+d7sAw==
Message-ID: <sashiko-outbox-222312@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v7 6/7] selftests/vsock: test the guest vsock
 device network namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bobby Eshleman" <bobbyeshleman@meta.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261117-vsock-guest-ns-v7-6-7e522ea9dd9b@meta.com>
References: <20261117-vsock-guest-ns-v7-0-7e522ea9dd9b@meta.com>
 <20261117-vsock-guest-ns-v7-6-7e522ea9dd9b@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 01:55:37 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Add tests for guest vsock device namespace assignment, including ns
> destruction and the device moving between namespaces.
>=20
> The tests drive the device through ynl's cli.py and create guest
> namespaces with unshare, so they need python3, PyYAML and unshare. A
> missing one skips only these tests, not the whole script.
>=20
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-vsock-gues=
t-ns-v7-0-7e522ea9dd9b@meta.com?part=3D6

