Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793413788;
	b=BZrYWRsau3su9V3pJlNW5ikULcsrMjHavOVEr8PaWQ7gvGvIXPpMjCOk2gbXKA0lx7g6
	 PE601RmqVZZsgo979QBsK5TZaIb9MJnwqZM3fQmCBR81wWb4PvKpepHedlb9rADin5XWH
	 8v7X87CAuI0NKrNoIfmxK4sygfYFfUgXF91TFLC572Xj/OtPtk972L4ffjSTGpa2pbrb8
	 H2BrKeq+xJlv+On0tCvPcLaJpE4aJYyHgExnf7uzycHAJU9o1rqgx8NkLNnFNdhdNUThr
	 dT8U6PGl4OrYgo2GHvjDm8xxS7rLcFX3ZvBCCqks5n+h8V8+KvbVc7BHWIvQJ0uLQCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793413788;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nJpsXlv24gsYNBEyL9CZO0B9RAZ2pqFb/uj/OxIvmMo=;
	b=WY04ZdhcNXYBqm2loJPsIx2gFVA6lPhMOWFop60LV+kZsdFd22ZfmuDAbdyEmje8Vc/4
	 No4ErJmy9OJIUxOr9SnDxVho+L+A6AHDM3857DNBu1bKNXS/M7apFGwDYqvT9FFSXBcT+
	 UG+eWZuxBaDZS55YiOTe2MPYfy9I9LUO8Z5yHi3fyRyxJ3W8CX1oCtUBWw3qD10abZS/u
	 L5YuoapE0G/dYhnD3gkJo2ableclYqpfO0pHyyIRKQuE6MYE4xCF9oForJa6tJUFkJ9ra
	 P1vSH6VIvOIi+dKX7NlrsY7ZpaRZQIIikYrjhbjieFGSDaPm+BZIkQQtySB0BQh073A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqTPQiSu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8681606A31A
	for <virtualization@lists.linux.dev>; Sat, 31 Oct 2026 02:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqTPQiSu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1049B1F000C1;
	Sat, 31 Oct 2026 02:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793413787;
	bh=nJpsXlv24gsYNBEyL9CZO0B9RAZ2pqFb/uj/OxIvmMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gqTPQiSuRaX+Nrugv6Efo3kToEsR7qqfZqzWuroRHWiXONu/OCtAeaSGW0K4NsRFM
	 yakvskSfMnYOKU6racjPODIBZThCqXFZ/vCOvOLLk0O2NGqNNVy5eVKbyByuzzkn3p
	 yK9AnLR8ZnF+YAqJjiirGcMwXq9uxEH6fYrdq1VwtsYp7tCeLifeuuHuCsCDIKW+G1
	 Vh2tfQ+8k6Mj+P+UKFk/6Pzyz6yWftLrY0gHES6FagLA8iwTXqs598CkK+sFOEJH/P
	 smrmEaxSx5+4PhHimdunjibCGa/EoTc4tc45k1q1BfJsqjPn77YsnZr/y+Dcc7lTi9
	 xm8XPFigUBOFQ==
Message-ID: <sashiko-outbox-191707@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 01/14] ALSA: virtio: Propagate PCM send failures
 through ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joonho Lee" <mynameisjune111@gmail.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261031020855.2402-2-mynameisjune111@gmail.com>
References: <20261031020855.2402-1-mynameisjune111@gmail.com>
 <20261031020855.2402-2-mynameisjune111@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 02:29:46 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> virtsnd_pcm_msg_send() can fail while queueing a transfer. Restore the
> failed message's length and notify the device about earlier messages
> queued by the same call, so they do not remain stranded.
>=20
> Propagate that failure through the indirect PCM transfer callback instead
> of discarding it. Commit the updated indirect state only after successful
> submission and stop further transfers when a send fails. Return an XRUN
> error to ALSA so the stream can recover.
>=20
> Keep the polling feature path unchanged.
>=20
> Fixes: fe981e67568c ("ALSA: virtio: use ack callback")
> Assisted-by: LLM
> Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031020855.2402=
-1-mynameisjune111@gmail.com?part=3D1

