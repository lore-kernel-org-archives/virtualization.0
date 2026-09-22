Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3956F38654F
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 03:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046853; cv=none; b=eLNSqMICSo8EG8gqN2cPshsYRzdQjCaX5ggOfTBFVulWbT5t8F59EkPttg8KaP7khVabC/b1eK8HFgmQQGQ4920O7cHDF9b0Exc7TeIz/M0Lk4m31GIs5fs1JnhZQJypshsszziSrQvo4c/wUzlMPIAjG0dQjuFH0Q61sVNSa9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046853; c=relaxed/simple;
	bh=rTgW+31t+ynK9uinVwIj+WZ9bQXDc0mgsSQ4feh1v4E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JRjus4higKyCOXI0oQbz7TZEx/9cgRkr627T2FrGVWVvFqngVUjxEA5MDD0MMt2r/A6FAw4O5NJw7sQbxUWHSaeeIaR9BmkvQo1+QAxVqAyLKLts62dhMCcJNr5S2SO1jDWKaocRtrWPtWzSgXC2p6eKflCbIQf/ozd74EWRU8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPBhVYA0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPBhVYA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC431F000FF;
	Tue, 22 Sep 2026 03:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790046851;
	bh=rTgW+31t+ynK9uinVwIj+WZ9bQXDc0mgsSQ4feh1v4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZPBhVYA0rT/aHcIXrPbgQMmGLQzcsuu/FO01R3gB3vs6ZRRFHKc8yNFb6ss8QJEg0
	 qSNrzpDceq83Q6xBbM+DacUTWdSvLjS/bM8VdjemmXWY9Tr1sB1IRCB+YaznKiNzdC
	 0FGhJHU0ue5jNhxhPSTdr+5qkrzy5htnARtDpQzJWzpLFQ/P3k6DKJnTpb+HvmQrgD
	 /FjDwIchkNzTXUmZOvXwjn1gV/Eo4cAzGEqd2fq87eXTeVwXpVoKdnfZt9u6/cbG12
	 5kPsCityFDacAy9yOke2cmFQPDoVWqrmlnh9ndAc6VfWldnyzrbqH7C22J5qlsb9jq
	 4ICIFaM1m3s+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v6 2/2] ip: reject partial checksums covering
 network headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paulos Yibelo" <habte.yibelo@gmail.com>
Cc: "Eugenio Perez" <eperezma@redhat.com>, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>
In-Reply-To: <20260922030310.8684-3-habte.yibelo@gmail.com>
References: <20260922030310.8684-1-habte.yibelo@gmail.com>
 <20260922030310.8684-3-habte.yibelo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 03:14:10 +0000
Message-Id: <20260922031411.4DC431F000FF@smtp.kernel.org>
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
> Assisted-by: LLM
> Signed-off-by: Paulos Yibelo <habte.yibelo@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922030310.8684=
-1-habte.yibelo@gmail.com?part=3D2

