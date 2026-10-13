Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43D4EBAE3
	for <virtualization@lists.linux.dev>; Tue, 13 Oct 2026 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791890125; cv=none; b=UYtGvBQ9qsUWckuZqMdQoGBKERCn8iXjHtu/gZgS1NVZJpCuyYmtY2FlGprGd6m8ot7MkC5geRmaKFmtCJZ7najfry0/i4ZL5YMt3ZEhfJ+6gHy0SpEUMMpPtO35ikL2IZHz/W4M9lxSI1P0OUwpUgDhWIqh67Oj4jHkFx5V45M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791890125; c=relaxed/simple;
	bh=FeNXEJL8LdI5o+UPPgric5qBz7MJqcjccvLY2Xd4pLg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pqeMNGWV2yXmpmWjhMS8HPnu6DAHjP7yoTLGs50Mv/+ufqJeoZdS9ALVCo+fcCGdLYZZtuy0P94vUXt1o9sD7ofLuV8bgqg+EpEJoS6rhhUEqv2GqMDRCTlqmiTfpzhrpt5MOwcJg41hbByW6TLIsJYi4cDahme8vxNtAVfkJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVK6Y/ri; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVK6Y/ri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B741F00898;
	Tue, 13 Oct 2026 11:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791890124;
	bh=KTzCmxwyL4D1nvSehYQyngXVScT3fLTHaRsSQZ6iCIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RVK6Y/rigRs/BtRU72u84Tk3+AzoFLkmbj1JyRlNcAxUtmC+nkTXDwYfZkNYyWmyv
	 pldftXc/hIKckAa7nCQRiXPw/lBabt0n+64CBnM7AxccYeWxVEnmWnpDsMouNeW2wN
	 /8SWPIUnQ8WR2fM8kqoVCjZVtMS8yWsbLpug2y+2u2vGNq82mxxA7WLr1JC7ihLrP3
	 moJjXO7p9MtmDqcagfUYLNLrgrnQjdftsuK1CeZiknmJ/Qs4Rd6KKi5Bs5NtmoJOtL
	 jS7SPLlU04LPQ0wP7ZVcv3S8+TMfS4v6lLSGOsvL9IgB6UWz8c1QiAQFYMzKiW8T6D
	 MLepb8itUPUaw==
Message-ID: <sashiko-outbox-169596@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 3/4] net: resolve uncommon partial checksums at
 ingress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <e12c6a45aae251d1642af55d8d3121e554993a66.1791887415.git.mst@redhat.com>
References: <cover.1791887415.git.mst@redhat.com>
 <e12c6a45aae251d1642af55d8d3121e554993a66.1791887415.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 11:15:23 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> A virtio net header can place CHECKSUM_PARTIAL at any in-packet
> offset.  If that state is retained, later checksum completion can
> modify the packet after protocol processing has made decisions from it.
>=20
> Let's fix that: let's validate csum_start and csum_offset and only keep
> CHECKSUM_PARTIAL when csum_start and csum_offset match a parsed TCP or
> UDP header, while handling VLAN headers, IPv4 options and IPv6 extension
> headers.  Complete other non-GSO checksums immediately, before any
> protocol processing runs.
>=20
> We can't easily "complete the checksum" for GSO we don't recognize - GSO
> assumes knowledge of the protocol. We could segment ignoring the
> checksum then do whatever csum_start and csum_offset say, but that
> seems like an overkill for something that should happen.
>=20
> UDP tunnel headers get the same handling on the inner header.
>=20
> Packets without VIRTIO_NET_HDR_F_NEEDS_CSUM are unaffected.
>=20
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791887415.gi=
t.mst@redhat.com?part=3D3

