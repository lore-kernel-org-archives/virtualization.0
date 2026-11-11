Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364986;
	b=g180arogVQ46Nae6m9TPI32wM8nuEKqG0QZ7TzgTSc4O3Db/gkOkLVZqIfyReqEU72EJ
	 bV8RA2bhRRDmaxBr5lntl0u4xkIazhs7IiEjg+NBQvpNhxSvPCvokIm9M8Z3tA+fvSRa1
	 5bzHLog6Qa4mb0qtolfgsD7o7kbs2JeOEV3dmnl1vc7gSZJuqxU/W2mnb7/vfQg71oJYg
	 hlMnmrxFFel9Da4yL/GFZyPxu/I8AzVDUepJKNqyayNcUUXBwCbkyLNUKcFef+9kmeM8Q
	 mYkVX/CRif1o2gqoqyqyG8PrOBY9QEvbhC3qo79x8Souf0t8RezUxoWRB2NVdwnNTGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364986;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TZ1YvkQOiHfmCR1Kr3+s12HEPu07qczBbQpDiZp37ps=;
	b=xJ1OklxKMY9zSTMtnVoASduhUAuENm3AEO7igFQCK2m8iwLoKSqBx6KLt+ItJ092lZyr
	 v+lMYBhFuEVh1swBdKEhUWk+SsoFYlC3evTEOIgzlHvOub8liNiV5WIltuUIJHEnSDMhZ
	 i6mTRgP4vqGE7TF9li9s65Hma+lnPLEC9bDyHznJebOrofX/3clLOKX6oumMcoK7WAE04
	 1HR5RlMLX2U9PeMQQgBayYb8sBKzvfZQUyxRoHn5tGtVh2cBhDJ170gKk8xskP1nWwnQd
	 n2T7j1wuOuo3vZs+aXj6bIvKaDLpDVMZ+SJohxvNFi3HxKweith/Tgc1BqC3DzFgpvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnvBCv4q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3F8606A31C
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 02:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VnvBCv4q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EE21F0089F;
	Wed, 11 Nov 2026 02:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794364985;
	bh=TZ1YvkQOiHfmCR1Kr3+s12HEPu07qczBbQpDiZp37ps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VnvBCv4qYW0STTYKJp5BW31FwDVZwJwzYwbkk5ybqG4bYQYW5sqeN7cgfLPcOhoVD
	 W6G1yeMgr9cf0wNw1OVLIyCxUXr/hIGFcs8OgD5dcWk7DTId5B92TrB7iTd9acQqUb
	 HBb4fEK/SX6uv8eUtMWVXj9xo7yGxLF+AGIdIIZ+n4AxenaBGy0ZUvJ98evgQuvzyE
	 J+CLBKeJ8qkgwuLmUOrJr+CXnjKUQJPr5jXnt5RvexRCS68ZEvM4BNJ2QNsghHOLnj
	 fEJBVcKyJZwE++VhyCs9iiTGPl2pq0AMn4f5zUjVzBuX8AgFGXjcQFa0dGtaeVL0hC
	 sG2zaqMcfSQqQ==
Message-ID: <sashiko-outbox-208109@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] splice: replace nosteal_pipe_buf_ops with
 default_pipe_buf_ops
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S2lyeWwgU2h1dHNlbWF1IChNZXRhKQ==?= <kas@kernel.org>
Cc: virtualization@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20261110145241.536019-5-kas@kernel.org>
References: <20261110145241.536019-1-kas@kernel.org>
 <20261110145241.536019-5-kas@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 02:43:04 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

> Without ->try_steal(), nosteal_pipe_buf_ops and default_pipe_buf_ops are
> the same: generic_pipe_buf_release() and generic_pipe_buf_get().
>=20
> Keep default_pipe_buf_ops, and use it in skb_splice_bits() and
> fuse_dev_splice_read().  Export it in place of nosteal_pipe_buf_ops,
> since fuse can be built as a module.
>=20
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110145241.5360=
19-1-kas@kernel.org?part=3D4

