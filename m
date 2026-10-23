Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760345;
	b=X0HXMZaBAw5DiOuKr9G29/ugTczkTljFjGDEJ3aNtm/33fB5bDfeJWpm6qDTfRV4s0Jm
	 WzqTPXYcbOQascohf98lHTHuQBTE6D5YrhFU2JWPKyOJmrmAwcvjW8CzEkzwOq+hylnu2
	 EB+joe42smTexpX1yn3rokurZNkRO4Se/aN7SQkKr+uo0aMmlmjXp0Zve2ze1KeV2/hWD
	 4utSfWS8PE8b8FilYf/8nz1nE8pSbaaZmS29sEcsqSdcTlxDeoWCRNA5ezYfZLMXtWMSS
	 y0XrOdK7HaUCiNz05pw1X4kvlMbBZM7bPeSjdRabbUzzhxm1Jg/saTENGGlK3DCZubg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760345;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7f9zZ4Pmy310Ib/7Akt2fynS2t0yOWD7aI6dwP8lFzs=;
	b=lPEkdUne5NOKP83Rl1e07+dAB2Rv2e3l3Rpj40f+MuCcAJL9G1haUIBf5XWcQJKvAgH3
	 x6hec56ZHEZUM2byKLD4QF8jJWUD4G9PnIKwaksIKP9VMPMmpG+wvS6QD1St4bEVXTtxT
	 FtdjWKJOPw/tgZbFsESd3a5NHYV5YQruz3KbTNuvpfamvi9uYB5GDpa61ep94NcLxeqDj
	 4Y6M7i7gWdP8WzO29ScPnmn5eKPn5HLsFNKRux8wHgUUtJjTB83/DT+a+KVADYC8Kn7jm
	 KVRmMicTdnEKvcQPk+oDnkjsh+nVuXqwwYM1GZZdsjuJCsXBZNfa5WL+RQpXg6qiz2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=camuXOa1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4808606A323
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=camuXOa1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3AA1F01828;
	Fri, 23 Oct 2026 12:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792760345;
	bh=7f9zZ4Pmy310Ib/7Akt2fynS2t0yOWD7aI6dwP8lFzs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=camuXOa1mjs7h+FfbzMKAVoCmJXjkkAVFJbMbrpMTZ4jo/Ru99DwDYVeAjnrlrLbW
	 1n15M6DwSxCU30ldUESq6zr1T1ughSM9Qo3cJV0yNDpFGWxmAI9kYZA8yYDzWCwVXn
	 i4sHPVeUmkX0V7AehOI3rRfZZ5Gw7k2hIBC7BNWxlv5ZI1RkipgletFHHJ23ElO421
	 wLylREqBzBtdTI5pv51JWP/9F/ERXBl6r38ojsE3+pGjnX+Gi1//tpah3Os3p0djPP
	 Rbn/5LsbLpegKE6X6ay6yWLcfmXeiplA+eU9yUVNiU3Z17HTx2IEVFOzf80KQt/q41
	 dQGzrURh3zUdQ==
Message-ID: <sashiko-outbox-182800@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 1/7] net: account for ingress-resolved virtio net
 hdr state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <94796ee3c32e50665ecf70e2b390db1bc2773be9.1792668082.git.mst@redhat.com>
References: <cover.v5.git.mst@redhat.com>
 <94796ee3c32e50665ecf70e2b390db1bc2773be9.1792668082.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 12:59:04 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> The following patch will add ingress resolution of uncommon virtio net
> hdr checksum metadata (software checksum completion at ingress) which
> adds performance overhead to the packet processing.
>=20
> We should make it visible, so a hypothetical workload relying on
> uncommon metadata can be distinguished from none at all. This way issues
> in the parsing will be reported and not quietly pay the host-CPU
> checksum overhead instead of offload.
>=20
> Flip every call to virtio_net_hdr_to_skb to test for negative errno
> only.  The um vector raw transport even ignored the return value
> altogether: rejected packets went on into the stack with their
> metadata unvalidated, so check it there as well.
>=20
> Have tun count these events per device as rx_csum_sw, exposed via
> ethtool -S.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.v5.git.mst@re=
dhat.com?part=3D1

