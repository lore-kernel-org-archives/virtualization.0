Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524459;
	b=oB9VW9vbxLIB7Ppc24I5CBVjK3S2JJ2Am9ff6meMzLxo1FkkGntKDkqWDP0IRrPlcfYG
	 3M3Mu/Fq0n9tE/SOIqmNdIeq3dvFbeYGN/Sf5dXp9lQhsuwFgaqK+MLV0Lc/pUPnVPvp/
	 gtnIOkcXIKTk3yvzBLrZPLKhxl7/jot1tdTa9OoHDY43Xi8ETbr1uv7DtUdOaV5/B4G8P
	 RgwamNTVnzJrAJ4pCSTB7V/1grZ24Z7RpytiS9DhKDxwaLwmJ+3vQ8gHXY1/2rWFMGDnd
	 Zyf1453RcWBmxHcAMOWvAb9ItWdnx+Q8JMBLWydRm/+SDXISPEjtJh81QLdzXKKMblA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524459;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dOJBmO456M8iG2ZvjfoVtvl6aoiUJN0Hhtj1Nb7Oo+Q=;
	b=ixKLsfdgliPxZ1MShSXFtyaE9zBA+Pkxs6uRIGaagzb5KNF3Zw1AefnjrH7NRCheGMPl
	 em/zzXBNrjQ2V+STQOKvwBxyY+MFMLUScbah5FeO+ZM/GMb0frS3ldvpP6HKlGoiBjxXx
	 QzdDiPWFRd496WRgIrISNsm+Jkl605cC18F9+jHX0lVFb5/KYz2/hWqJnBnntFCcUr2Ye
	 GyBp5HZGHtAmz6r753nrPNFHngOwWIlSPqaJx+4V41g7F6jETBBTlwqZB0cOJIHND81QY
	 Y05Xq7sXA6GIYOn9pctpe2Mf2cdh/fMdJho6reKTRebp47J0IDLqU98zTM1tMjiN+mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sxxwd1No;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3741606A321
	for <virtualization@lists.linux.dev>; Tue, 24 Nov 2026 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sxxwd1No
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D88B1F000CF;
	Tue, 24 Nov 2026 12:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795524459;
	bh=dOJBmO456M8iG2ZvjfoVtvl6aoiUJN0Hhtj1Nb7Oo+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sxxwd1NoFklpDWQ00uFdPWpR7K+dRB3HG2RmMYYS6GHXCgc9cCzopWW924/WH/4JU
	 0m4Ppit12uyZOhoF/lwI9bCrdkZB5HaoZ/eIVlv34gTWsxwtI/Cc+SGJki0mjjn5Ck
	 sbnLfpTz8lqopsc6daIKXWilm5kReX/TB9ZkqOMCihDdoIoYzBttBEY1fJTXWmME+a
	 imriGlSL5zP9bjIfnWQRZqhOCMTtXb51DRgDsYzFm4uO/23JzUHr2FIUyValE8vqFu
	 79seciGRPxl9LiyNkMSoujiMzokTpC5534huxqcCu7NCJdkzLMjiWUSdzkAyPDMhUP
	 DLByKjoFP0Gfg==
Message-ID: <sashiko-outbox-231175@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 0/8] vsock: add datagram support to virtio and
 vhost
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
References: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:47:38 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Sashiko has finished reviewing this 8-patch series:

- Patches 1-5 and 7: no issues found.
- Patch 6 ("vsock: allow datagrams to use directional transports"): 3
  potential issues (3 Medium)
- Patch 8 ("vsock: add datagram tests to vsock_test"): 2 potential
  issues (2 Medium)

Detailed reviews have been sent as separate replies to patches 6 and 8.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-vsock-dgra=
m-support-v4-0-3607484e85e8@redhat.com
