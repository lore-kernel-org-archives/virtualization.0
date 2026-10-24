Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792854589;
	b=PgQbf7ddfcnBmdPxuoMGXXqMG++dyeCTSprWl+B8iQULO6S0+HKBZYXQnqsHngB4tjWo
	 szWKR3c0QZjK0s7wIq+Vk+66BoXNSlqNOm3NtCoBAdB01yHcSEsIKY5ue9flipEGtoHry
	 GMs3Z9VI3XQrdnhPIwZMYCLgnWLhOzX+i9VGuWGaqBfN4vSc90yhSLAYKgbOMGNSFbSfN
	 QjtxUw9pmrr9b0COuEbXF5wrpMmI2ixp7wSt9N6VHvBXNdTS7+B0aAB2xSdFmj1iq7g22
	 75ksSZaxyYMXHbhGmLXZPOD2PC5iLYe+KxC/Rl9wFpOIQDwql182Q3R+YbVjN0+OlGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792854589;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+52ChFd8/7OJC0ca/iSdWQbPedmdDpU4hYbijZ5YO1Y=;
	b=CWyPVtN415tmY5vjasdH7ATQWJV82kFQJ35TQPL/aICPHCglWxMYQK+KMemrNAN312xj
	 cBhdWBeIFywpVK2vaKmxaLaU7g/XYSEfuwHiy8ts4mORDhP4eYuRGkZqGoOPk8uqCjPaK
	 uAXrUtyjpaRnTzQtWAXEA5zYrOempnvm+V/8Wai016X4Gm4LPEAcSL/CTH2CIbaTp09DC
	 VGtFBrhTo19wXhwsPbP9mM2NEmeCnCmzWtNjaqjT6MEzIcxLCtCBkKKKJsEp2dzpvyIOL
	 muAIgfsHXlIPc5lHsHDgYCNsQ0QfJ2DwBR/VuypBhi1zEmPJdMVuvGJ1Dtm06yx4diQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dekkUKOm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95444606A31A
	for <virtualization@lists.linux.dev>; Sat, 24 Oct 2026 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dekkUKOm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1471F01825;
	Sat, 24 Oct 2026 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792854589;
	bh=+52ChFd8/7OJC0ca/iSdWQbPedmdDpU4hYbijZ5YO1Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dekkUKOm6oQ/fD45CBKAR3Kk+foyVBFkaq49IM3I4xtlTCATl6BJJ8tFf2PC+R613
	 z8LaryqBMX5edp6O9q5fNAWM6oCUcoswHXZoRbtplJJj0Guj2sZHeTiXLOYyIgKOTU
	 SoUbL4cxcctcNIfv63baDYR96RxF5ULV4tYUOJkPtEbOMnRuH9iaoBjnZM5PZM+SLU
	 7B4wlCW4tnjvDeMNcrGe1KLg+1pprq+DzgCZoRFwlIZlTRo8I1tVMYKAdprOD7BkCN
	 A9YRNs7HzdgbQYKxXc18QeIde98MO6ljbwTFGEB6I4+Sst3we9zGEHJ7Wv3SSgrftN
	 lV+45wPoqYMXA==
Message-ID: <sashiko-outbox-183767@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 1/5] net: account for ingress-resolved virtio net
 hdr state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <726145690d46fdfc8dbe590ec4dd42d42ab175db.1792768096.git.mst@redhat.com>
References: <cover.1792768096.git.mst@redhat.com>
 <726145690d46fdfc8dbe590ec4dd42d42ab175db.1792768096.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 15:09:48 +0000
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
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792768096.gi=
t.mst@redhat.com?part=3D1

