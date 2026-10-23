Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743270;
	b=j3UvX7euj8IXlOsDUXF9kpOcq4Pq8lw5uqk458TEh/DFOZAnrF2J9Z214sCojKl17Dlk
	 W0m5FDh7v+cr9p3QbE+Tg0Wn55HlAmTJFwF37Ex2bPMLvoDgmMZRS9KnPxutpHgBLkSft
	 mlAzmWcHmTFRtGwe0/G3pLpz3Kxffr+vmLWPXrkfe5pVSAd7LsAm0NBqeHTIsBKaBjwl+
	 jAuoiaCKvKLvYeWJUZk1mpw2nMvsXIdJTiQse9ATsbMJiY6ErfwN7R4+1nTa+XnQt+AC/
	 or6+ULpoktvdIjHdDETa9D4GshAJQRdkNrfW5qsZYIoukkxqH9IypPDeS2OhPVKXaTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743270;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5jwd4dxy4vn3uZP5S4SX8Qx54P9Cl2r1QfgRpXp8eAU=;
	b=q9JO6XpvaHdGVGU45t4/czfFiuNblot7y01HL3fb+JLn/POD5fKiUa58Uutg30Jl1/ZN
	 yamZw1O/zbPpxQwSIFdVC4kxzKOcfJUrtjlrh1D7XglejrxHrSh4DAPKHpQSm356WUt/m
	 FuciY3wOMHBbOFfxh0mzL/+JwenQcFFfQ+IAQcfxUgPJo3p7JXIbD3W9kn6dSCdsKvs2P
	 pdgf/jwTEAeiegZjZ6FHq9CsKZkmjLFfzMwMTe1Y4eS7X6R6eqQMpxWcarOW1YeQ4+3O6
	 N7BCMEdiaaH8x3/BhQGMVc/UijJiE5vOYkQoWEyel+/DBHZPDh9mzgvKZmosSQIfFxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQbOE2G6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219B606A31B
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQbOE2G6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B391F01825;
	Fri, 23 Oct 2026 08:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792743269;
	bh=5jwd4dxy4vn3uZP5S4SX8Qx54P9Cl2r1QfgRpXp8eAU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XQbOE2G6KvZZuNvPrJAFzGKeVS1OnY1XDHwIVt9W6QBjlLh0WuQnyRqwfY5YeJX05
	 /sC0uUAcOzfhZuC7a4KvegCcQu8p+ZVwKkbFLyM613/zpiKuET2mKf8zQUP10wq2mC
	 VW9cuS7ZC+yKcB3uv8ko7H7/vEdTTyJ/j2l0ZClyBxxsd6Ik3c07yGOBzMNMVMlajE
	 jnJua+V9aUR+xhrqGfFKkWHg9dPedpLpEnJ4ICZrSwtN+A7NAfE4bABU3Z7jX/XLFb
	 nvLlsSu8qSUYBrYtPOLDMyTodqd8mARrG8+lrGddBXaljVHr6NCH/ZAm3NO0WDGpIM
	 Y2E852Fmt/3Ig==
Message-ID: <sashiko-outbox-182489@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v5 1/5] vsock/virtio: split socket lookup from
 locked RX processing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Jia" <physicalmtea@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261023075140.9613-2-physicalmtea@gmail.com>
References: <20261023075140.9613-1-physicalmtea@gmail.com>
 <20261023075140.9613-2-physicalmtea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 08:14:29 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Split virtio_transport_recv_pkt() so socket lookup is separate from
> processing that occurs while holding the socket lock. This prepares the
> receive path to retain a looked-up socket across multiple packets in a
> later change.
>=20
> Keep virtio_transport_recv_pkt() on its existing per-packet locking path.
> Pass the caller-provided network namespace to the locked helper so reset
> handling retains its existing semantics. Preserve source validation and
> failure handling.
>=20
> Signed-off-by: Jia Jia <physicalmtea@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023075140.9613=
-1-physicalmtea@gmail.com?part=3D1

