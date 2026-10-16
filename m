Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5252347209A
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154538; cv=none; b=MyizWMphLiNf8VMg771WU5aKJd5bLaCjKZy5GJhk+ES0EDrx24GFy7jb6hjIh4aEqH24XO5KshFSJL0v6E1T5tX8Fs6SDusXKpXhEf/9Yu2p0+PD5TrB4/IDODRL8dMBe982mXVTWd65QzJkK1KVTFTKimcP2+G2tWqZwVrWS7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154538; c=relaxed/simple;
	bh=PdEvFaWh5FTtQBYNG+9b7RLg/lVbXBsqCG8XMS4CUtA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hs+RhggjNOl9pLds1iuRgZ7smUH6zRBuEN1SRSs//4AauggeChS9o3iZlANdTFlqneAwxSuyXcvzs9Yu8w2sZsCMu2sDZpV1wHYVcQuwmoh/BFHpxkYw1Mdhwnv28h5ExKB+CDsfnSAFxi+2j1RWbQyyRwq2gQ/zK/BlamBFVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEHBT6KL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEHBT6KL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F6E1F000C6;
	Fri, 16 Oct 2026 12:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792154537;
	bh=PdEvFaWh5FTtQBYNG+9b7RLg/lVbXBsqCG8XMS4CUtA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mEHBT6KLR9pXZ+cLniRnngsaz+62lNvKrkCAVFloV+iodj3q9xkJVTGbt2izYV+Ew
	 V+m4ABeAvq4sAz2lIh6qp+WDWXl+Dpgp14XXpzLmqUfdLPiknkHNEK2IAZ0LFbeyBU
	 Yh6GFaMA2MEXDv45ouv97Kco4yZNiR5QZj3578TvLwZA2Hn9u4eUTibWqBGC2bl3+w
	 K170IjUcTmGE2zIjzBuF+zNITyxepZDDrRuXV/G5FEflWV3j45cH/hIkuNM3HieKsH
	 Fwre+fX7MM0GddfiwdfLr5TzXyDOIENFLeezXqNrvUWKsqiP/pz604rDDclOnQuEoc
	 +EOaVWEGE4rdw==
Message-ID: <sashiko-outbox-174322@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 7/7] virtio_net: cleanup protocol
 calculation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <3c828204754ba2218e419f8d0a20bede7d8dffe1.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
 <3c828204754ba2218e419f8d0a20bede7d8dffe1.1792067836.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 12:42:16 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> A trivial cleanup removing a duplicated code line.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792067836.gi=
t.mst@redhat.com?part=3D7

