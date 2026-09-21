Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6689E1A6811
	for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 03:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789959690; cv=none; b=OMj0t8bQVTvx2AMlCGXBNghfj08VLB3/FP6kZnNFlVBtiJBeUnclfzEtCsXNIKhpytAwLY5BDE3FE1S0FtiCP6UOIHopQFbmVRWcYk2DEeEsXIinS2O83EWy0iLXZ7Su7pZVkBazIeVpNrmMDmlNd4XsXZcUBAfwWYQYMJLijmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789959690; c=relaxed/simple;
	bh=vfxdQWV7vd6pkx5aZWx+nOJ2FUxFj0TlaSoQ2f9C9ig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NVSRwTe6xoqHUcgfqsoqrRU2jcaT0EeJiehRtQMkxS6frS+nrmz7dAH0QrOVZuBgQBZa3GxA1jf5q5Foz43EMN/G4ckg3L2qHfwWKcO/WgKss2dFeOr7n8Wlj/bWCKRnvI8zV/fxZOWE3F+3p/SFLIDSusAcHg1Vnjhj+GPa8is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZpy1vjU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZpy1vjU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9D51F000FF;
	Mon, 21 Sep 2026 03:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789959689;
	bh=vfxdQWV7vd6pkx5aZWx+nOJ2FUxFj0TlaSoQ2f9C9ig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lZpy1vjUMztXv8vtQ9Toqn72Nx/8MjCvYCO54utCzkZou747n/VHpRJKVc85aHS3W
	 o/RPEt4rK/IO0S+OjKkgnu92YE6KbQGL4JoPO6pcf0/0RmwbKQ7oW7yj6os9UdeSi6
	 Z17tfF8He3KxFP3nT6n+7XxQm4QM4nnhe4wYHBvnM3A+IsyHO8QBcyoOBAKeUcNANk
	 4sNmyeNeNwRKmTFIYOA2AJGzuAI0jCYZHw57kXpnGTPcsOstBPREZ0tatUiXZwWAkn
	 +z0B0pOU0ZnzI8aUcLv2Voc6Jeb49s7UTEtXzmtG7sIMYWtsQ9TDwJqvw7EfMqyBfo
	 K35f4KRXsfZdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 2/2] ip: reject partial checksums covering
 network headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paulos Yibelo" <habte.yibelo@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev, "Eugenio
 Perez" <eperezma@redhat.com>
In-Reply-To: <20260921025341.44846-3-habte.yibelo@gmail.com>
References: <20260920004733.6473-1-habte.yibelo@gmail.com>
 <20260921025341.44846-1-habte.yibelo@gmail.com>
 <20260921025341.44846-3-habte.yibelo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 03:01:28 +0000
Message-Id: <20260921030129.0A9D51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

> ip_do_fragment() and nf_br_ip_fragment() complete a CHECKSUM_PARTIAL skb
> before reading the IPv4 header length. ip6_fragment() and br_ip6_fragment=
()
> complete one after parsing the IPv6 header chain. A virtualization
> interface can supply a checksum start which, after link-layer removal,
> still points inside that parsed network header.
>=20
> skb_checksum_help() then writes the completed checksum into header bytes
> the stack has already consumed. For IPv4, changing iph->ihl after routing
> and validation can make fragmentation copy beyond the skb's logical linear
> head into transmitted options. A negative checksum-start offset is reject=
ed
> by skb_checksum_help(), but only after a WARN_ONCE which can panic a
> panic_on_warn system.
>=20
> Validate the checksum start against the parsed header length before
> completing it. For IPv4, read and validate IHL first, retain it, and
> reacquire iph after skb_checksum_help() in both implementations. For IPv6,
> use the length returned by ip6_find_1stfragopt() in both implementations.
>=20
> Compare the signed checksum-start offset with the bounded signed header
> length so integer promotion cannot bypass either boundary.
>=20
> Fixes: dbd3393c56a8 ("ipv4: add defensive check for CHECKSUM_PARTIAL skbs=
 in ip_fragment")
> Fixes: 405c92f7a541 ("ipv6: add defensive check for CHECKSUM_PARTIAL skbs=
 in ip_fragment")
> Fixes: 3c171f496ef5 ("netfilter: bridge: add connection tracking system")
> Fixes: 764dd163ac92 ("netfilter: nf_conntrack_bridge: add support for IPv=
6")
> Reported-by: Paulos Yibelo <habte.yibelo@gmail.com>
> Link: https://lore.kernel.org/netdev/20260920004733.6473-3-habte.yibelo@g=
mail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921025341.4484=
6-1-habte.yibelo@gmail.com?part=3D2

