Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BA54F4745;
	Wed, 14 Oct 2026 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975571; cv=none; b=IlV1LvcC4+FYhmcnGqofXHlRd5rfHEIV37YqabuJHULYrfmnxxCniFHtwYE2XG425SN0K9GHtSbD8PBr8HnKvVxIruEjf67zevUDhZuFqApsmzPCGhDmt09pHJXjWVBWhOpHjlNuQqJYEXt1Lb7vRYiMwCMqI8qvl45YiaNKO5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975571; c=relaxed/simple;
	bh=zEdvw00+OB4u3D7ZFXgEPWff6JkcvwQSmWwuMgxuYH4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bcaWH1rfk4Exjwx2n8/5+K+A75/Px23+lrI94DwEKLqHPlQOMIzwIcC9VgA/NKlUBv05ZZJ3V+AcLYWEHDgsQwJ3NtZLvSv1dn1mLhLb/Jp3/1gxW1vcgMZC30C7UVVKUBuEywfwxvsaSYqRawhn8BiF0alIGHSX909KAkTrG/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXpMUoUr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXpMUoUr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FBC1F00898;
	Wed, 14 Oct 2026 10:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791975570;
	bh=Xe468sh/L6Nr7iH3EsYlMcP//McKXHnPmdwCKiwKL1o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EXpMUoUrF+3mWSiYPqkw5L0PV7XegaluoDDpLY5ATdzEIIalbcrwQUxgZ6hMh6qrC
	 arbd/6nu54c1RmfF3WoPG2oQsTCHZKFfVn5HDwJK3tbPFv4Ekic7XnxyMssQW/UYyI
	 4oUgM3xVoEf6FNdY8dyf17SThGtFzj6B+NDC2g9TyKxMXW+4eelSpw5ZxtYLGvnYLU
	 ngY4gpHi1dNg7R8pMnk7BTB2tUUGB5Opu9xTBCENHCeAA6VA8WR9tNfovTtxIdYUnh
	 eME6uGuoD0/iggZU8nzvze3fuHsRx4EyX31hXHS3dzz4J+ysFRENcP+WxQdjFePLqX
	 sWV28hzsKhFDw==
Subject: Re: [PATCH net-next 2/4] net: use ip4_parse() in receive validation
From: netdev-bot+sashiko@kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, maxk@qualcomm.com, rusty@rustcorp.com.au,
 horms@kernel.org
Date: Wed, 14 Oct 2026 10:59:29 +0000
Message-ID: <179197556904.434549.14572204986148873620@kernel.org>
In-Reply-To:
 <05eb0a83a9975e8e042caeeb4fca5fad30e02fb4.1791887415.git.mst@redhat.com>
References:
 <05eb0a83a9975e8e042caeeb4fca5fad30e02fb4.1791887415.git.mst@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message overstates how many sites were converted.

--

net: use ip4_parse() in receive validation

This patch converts br_validate_ipv4(), ip_rcv_core() and
nf_reject_iphdr_validate() to use ip4_parse(). They previously did an
open-coded pskb_may_pull() followed by version and ihl checks. The
returned thoff is then used in the later length checks.

> Convert the sites that pull and do version and ihl checks on the ipv4
> header and validate the packet transport offset to use ip4_parse.
>
> Sites that validate a read-only copy instead of pulling - the nft
> and nft_inner header_pointer validators, ip_check_defrag()'s
> skb_copy_bits, the flow dissector - stay open-coded for now.

[Severity: Low]
This isn't a bug, but is this description complete? A few sites still
call pskb_may_pull() and then open-code the version and ihl checks. The
read-only copy exclusion list above does not cover them.

nft_set_pktinfo_ipv4_ingress() in include/net/netfilter/nf_tables_ipv4.h:

	if (!pskb_may_pull(pkt->skb, sizeof(*iph)))
		return -1;

	iph = ip_hdr(pkt->skb);
	if (iph->ihl < 5 || iph->version != 4)
		goto inhdr_error;

This has the same pattern as br_validate_ipv4(). The header_pointer
validator in that file is __nft_set_pktinfo_ipv4_validate(), not this
function.

ip_mc_check_iphdr() in net/ipv4/igmp.c:

	if (!pskb_may_pull(skb, offset))
		return -EINVAL;

	iph = ip_hdr(skb);

	if (iph->version != 4 || ip_hdrlen(skb) < sizeof(*iph))
		return -EINVAL;

	offset += ip_hdrlen(skb) - sizeof(*iph);

	if (!pskb_may_pull(skb, offset))
		return -EINVAL;

This looks like it maps directly onto ip4_parse(skb,
skb_network_offset(skb), &thoff).

nf_ct_bridge_pre() in net/bridge/netfilter/nf_conntrack_bridge.c calls
pskb_may_pull(skb, sizeof(struct iphdr)). nf_ct_br_ip_check() then
checks:

	if (iph->ihl < 5 ||
	    iph->version != 4)
		return -1;

All three sites are still open-coded at the end of the series, after
"net: account for ingress-resolved virtio net hdr state". At that point
the only ip4_parse() callers are br_validate_ipv4(), ip_rcv_core(),
nf_reject_iphdr_validate() and include/linux/virtio_net.h.

A smaller point: ip_rcv_core() still sets the transport header from ihl,
even though thoff is now in scope:

	skb->transport_header = skb->network_header + iph->ihl*4;

This has no functional effect.

Should these sites be converted, or should the commit message list them
as staying open-coded?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791887415.git.mst%40redhat.com
