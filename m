Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794058047;
	b=5h3OWOqkvIcBUg1zvnkAbtAM3m5AWPPWbUJAtiuq5YKYEwIkfUIQwtr9EJJzCv2YohCe
	 CVwW7PPBmRC5VzbkJEHzmmaqQrzgo9QO+kvkCDPGgZwSONvyRCv0KQ2Dx3niPZxdLhsH7
	 4ZUEkfr3bvpIs4h9ATMbDWHHf3zc5OCPJgpd96oj2mBfWN5D69cxxuIun4O7wMe+tfDgv
	 BlKr6uAaaIPQ+2wH548tGytgzCWHDc+yc08eAPADmZw5Fn1PubChtiNaNySP+Lgn9nkav
	 RpE6wRrB9IQ/9PSEMjj6v9llMFxusfb4g9gm0nuCsreMCwUuuIEF0VjsN4lQwo7q3ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058047;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5jIQh8ieTP4Y5kcCx2DKcP72sdIoN8qFU/X/i2Gh52c=;
	b=tUqiq+hR/cRvrGLqYWsKzv1bjFXwsj3V9jPXIh6tsdLTMIcenJRiQhfscLGFyHZokrRo
	 wrweM03ZgbORATtLlzKmAYc1HVn1FY0HCmhWtLbzRvGFi761loEC8FoPwwZmzZaZNy3lJ
	 OOA/eFr78FhTYNUtlBC5Jt6CEg7Z5W8T47LHA1k97bzsvNUqFB/eis7T2oDAkrH2n7ysb
	 eDHZ7DZ6KouPOqul3qhAyGeyZsK9MWpEjS4LQ2r0ZRhTJZXanvIaWID0jJXN5rDOeYqJ2
	 A0nREuY8IPasVMI8ii7gl3iFUE5plzrxwBg1FrHsRIWNRifT4GEBUSHPKqdfRu3vMGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SZyezU4F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FF1606A330
	for <virtualization@lists.linux.dev>; Sat,  7 Nov 2026 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SZyezU4F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588271F008A1;
	Sat,  7 Nov 2026 13:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794058046;
	bh=5jIQh8ieTP4Y5kcCx2DKcP72sdIoN8qFU/X/i2Gh52c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SZyezU4FuJiIXYia9OcV1MXvTeeZ0RFRRQU0BjmEcpcY9/JdFQMQJikHlAzc4x93a
	 45e7Pir55n0Pg/KN3WM0tY5V0RmzZ66rMI8l3dy+wP4i9k4kiWM6MyYEsBs1AVzYl+
	 f1tPGCdt/4meaC8CqC5XDXcuVznkPXJ3tH4bkcLWzk0VJ4DhMASCKDWRrR1qPVCiYx
	 mLnisJWWjUGbGx1J68/u5N38+cODkbYU1Ib76qkqxtAoalz4zLmR/Rso8ivC+qHqYx
	 td0TlQNQHSG2ECPI4g/G8cJzCa+JKQiD6Mxdls7D5N+DxO9ZgFpwQfA4zwQAgiFhVu
	 OOCaQC5HPyt1A==
Message-ID: <sashiko-outbox-202919@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] dma-buf/udmabuf: account the page array metadata to
 memcg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261106131829.3228926-3-cui.tao@linux.dev>
References: <20261106131829.3228926-1-cui.tao@linux.dev>
 <20261106131829.3228926-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 13:27:26 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> From: Tao Cui <cuitao@kylinos.cn>
>=20
> udmabuf pins the pages of a memfd and hands them out as a dma-buf.  The
> data pages keep the accounting of the memfd they were instantiated in,
> but the bookkeeping around them does not: the page pointer array and
> the pinned_folios array, both sized by the buffer page count, plus the
> transient folios array sized by the memfd folio count, are plain
> GFP_KERNEL.  A 1GB buffer costs about 4MB of uncharged SUnreclaim
> memory, and size_limit_mb defaults to INT_MAX.
>=20
> Charge the three kvmalloc allocations so the creator pays for the
> metadata it induces.  The system heap in the same subsystem already
> accounts its buffer allocation; the data pages here stay with the
> memfd.
>=20
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106131829.3228=
926-1-cui.tao@linux.dev?part=3D2

