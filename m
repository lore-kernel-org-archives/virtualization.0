Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A204A46C827
	for <virtualization@lists.linux.dev>; Fri, 16 Oct 2026 12:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154537; cv=none; b=VdXaPlvhIcT/R3nMi6swCiHeQfjXsez7vGuqYDl+MsrOK91wAj5x8KT5CcUtVlMba2Y6LjAze4Hbe4odWKWhf59k+rvEuLHKQFd513J3gSfhzU4cf+H1weBPyqRmVAMMTEWFwsuWSJdI70P0KzCHWUyTkMx5DSzsLLKlvC9Bdto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154537; c=relaxed/simple;
	bh=wEOubLx0usmz36g2FM/Uk1/0jE7u7KJ7kO8hRHmlFZs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dtSBq4Zyt3zhNu0m4wCdV8eFmwR28mLrf0COT22YjD7IYAodsW6qrZgM03AwelK6/cWjrtgPL8O37KaXb7jAx2pV393EbohNBXYiuZuUOF1bvzG2dtaZ6zYkCX3+TT08FIdYfTIOl48NIhI9TOte4wb7/N96MMIwCzbruVlcnxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjBTQ9c0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjBTQ9c0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E821F000C5;
	Fri, 16 Oct 2026 12:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792154536;
	bh=u6H2njE2XwVE4HxQITGC92gjLxYMoiqNv7oJV5skNPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YjBTQ9c07z3V5JbxFrTWG//sFC7zLLGX7rrxGEneLjunJHqLafdXnZ19I0KfgDt72
	 i1wsqIsGGBh5NWQkp0SdGvVeKwszaCGZqYH5qN/ZewXCAmA4ET+y+jphfZY8boI2//
	 11N+b2wr/9QCkpeAkFaAPnL8wydOBEaBiIDWiJwKBw2k8/AUcmEJzWh07Csw2iQ+rx
	 bo/t91WiC807HKOQWp5pZuyx2jWn9Acda50Ovg6oJWoq8CbaJEfTIasOllQJPGRqDQ
	 3Z+ywJANl37noXCo7ISlL1dYDViXbPuUOu5YMUbXidJln+6CoIjo/HV5vSyNdBkMhm
	 9oCnXxqx4Q3Cg==
Message-ID: <sashiko-outbox-174321@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 5/7] net: add a sysctl to opt out of virtio
 net hdr checksum validation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <ad05a40681719a579691a1da6413f0dd7064f2a0.1792067836.git.mst@redhat.com>
References: <cover.1792067836.git.mst@redhat.com>
 <ad05a40681719a579691a1da6413f0dd7064f2a0.1792067836.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 12:42:15 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> The ingress validation as implemented by the previous
> patch is stricter than what it replaced: GSO
> packets whose checksum metadata matches no transport header are
> dropped, and non-GSO ones get their checksum completed in place.
> Such packets used to pass with the metadata unvalidated,
> and with no overhead.
>=20
> I judge that this should not affect any deployments, but there is still
> some risk that it does.  In case a deployment depends on them anyway,
> provide a per-netns switch to get the old behavior back:
>=20
> echo 0 > /proc/sys/net/core/virtio_net_hdr_csum_check
>=20
> The default is validating.
>=20
> Assisted-by: LLM
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792067836.gi=
t.mst@redhat.com?part=3D5

