Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760349;
	b=SXVYskwxAWEbxaMngvwL3i1uhntih/YwrRSg6yykhePpDQKCVjP40RBdAbRl9yyv9VbP
	 MsEobWqgHMX2NPPXK8qPxFxIz4eqRqYLq9jafFX4Hvz/SQsziqPBZAXV0zePKQK0mrXM3
	 kgleUd08arEsnYyDvEQi2nhO+/11p/Yt8AZlp7Ney79iqP/aO0wijfLe0v/TZMIPUBPSL
	 HpdEyD7dSZjjmLRVJKgwquFJzUGwvpbeXGWWW3wkSYPgmTRWbzXZAx6hCJGMeDkom8mVi
	 zbkIF3/ItCankbP0+AHFS6w96Afta6Pg+2deCUwD71I4jl6jK3kMo8EIBy+tp/XL64w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760349;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cBC+shEKAh6fnx4DLc51NsNyomNOLmcjHuReAIR5ZNM=;
	b=Nw2kfzNf+DhzamWsqsd1xznqkDbGorFZxSMAHCui34WFhKIjTH+WLMDj5JVeDLATJeY8
	 pWPGN3Rl3TViZs1D1XlSI7k23+TyJKwIeyFxyB4OKUgt4tQ7Cf/6XmeXP29MZvYVtuQIm
	 Z7yktyDtmCYpdSaMv6z7bBJJjzXYQRkPq0Zfm7SS4nKKAMZ1bEmMXiqYklelaE6isD1dW
	 G/5vFWvANSQYtMXrT6ZaAYCQLGhWkOhnWB0WRshMaqgvQaQxW+phm47qScRaF+oWANguM
	 r92Narz0FwqlDmo+KrfEMSYtxRyp0lS3vBU0192chYlsOJGOKELFA2rdOkLdCmSo5xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SZl/qGFy";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18C0606A31E
	for <virtualization@lists.linux.dev>; Fri, 23 Oct 2026 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SZl/qGFy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0851F01825;
	Fri, 23 Oct 2026 12:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792760348;
	bh=cBC+shEKAh6fnx4DLc51NsNyomNOLmcjHuReAIR5ZNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SZl/qGFyAcI3/XxVnWAWn09uhiUcPFdoqVbC3XkZVZ8kuPxU4OMrW8t7s4rcw6Kib
	 v/HRk47NK68bkMjKdzcB8BmQiJR5elwgYZphFDJtXg2Ak8qEFfphu+HBvKik3D7o7I
	 ga7NmXAPfPHzI/hTg+4s7wcIWNVCYGFQ9g3PNJEPFoinqwIcjP6EGAI6vMvkmf2KGZ
	 A93x4aDn02K8JrNg36tVx7xkcgA58jaQKRxIq/3jFMQZQoESypRqo3WRb3utrQ4acr
	 K8IOKooTegjZhvDBpoGu8jIDzmZPdArVahVSxHcc4pLRfwEvR3KsZVhxj6gugFqZgZ
	 X4Y2goij3sZ5g==
Message-ID: <sashiko-outbox-182807@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v5 6/7] net: add ip4_parse()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <65a4d0ba37073c48d75251039882161efe5a4025.1792668082.git.mst@redhat.com>
References: <cover.v5.git.mst@redhat.com>
 <65a4d0ba37073c48d75251039882161efe5a4025.1792668082.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 12:59:08 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] net: use-after-free of iph in ip4_parse() after pskb_may_pull()
--

commit f0109d51e8b0adc3b479c25e0e4799b7ae07962f
Author: Michael S. Tsirkin <mst@redhat.com>

net: add ip4_parse()

This commit introduces the ip4_parse() helper in include/linux/ip.h to
pull and minimally validate an IPv4 header and its options, converting
several callers in virtio_net, bridge netfilter, ipv4 input, and
netfilter ipv4 reject.

> diff --git a/include/linux/ip.h b/include/linux/ip.h
> index d11c25f5030a0..7e047d18a61c9 100644
> --- a/include/linux/ip.h
> +++ b/include/linux/ip.h
> @@ -56,4 +56,41 @@ static inline void iph_set_totlen(struct iphdr *iph, u=
nsigned int len)
>  {
>  	iph->tot_len =3D len <=3D IP_MAX_MTU ? htons(len) : 0;
>  }
> +
> +/**
> + * ip4_parse - pull and minimally validate an IPv4 header
> + * @skb: buffer to parse
> + * @nhoff: offset of the IPv4 header within the linear data
> + * @thoff: returns the transport header offset
> + *
> + * The whole header, options included, is guaranteed linear on
> + * return, so the transport header offset is within the linear
> + * data.  Callers that need to read the transport header must
> + * pull further.
> + *
> + * Return: the validated IPv4 header, or NULL if truncated or
> + * malformed.
> + */
> +static inline struct iphdr *ip4_parse(struct sk_buff *skb,
> +				      unsigned int nhoff,
> +				      unsigned int *thoff)
> +{
> +	struct iphdr *iph;
> +
> +	if (!pskb_may_pull(skb, nhoff + sizeof(struct iphdr)))
> +		return NULL;
> +
> +	iph =3D (struct iphdr *)(skb->data + nhoff);
> +	if (iph->version !=3D 4 || iph->ihl < sizeof(struct iphdr) / sizeof(u32=
))
> +		return NULL;
> +
> +	/* Pull the options as well: the transport header offset
> +	 * returned below must be within the linear data.
> +	 */
> +	if (!pskb_may_pull(skb, nhoff + iph->ihl * sizeof(u32)))
> +		return NULL;
> +
> +	*thoff =3D nhoff + iph->ihl * sizeof(u32);

[Severity: Critical]
Can this dereference of iph->ihl after the second pskb_may_pull() cause a
use-after-free?

In include/linux/ip.h:ip4_parse(), iph is initialized to point into
skb->data before the second pskb_may_pull() call pulls the IPv4 options.

When IPv4 options (ihl > 5) reside in non-linear skb data and either
skb_cloned(skb) is true or skb->head lacks tailroom (or when
skb_might_realloc() triggers), the call chain:

  pskb_may_pull()
    pskb_may_pull_reason()
      __pskb_pull_tail()
        pskb_expand_head()

allocates a new skb->head buffer, updates skb->data, and frees the old
buffer that iph points into. Reading iph->ihl again afterward to compute
*thoff accesses freed memory before skb->data + nhoff is recomputed for
the return value.

Would computing *thoff =3D nhoff + iph->ihl * sizeof(u32) before calling
pskb_may_pull(skb, *thoff) avoid dereferencing the stale iph pointer?

> +	return (struct iphdr *)(skb->data + nhoff);
> +}
>  #endif	/* _LINUX_IP_H */

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.v5.git.mst@re=
dhat.com?part=3D6
