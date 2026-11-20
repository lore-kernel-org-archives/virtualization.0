Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795176204;
	b=MrxAqUcW9enKaz/iJ1b//3rWxMBTdhO5jJ4ubawPWCZtxp5gOqp0ID9Aln6/WbxToONg
	 +NUQDyNn/junhd4djOdMREb9IAevt/QQ68BYHIevT1mcaj2ZDZQ5c7eUBSF/1Ug/whHt1
	 9QffY3hVmbKeQzmuDCAY3nQ4KWbjPe+PR4b5k5Hb7fVElUGL0MtRsV8PfrXHJxzHGfdEc
	 7q0Wf4ozaeGGpsmoZ9XJAzN0ZOU5xEahTkvyFp57ZNhK1pKj/ySJ6lhcdUoAO+bclP55A
	 /S5nzmDF5vjowige4e00bN5SppQog+yD7ZF2sNgBQ6YvcWQAFzNotjEN7ecAlVaoWww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795176204;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3X40snasVM6VQVCdbO4AvU+vGSIOUOjIMB4jpHqgVA0=;
	b=LM1HFc+jDZSXjSgkrq2PySqcP9g/EzVlCoPufHclc0aDIh1dT4Kc0MnXlCDGMvk0+tNa
	 6d/4atbRuvpcOO4gmmqqnsmewbw8OEIOKS/xpTqqOfy5eS1Ywnn+Komnod6qbylH5n+pK
	 KweXyIbVenA0ewkGTjBLAmQu7HBiqfbT4AWs00cZOa0WwrB20nBek4T1yHkT0wrrKylJ2
	 Qz3MHG61ocV4i9BJXsaFO2tXRCpbcINDOSi8frhTr2mQBdh4kpJ52v4+LvFmqWSyGepV8
	 0YWq3d2k0uMD2aD17lQS1M/eMWzwxnMboWc6JJgNZbXI4fwmbyEsZQoM4nCmPL5nmcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y4Tewtli;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD84606A32A
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y4Tewtli
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BF31F000C6;
	Fri, 20 Nov 2026 12:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795176204;
	bh=3X40snasVM6VQVCdbO4AvU+vGSIOUOjIMB4jpHqgVA0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y4Tewtli9uQ2V7s0qTKo4xCROEZd9JUleRLpxlR4e8l+6aFu+Y6yQkcZc4+wsX7sX
	 P0HIfoT2GN8RT9dn9V34uJxNbzayy/vMhy/7FVHzyTrTVPsvq4qPURqJidMsLsO/a1
	 Um7+CulzL4vQU7H7NQ7Of1e6QIZRc7ZFTIqhqZzRsUH7ljRq/2GEzJozOvbJBAQmIO
	 SQ+q4sYRZCl7snC92VIGbIL+w5Z1UJnhUtip5V+sCeVIGYvVS3B4g+i8ct9Wrbs++8
	 hbSW37vL2ltsDP/g8+vU64pzR6+ZzytGh5LV1ukMzTAzPwTam6w79ItXtlBaKymtC+
	 jeC7RerXLuOSg==
Message-ID: <sashiko-outbox-225110@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/7] mm: add PG_zeroed page flag and buddy merge
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <a98c8a49744d30a5e603228d9cb17509261add90.1795089715.git.mst@redhat.com>
References: <cover.1795089715.git.mst@redhat.com>
 <a98c8a49744d30a5e603228d9cb17509261add90.1795089715.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 12:03:21 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Add PG_zeroed (aliased to PG_private_2) to track pages whose contents
> are known to be zero.  Propagate it through buddy merges and splits.
> Upon folio allocation, PG_zeroed is cleared and its value is transferred
> to BIT(2) in lru.next.
>=20
> This bit, in turn, is tested by the new folio_init_user(). If clear, the
> helper zero-initializes the folio. If set, it skips clearing the
> contents.
>=20
> Clear the aliased flag on free so filesystem state cannot be mistaken
> for zeroed contents.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795089715.gi=
t.mst@redhat.com?part=3D1

