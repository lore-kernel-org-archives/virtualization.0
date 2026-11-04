Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785884;
	b=2IrEo4pHXjYi8PH6KcLgp5StPqLEGVLHiTwhWwVOlF9rHWGlIkg9OQuh5jfxg2GoKG5e
	 spcT3NQgkAiUhgQli7r6H3oq83gVZ3a59yF8JF/gZo6yhuy9yoaI675fMPhTlF/EJ1XAL
	 mwepUssl7lIHm8sx5UHA21cghQMrw6rVFk8vyMLjsy+fFnpzVPEZImFO41/wC+f/a3/99
	 AZllzeheRTbP6qUbcRT1HYKW1PzAd8L/wlMNMf0A7pDN2VR4o+Uaf0Slswq0n8qrrWzJp
	 QISX2tWz1nWEFRSoHL65/QFgs3XsVvLEwZ2LTOxriAgNfFLXyWyIT4UlNeOg4PGk/aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785884;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u/myM5M84B2btn1nGSlPfQ9z3X3uvkSWJ7OVcUWKU7Y=;
	b=FDPZBv8Q/l6G2QzNdWZXkLB1Yt79VRJoAeQ4sRpTan3kak+J7Rvh28PKu0bBt5dTTzKS
	 u5I8meUYJXANS7erRW/2m1wbDZgI4OKbIr/1mE1P2co3xyooi5elIJh6tbt/ondzu/pDe
	 zl2xO7jSUiwtbjYXuqcuWy5RlVwHK+AUple5q4bKG6HCsthauiQ9SrTIf3QZ/m33d4zMe
	 1eThC8X9I+EaoNfXNBui+g1jtvI/laEHu18o6+aTWHqEhsE9PHNswaa9tnhJjluwASDin
	 cLYtWT5JL9St8LDqJbfP8/MPfADz8VEwA8bTOY+ZI0piN5HdvLQkpfUn9dpv/GFOhbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuPLiOqb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D143606A332
	for <virtualization@lists.linux.dev>; Wed,  4 Nov 2026 09:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuPLiOqb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2A11F00A02;
	Wed,  4 Nov 2026 09:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793785884;
	bh=u/myM5M84B2btn1nGSlPfQ9z3X3uvkSWJ7OVcUWKU7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KuPLiOqbb3xwV7pSp2iOM0qTW0hEXzhKtlA3C4JtKpVYwFMutK0hxRD9NaMtBuUcP
	 ZC6NydtCjzASn2CoGrM63pcBAJ4K2HcEIYhMfSZmxZE2vTHE8KfBarbhCrNGhxkekF
	 GgjKX807AWrVnTE+hBBtL0fDfyA2r5G7LQh9jDi0ukhqRzSzY1vYj1x3Y2QQmZGkln
	 Ypv7jI61O8R69dWWYqKW69SbfvNDgZaJ2gLKmBY+2scLw1BtRB3VMSyZgPiRymA9yY
	 uAE4hIFMtqi1X91wzhGT6AJboCDAsHnIFvkn6L0Qo130BJM/tovwRWhW9lxo+ihJIG
	 201g3pWXhTCxw==
Message-ID: <sashiko-outbox-197003@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 4/6] virtio-mem: move
 virtio_mem_sbm_try_remove_unplugged_mb()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolaos Karaolidis" <nick@karaolidis.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261103-virtio-mem-memmap-v1-4-308ae1da6240@karaolidis.com>
References: <20261103-virtio-mem-memmap-v1-0-308ae1da6240@karaolidis.com>
 <20261103-virtio-mem-memmap-v1-4-308ae1da6240@karaolidis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 09:51:23 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Move it below virtio_mem_sbm_unplug_mb(), because the next patch makes
> it call virtio_mem_sbm_unplug_sb().
>=20
> No functional change.
>=20
> Assisted-by: LLM
> Signed-off-by: Nikolaos Karaolidis <nick@karaolidis.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-virtio-mem=
-memmap-v1-0-308ae1da6240@karaolidis.com?part=3D4

