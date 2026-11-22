Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795353771;
	b=Zexhs+YX0kltrAvEz+VfhoObwnA2f1Wsi1KW/YMGgBKUHUth5T/OrBZdc7uV4+z2QdBY
	 GELFIWif40bvmENGr+dzMTFFUWW8zo+OSnmvVMaAAuNX84k9mLCYIQmlbmevTuBmOHZma
	 2Fp1v3JiWxuBOU05dpoUGkw78YieRN68sY/zb4BvQ/WiaISf27b+tuOKePYc9Hhxx82Lp
	 qfl8m/bwQT4IoE8Z2UKoVzda9YE+f3SDg0SPxVvgzbaEBwtYTqrCkQUs3VUubiT0llc6V
	 mePid5nTuONENJKyALwHDgv3PnXqha8CjWiIWpmMphEFs6MqJKapTOk/DS3No4yYLCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795353771;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OiY062aSVAhx0MI9oCxDKM+KOGzVsPtV1/xUgOsl104=;
	b=BovFNfEyWL3do6BWa44tQyfyN3R9fL6rFQBzro5aFh/ulErwVf/8z6+6ler7W5pN/M5u
	 19eFI83WJJwg+LKsjX0p4QzFOeNrsD/AP4yJYAF8QNB8vtCsS4fozYyD8Ml/2VllIHYzZ
	 BRLDTBIfqEcI4BLH4GTaOh3F6+TzibJbdcOf3jCAtxYdZxXwlx0wUauOcDgEe0w49UTDo
	 l4WDoh5wogqOxqftQtt0ru/OpBwhjKN5ChB5qQW5uN6k47yOiUaLiw1alulNNrzCXKuCB
	 NL0SWbzgmOnqgd7qTLM3dix77habrowDqG6K9ouHKDyN81tiBIdA97YMpalbv5Zgtew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVWoI1BB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41184606A320
	for <virtualization@lists.linux.dev>; Sun, 22 Nov 2026 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVWoI1BB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E1E1F000C6;
	Sun, 22 Nov 2026 13:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795353771;
	bh=OiY062aSVAhx0MI9oCxDKM+KOGzVsPtV1/xUgOsl104=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GVWoI1BBds/7NQ/RKXvn4WOVMnB+4iDmbAs1MWOhOG4GX2m23+pH/oM5CrKhEGAF+
	 5QWCQlTSkd6yv+el/ZLmliJO6xKgGb7SJjYJSKM6wGCKtZc+/NTjCDkyaN5WA0rjrN
	 uXikHbUBatRqi4j+GDLfTukjOJOMgDdx3jUnGzgfdyE7YnF1T+/g30iw8CzMFpLBxQ
	 +k8qzGJfeVBFnqCaEPAQmK+2eZFlb55M1Iawxh3DyxF/eVTkF+uJsqsPCJbcYfX3C/
	 5IK9OO1S6lMFPn2ev1JyM0Z1HSSuwHQtaIzVwhoHbSJOTc/j9OFZdrfh3JnqB7Bmcb
	 3dBdLJp17eBqw==
Message-ID: <sashiko-outbox-227961@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] vhost: mask the in-order used-ring log cursor
Reply-To: sashiko-reviews@lists.linux.dev
To: "YanXin Li" <fadouse@pm.me>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261122-b4-06-vhost-in-order-log-oob-v1-35efdba8fbab-v1-1-fc1253d60351@pm.me>
References: <20261122-b4-06-vhost-in-order-log-oob-v1-35efdba8fbab-v1-1-fc1253d60351@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 13:22:50 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: YanXin Li <fadouse@pm.me>
>=20
> vhost_add_used_n_in_order() plays the batch of used-ring writes back a
> second time for dirty logging.  Commit e244725e86be ("vhost: fix used
> ring index wrap in vhost_add_used_n_in_order") masked the index in the
> descriptor-publishing loop.  The dirty-logging loop introduced by
> bfcde6b64769 still uses the single-subtraction form
>=20
>     next =3D start + nheads[i];
>     if (next >=3D vq->num)
>         next -=3D vq->num;
>=20
> If the guest refills the available ring while get_rx_bufs() collects
> one mergeable-RX packet, that packet can consume more heads than
> vq->num.  get_rx_bufs() permits up to UIO_MAXIOV =3D 1024 descriptor
> [ ... ]
> UBSAN, lockdep, and DEBUG_OBJECTS.
>=20
> Fixes: bfcde6b64769 ("vhost: fix dirty logging for in-order used ring ent=
ries")
> Cc: stable@vger.kernel.org
> Signed-off-by: YanXin Li <fadouse@pm.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-b4-06-vhos=
t-in-order-log-oob-v1-35efdba8fbab-v1-1-fc1253d60351@pm.me?part=3D1
