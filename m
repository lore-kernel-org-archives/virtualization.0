Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792906268;
	b=3JvH/+wO3wAa4TRHwkfufpekA0ykzwXZBzOd98Au/SOl6lmIN7KzT5PuhFNnN8vWEsJo
	 JcdMdbDms6T35XOcMA0hXAGXihuOG9c0nDjFCOMqWo04nfPYggCxm1C4RiVcng/wwbcoJ
	 JNb94YqPjNqgurKzcW8jVeUlbakLiWFkt/05W7jYvlJbpiGnuM8P4XFmRpGI7m1LQD8U9
	 dEyPzQ8KTuWz5w1d9PLTtpytMWGNOaxYTHApP+wfXSzueucYAiYGbUMCMc+fORgKPVVP0
	 J2M/D4ZrIuP08IfI5XLHUbvhmrGGRbehnkUJGzV+N6Htg4xFEAETzoESsGV8628ZGNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792906268;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=EmGIJEeTF2IoA6PLnnXO2EtBG7lvQbnG1ggSXKw1uJY=;
	b=0SZIK3ODMQHvgXhQWQWZKlw2BfkyPVeGXEROhDqr1ErUzaCQ7wSMFa2QApsVq1pdo6hk
	 xN/9pquH+ubtmUYX7n5CQEwqzVaRpw3XLOKfXp1vSHnbqR1JVFs2foKPyZbpZNbeKZ9GV
	 DNaFXz6dJzHJbvXjclYTMmEYqY5d+yPvQdV+yz7M2MJvaBxJ3d6bqHRjuajNuseKahG2J
	 eFniF0SWs0loA6tB3p1KZq9feQIuSi1WfM/tH6TecZAq7rBfoMMifQy2QccDEI1LExPq7
	 IORz8o9drQnoy8qpCWhsHlFAbZOB52NCSSEVhRuMQc0tiBPSaK9EEGUcc09VEk7cU2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mDwltRpe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DB060A2602;
	Sun, 25 Oct 2026 05:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mDwltRpe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7441F01825;
	Sun, 25 Oct 2026 05:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792906267;
	bh=EmGIJEeTF2IoA6PLnnXO2EtBG7lvQbnG1ggSXKw1uJY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mDwltRpe22VDhRHOnpLAnj+aUl6UByT0IOMD+T4h5FGPcaxiG7JbnvtoBjENpkGja
	 v1BSOtCsIhAy0TZUlBmzkh+kDBvzonPKKF6Jhq88PQwSl7M7Mc2/nFwrf1kRzmGZ9b
	 ZutkHSgEpt/2fUoD/foStTfFrt9HoCa99q0QqV6VvGuWlItUOGqY0Gt3YzvEtZTuev
	 xk1IZp9rdM/3dc3S48SgcfBvovdKqWecGNKrzPv6qODRuUNyTElNtmH8TCSJtGigWJ
	 Ttjq6vGImVXQbsqvkCjw87aOREFaa4FIJF2aVxO8XVKLSR8xbYzXfS0GGxwO8fs6MM
	 qHQ8QLQocz3Dg==
Subject: Re: [PATCH net v5 6/7] net: add ip4_parse()
From: netdev-bot+sashiko@kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 carges@cloudflare.com, bjorn@kernel.org, phil@nwl.cc, jasowangio@gmail.com,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev, maxk@qualcomm.com,
 rusty@rustcorp.com.au
Date: Sun, 25 Oct 2026 05:31:06 +0000
Message-ID: <179290626608.3134.7140571049863955668@kernel.org>
In-Reply-To:
 <65a4d0ba37073c48d75251039882161efe5a4025.1792668082.git.mst@redhat.com>
References:
 <65a4d0ba37073c48d75251039882161efe5a4025.1792668082.git.mst@redhat.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Use-after-free read in the new ip4_parse() helper
  (include/linux/ip.h).
- [Low] The commit message presents the patch as adding a new helper for
  open-coded checks.
- [Low] The kernel-doc for ip4_parse() says "The whole header, options
  included, is guaranteed linear on return", and the helper does…

--

net: add ip4_parse()

This commit adds an ip4_parse() helper to include/linux/ip.h. The helper
pulls the IPv4 header including options, checks the version and IHL, and
returns the transport header offset. It replaces virtio_net_ip4_parse() and
converts ip_rcv_core(), br_validate_ipv4() and nf_reject_iphdr_validate()
to use it.

> diff --git a/include/linux/ip.h b/include/linux/ip.h
> index d11c25f5030a0..7e047d18a61c9 100644
> --- a/include/linux/ip.h
> +++ b/include/linux/ip.h
> @@ -56,4 +56,41 @@ static inline void iph_set_totlen(struct iphdr *iph, unsigned int len)
>  {
>  	iph->tot_len = len <= IP_MAX_MTU ? htons(len) : 0;
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
> +	iph = (struct iphdr *)(skb->data + nhoff);
> +	if (iph->version != 4 || iph->ihl < sizeof(struct iphdr) / sizeof(u32))
> +		return NULL;
> +
> +	/* Pull the options as well: the transport header offset
> +	 * returned below must be within the linear data.
> +	 */
> +	if (!pskb_may_pull(skb, nhoff + iph->ihl * sizeof(u32)))
> +		return NULL;
> +
> +	*thoff = nhoff + iph->ihl * sizeof(u32);

[Severity: High]
Can this read iph->ihl from a freed skb head?

iph is computed from skb->data after the first pskb_may_pull(). If the
options are not linear yet, the second pskb_may_pull() can go through
__pskb_pull_tail() -> pskb_expand_head(), which reallocates the head:

net/core/skbuff.c:__pskb_pull_tail() {
    ...
	if (eat > 0 || skb_cloned(skb)) {
		if (pskb_expand_head(skb, 0, eat > 0 ? eat + 128 : 0,
				     GFP_ATOMIC))
    ...
}

When the head is not shared, pskb_expand_head() calls skb_free_head() on
the old buffer. When the skb is cloned, it drops the dataref instead.

pskb_may_pull_reason() also calls skb_might_realloc(). With
CONFIG_FAIL_SKB_REALLOC the head is therefore reallocated on every call,
and KASAN should catch the stale read.

The __pskb_pull_tail() kernel-doc says: "All the pointers pointing into skb
header may change and must be reloaded after call to this function."

Only the return value is rebuilt from skb->data. The *thoff calculation
above still reads through the old iph.

The stale thoff is then used in several places:

- the len < thoff checks in ip_rcv_core(), br_validate_ipv4() and
  nf_reject_iphdr_validate()
- the csum_start comparison in
  virtio_net_l4_start()->virtio_net_csum_partial_ok_at_offset()

Suppose the freed byte has changed, for example because of init_on_free,
and thoff comes out as nhoff. Could a packet with ihl=15 and tot_len=20
then pass the len < thoff check? It would be trimmed below its header
length, and skb->transport_header would end up past the tail.

In the virtio path, could csum_start == nhoff with a TCP csum_offset then
pass validation? That would defeat the check added by "net: resolve
uncommon partial checksums at ingress".

The old virtio_net_ip4_parse() did only one pull. This seems to come from
the v5 change that also pulls the options.

The last patch in the series ("virtio_net: cleanup protocol calculation")
doesn't change ip4_parse(), so the problem appears to still be there at
the end of the series.

Would it work to compute the header length before the second pull, and to
use only the pointer rebuilt from skb->data after it? For example:

	hlen = iph->ihl * sizeof(u32);
	if (!pskb_may_pull(skb, nhoff + hlen))
		return NULL;

	*thoff = nhoff + hlen;
	return (struct iphdr *)(skb->data + nhoff);

> +	return (struct iphdr *)(skb->data + nhoff);
> +}
>  #endif	/* _LINUX_IP_H */

[ ... ]

> diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
> index 9860178752b8c..5adf01763e857 100644
> --- a/net/ipv4/ip_input.c
> +++ b/net/ipv4/ip_input.c

[ ... ]

> @@ -520,10 +520,6 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
>  	}
>  
>  	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
> -	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
> -		goto inhdr_error;
> -
> -	iph = ip_hdr(skb);
>  
>  	/*
>  	 *	RFC1122: 3.2.1.2 MUST silently discard any IP frame that fails the checksum.
> @@ -536,7 +532,8 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
>  	 *	4.	Doesn't have a bogus length
>  	 */
>  
> -	if (iph->ihl < 5 || iph->version != 4)
> +	iph = ip4_parse(skb, 0, &thoff);
> +	if (!iph)
>  		goto inhdr_error;
>  
>  	BUILD_BUG_ON(IPSTATS_MIB_ECT1PKTS != IPSTATS_MIB_NOECTPKTS + INET_ECN_ECT_1);

[Severity: Low]
The ihl * 4 pull now happens inside ip4_parse(), which runs before the ECN
accounting a few lines below:

	__IP_ADD_STATS(net,
		       IPSTATS_MIB_NOECTPKTS + (iph->tos & INET_ECN_MASK),
		       max_t(unsigned short, 1, skb_shinfo(skb)->gso_segs));

Before this patch, only the fixed 20 byte header was pulled before the
stats update, and the ihl * 4 pull came after it.

Is it intended that an IPv4 packet with ihl > 5 and truncated options, or
one whose pull fails to allocate, is no longer counted in the Ip ECN
counters? It is still counted in InHdrErrors.

The commit message also says:

  "Add a helper for doing that: it returns the validated header and
  the transport header offset, or NULL if truncated or malformed."

It doesn't mention that virtio_net_ip4_parse() is removed from
include/linux/virtio_net.h and renamed. It also doesn't mention that the
contract changes from "Only the fixed header is guaranteed linear" to
pulling the options as well.

Only the v4->v5 note below the cut mentions this, and that note won't be
kept in git history. Could the commit message describe these changes?

[ ... ]

> @@ -546,7 +543,7 @@ static struct sk_buff *ip_rcv_core(struct sk_buff *skb, struct net *net)
>  		       IPSTATS_MIB_NOECTPKTS + (iph->tos & INET_ECN_MASK),
>  		       max_t(unsigned short, 1, skb_shinfo(skb)->gso_segs));
>  
> -	if (!pskb_may_pull(skb, iph->ihl*4))
> +	if (!pskb_may_pull(skb, thoff))
>  		goto inhdr_error;
>  
>  	iph = ip_hdr(skb);

[Severity: Low]
This isn't a bug, but ip4_parse() has already done
pskb_may_pull(skb, nhoff + iph->ihl * sizeof(u32)) with nhoff = 0, which is
exactly thoff. Its kernel-doc also says the options are guaranteed linear
on return.

Doesn't that mean this pull can never fail, so the goto inhdr_error branch
is dead code?

br_validate_ipv4() and nf_reject_iphdr_validate() have the same redundant
pskb_may_pull(skb, thoff).

The iph = ip_hdr(skb) reloads after the pull in ip_rcv_core() and
br_validate_ipv4() also look unnecessary, because ip4_parse() already
returns a pointer rebuilt from skb->data.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.v5.git.mst%40redhat.com
