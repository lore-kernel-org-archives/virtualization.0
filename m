Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A22F412276;
	Wed, 14 Oct 2026 10:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975570; cv=none; b=MMw5PcPkGTLvHWV4GpU07lf6YWdD6NVhcSUY0HriAvuY+EkGUruXxUvTS78d9YQlbdIltcZlffgvT+ReN/RP+4NDZX0hcZ5+gq/yxqevt0TW5M6EbC2TRa/QiXA83B6eG8wn/TmHHTuN/ILe+psVLX5oUe4eV7oaojxAq5nmJSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975570; c=relaxed/simple;
	bh=6uvmCIdeVyQZ6DXKXSWtOio1ENcHU/d1CYuniVEwkBw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u31i2O3AxjJ8OzV29TOP4ue/M4eSDEIsZpTu3Rpjw0wKTeLagSBrJu5LnFODtbFtavqkBXi4pFqz2P0a42WpR+/a/kvmiIVuPyxTI9FA8Dd9y66u4eif8P92dshURldtRo8/Fk2qcVzSeq3tPVid05xxnIl58OgZdO5kwJSgaB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB8OGdGb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB8OGdGb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0872A1F00893;
	Wed, 14 Oct 2026 10:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791975568;
	bh=udGiZ2QiUocnB/gausSU85SeHeMymbjJpcvE7RG+rjQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bB8OGdGbHPyC24LDrAtXrQquFPQkOcX8xD6Fj4g83z4Y5pNoqIa1q/6zyWGnbhMUs
	 7Byy657gBydCr3BV8+IBPLb+gZphdRhjqixKaiXeVGgfk1nkYIfnw6Rgmz+6K4NGb1
	 FAzJGiAO3Cx+qsC6u84iKUV1IuTicl7vLNnGS8uVQO2bNy786fkzzic5Ynh/oaFsVe
	 pOXEK6XFm7t2XWUrx+mXjkwKXl3HiqTVJoztPjBz2M6LmYZZjkn2DuvHljLSXd73Nt
	 +2f6HjEtyXxjnOkTbMjXvizMVGcgynY2/boNgF/UYUcSk5nbkgjDWqsvKwvuf/qNwu
	 5EvzCjQ8bqEdQ==
Subject: Re: [PATCH net-next 1/4] net: add ip4_parse()
From: netdev-bot+sashiko@kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, maxk@qualcomm.com, rusty@rustcorp.com.au,
 horms@kernel.org
Date: Wed, 14 Oct 2026 10:59:27 +0000
Message-ID: <179197556754.434549.10151843409625099884@kernel.org>
In-Reply-To:
 <bfd6257f8fc8a5c6cd876b8ebc498b8a4ee0be8e.1791887415.git.mst@redhat.com>
References:
 <bfd6257f8fc8a5c6cd876b8ebc498b8a4ee0be8e.1791887415.git.mst@redhat.com>
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

- [Low] The doc comment on ip4_parse() (include/linux/ip.h) promises more
  than the code checks.
- [Low] API hazard: nhoff is unsigned int and `nhoff + sizeof(struct
  iphdr)` is not checked for overflow.

--

net: add ip4_parse()

This commit adds an inline helper, ip4_parse(), to include/linux/ip.h.
It pulls the fixed IPv4 header at a given offset, checks for version 4
and IHL >= 5, and returns the header together with the transport header
offset. It is meant to replace several open-coded copies of the same
minimal validation in the net stack.

> diff --git a/include/linux/ip.h b/include/linux/ip.h
> index d11c25f5030a0..98012f6d0efb5 100644
> --- a/include/linux/ip.h
> +++ b/include/linux/ip.h
> @@ -56,4 +56,28 @@ static inline void iph_set_totlen(struct iphdr *iph, unsigned int len)
>  {
>  	iph->tot_len = len <= IP_MAX_MTU ? htons(len) : 0;
>  }
> +
> +/*
> + * Pull and minimally validate the IPv4 header at @nhoff.
> + * Returns the header and stores the transport header offset in
> + * @thoff, or NULL if truncated or malformed.  Only the fixed header
> + * is guaranteed linear; callers that need the options or the
> + * transport header must pull further.
> + */

[Severity: Low]
Is "NULL if truncated or malformed" accurate here? ip4_parse() only does
three checks: a pskb_may_pull() of the 20-byte fixed header, version == 4,
and ihl >= 5.

Two kinds of bad header still get a non-NULL iph back:

  - A header cut off inside its options, for example ihl = 15 with only
    20 bytes in the skb.
  - A header whose tot_len is smaller than ihl * 4.

In both cases thoff is stored without being checked against skb->len or
ntohs(iph->tot_len):

	*thoff = nhoff + iph->ihl * sizeof(u32);

The next sentence of the comment says the options may not be linear. It
does not say that thoff can point past the end of the packet or the
datagram.

The callers added later in this series do their own checks on thoff, so
none of them overruns today. Those callers are ip_rcv_core(),
br_validate_ipv4(), nf_reject_iphdr_validate() and
virtio_net_csum_partial_ok_at_offset().

Could the comment say that only the fixed header is validated, and that
callers must check thoff against what they can pull and against tot_len?

> +static inline struct iphdr *ip4_parse(struct sk_buff *skb,
> +				      unsigned int nhoff,
> +				      unsigned int *thoff)
> +{
> +	struct iphdr *iph;
> +
> +	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
> +		return NULL;
> +
> +	iph = (struct iphdr *)(skb->data + nhoff);

[Severity: Low]
This isn't a bug in any current caller, but nhoff is an unsigned int and
the sum nhoff + sizeof(struct iphdr) is not checked for overflow.

Suppose a caller passed a negative offset, such as a negative
skb_network_offset(), or a very large one. Could the length passed to
pskb_may_pull() then wrap to a small value, while skb->data + nhoff still
uses the original offset?

No caller in the series passes such an offset:

  - ip_rcv_core(), br_validate_ipv4() and nf_reject_iphdr_validate()
    pass 0.
  - virtio_net_csum_partial_ok() passes ETH_HLEN, a VLAN depth, or a
    non-negative skb_network_offset().

The IPv6 branch next to the ip4_parse() call open-codes the same
pskb_may_pull(skb, nhoff + sizeof(...)) pattern.

Would it be worth documenting that nhoff must be in range, or rejecting
an nhoff that wraps?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791887415.git.mst%40redhat.com
