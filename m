Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386450;
	b=jVNe1QfXt6ZH6/1Gz10V0Vfph+tluEMd4+nTX4N35CHmX+FCqNxFGAOKb1Tq8k2D3SS0
	 A+eSQLqt11ZqGLV+ji0AFSXuPQGgy113ykwnN4jmZLfY4Pd12kWxktx0EY68Hn0fwLyUY
	 ApYhtZTxUhqQk5FqN0JTNRQq3KF2uHWUwYF7upSCtEWD1LCY8JamqqwSS6JY4eqCXFG18
	 Wq43+43dZjy1h0KBITboTgWkqnams8oQMnXQOEVg802RIj153jxiNpGW1HrwACji9bB7x
	 QljUemWsvxt8ML/rIwbWx4vE69fVAKGlWsxjcO0rVX4L+GsVr+l/yBKr1ZiIdtuivjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386450;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NWSvhFo0tOgPjqW/GB4d+KGAhAKP2Xv0D37BbjvI/x4=;
	b=26CHxjF2IG4RBF0o0UmzmPk7HGMwlDkdLN/ta1yRrbYG+le6JqX9n6zZRDrwwQNYqmQr
	 Rx2zECv93jOTUdsWha6MxOGt7o4xD61Rcwt8R6s66vfDOn4MRty8vbhs0hMT437CUj5WG
	 LV08i0rTRT9x+fV/Bqf+RqTV7LpGxcKlLpZu5OiHBUr3FOxdFiWzbpG9TvYkdSAjHC0Ef
	 NkiMl6tw4bAosVllB3YcnqoHk5znwYB+GGC60stfUmte3hRoSeKGgjjqbU1wVjOZE4zLR
	 adVaS4Bg3R5z2I5Oxk6JzQzbT0FvCG4x3LgA0Suh/ctiA71guRaMJNXNMA5PHvQZ+UA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjYdooBm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E4D606A320
	for <virtualization@lists.linux.dev>; Fri, 30 Oct 2026 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjYdooBm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3004D1F00A18;
	Fri, 30 Oct 2026 18:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793386450;
	bh=NWSvhFo0tOgPjqW/GB4d+KGAhAKP2Xv0D37BbjvI/x4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bjYdooBmyrYMPy68iSO1Pk7uyQWYBy0sUdGO5LKH/zMqpMJQJ8UifklCpkjvSkli/
	 E2iPw2/5mTHrEvIJNG1Lll+Oiw59HflGWekCuDksuosnDA1i93ajrsK2p9Xv4lMyqF
	 3H+vUbGeNrLcLDy/EuXIx06p/JqZO6SeTjugpu5TExOdAn1/kE5VNID3inuWbY8UTt
	 UNwXt1lgIsxsO80Xp32xVYdXkTEx528uwLjvsnb6onUdKTn6kFRNd19aAR4fVGX+/B
	 dPQ47urkNuXoHwa9GSy/En2Wphs+TftYb9hG01+clgPeCuqrJkE+bgB/5vK77b/ms9
	 RTwOflVmLXPxQ==
Message-ID: <sashiko-outbox-191419@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v7 3/5] virtio_net: parse tunnel csum_start
 little-endian
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <0817358e459a9056af2055a8e2f466c4807ac83b.1793276116.git.mst@redhat.com>
References: <cover.1793276116.git.mst@redhat.com>
 <0817358e459a9056af2055a8e2f466c4807ac83b.1793276116.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 18:54:09 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> All tunnel related virtio features are > 32, so none of this
> functionality can be enabled on legacy mixed-endian device.
>=20
> Accordingly, all tunnel header fields, csum_start included, are
> little-endian.
>=20
> The nested virtio net header import parses csum_start that way, but the
> inner transport offset is parsed with the endianness specified by the
> interface.
>=20
> If tun is misconfigured to legacy big-endian mode while the tunnel
> features are enabled, the two parses of this field disagree, and the
> value stored in skb->inner_transport_header - which is only
> bounds-checked from below - can point past the end of the packet, where
> GSO segmentation later dereferences it.
>=20
> To fix, parse the field little-endian in both places.
>=20
> Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tun=
neling.")
> Cc: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/305bcadb19f4a539a31=
8c6b87c829fbe43d0ffdb.1793276116.git.mst@redhat.com?part=3D3

