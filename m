Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873321;
	b=jUQlYT7vWoi0sJu0M5Ood8XeTIxzwJNVJywLpNAPlkbdxVI/DJM05Qmr2OWEsA4ucoA5
	 Npv9OApMGTWh45XZUQO5K33ljmgDt6vnvxOWa7FBmY5agFVispDRRck/8CAwHVqIBkMsm
	 5CMxXrsdCbyvn7XbvDdbiLwu5rBrv006l4bP3EHEPh2LpCxoBBYi2iW0An/cOGdqqjLbC
	 XCjmr87PWVwuXqdKhBu8lU2aKoQv9MsCTUbmRQcCDyG11C3EVcJG0N9PZz7490xG1Ncuo
	 9AqEP3Uq3Z/add4ZSfthf+QOA4zztp5ofNbGD8gEo3VBaDIax9MhHBHRd8DB0Ea/Uxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873321;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wIxxpB17hNgExfs2az82lEEQ+QlFbh36g46wcZUbL6Y=;
	b=rc5EKfvR9d9Vg/eVa+SoLjUFRSZ2slbiCo4eN3Jiee+Bw+5IhXuEWWyZl1Qnh7Qh/qKI
	 SHIrsQqeadceyJZrw4u7vI7uz5ZZHfsHPU/fzm1vhRySqVFKXjyA21D2OV6u1oY4wgWX1
	 Q3mO8M8vtVTafOUbQkSqQledWYywcfZd7YqBLnCkZUrMNpFAPcrRbyI9MV6AbYdw/mtRO
	 ixDhLd/nzr2RBhOK3V/KgaSrhPW1HBHTU8LfSfVd4Nvwsg8wpZTOTQU4684BuoPhMCw+7
	 DxS5YHsz/HNake1+dSgi0HtgJRfp2CX077pYfkr7nXQ+wRNzho7ogdmVA+ODQbQqnuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XWv+lxJ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A7A60A262D;
	Thu,  5 Nov 2026 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XWv+lxJ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2D91F000C1;
	Thu,  5 Nov 2026 10:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793873321;
	bh=wIxxpB17hNgExfs2az82lEEQ+QlFbh36g46wcZUbL6Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XWv+lxJ/e12QZp2MdAWZN/IqEtDtrSfhlLeNT7YDN4IyiRgUNw2qChocBWFYM2JdZ
	 25FgbwtKEZG6VvhOyDC6IV/xI/009j5ez6U8s+DxFC3DVoe0cdh7zmTguiZSZLc6vE
	 +XJHSZ2ge2sf0OG7Dj6GwzCkiDtOzKzU2GwOSlclawJBf/MtKYPVSw5rioGd0gBe7E
	 D6C+ErF2wajjtj/jtrOatE//LULXS/M1NtDXQYS4l23uwMvUzLXKtH3vrpem4owwpe
	 j6aDEWlKb1llg+SVjzGhvcOb6rawvXhBGw0B8TyeLaeM6niP0wA5v4hkGa1smZMGjT
	 tGcfqjQ3aYhsw==
Subject: Re: [PATCH net v2 1/3] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, mst@redhat.com,
 eperezma@redhat.com, hassansultan@google.com, virtualization@lists.linux.dev
Date: Thu, 05 Nov 2026 10:08:40 +0000
Message-ID: <179387332014.488856.9111956413610107951@kernel.org>
In-Reply-To: <20261104050131.629967-2-edumazet@kernel.org>
References: <20261104050131.629967-2-edumazet@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new outer-header validator can still be bypassed, so the
  NSH-over-UDP-tunnel GSO crash this commit claims to fix is still…
- [Low] In virtio_net_l4_start() (include/linux/virtio_net.h), the
  comment before the ipv6_find_hdr() call says "Find the transport…

--

net: virtio: validate outer protocol of UDP tunnel GSO packets

This commit makes virtio_net_hdr_tnl_to_skb() validate the outer headers
of UDP tunnel GSO packets. The frame must carry an outer IPv4 or IPv6
header that matches the declared tunnel type, with UDP at
outer_th_offset. The L3 start is taken from the device type: either an
Ethernet/VLAN header, or the network header the caller set.

Link: https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com/

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd00..b9c8babb1fd73 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h

[ ... ]

> @@ -48,6 +51,146 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,

[ ... ]

> +static inline bool
> +virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
> +{
> +	/* skb->dev should always be set here already,
> +	 * but let's not crash when it is not.
> +	 */
> +	if (WARN_ON_ONCE(!skb->dev))
> +		return false;
> +
> +	if (skb->dev->type == ARPHRD_ETHER ||
> +	    skb->dev->type == ARPHRD_LOOPBACK) {
> +		__be16 h_proto;
> +
> +		if (!pskb_may_pull(skb, ETH_HLEN))
> +			return false;
> +		h_proto = eth_hdr(skb)->h_proto;
> +		/* skb->protocol is a sender claim, and parts of the
> +		 * stack parse the packet per it: when it disagrees with
> +		 * the frame we do not know which view the packet will
> +		 * be parsed as, so do not validate.
> +		 */
> +		if (skb->protocol && skb->protocol != h_proto)
> +			return false;
> +		*nhoff = ETH_HLEN;
> +		*proto = h_proto;
> +		if (eth_type_vlan(*proto)) {
> +			*proto = __vlan_get_protocol(skb, *proto, nhoff);
> +			if (!*proto)
> +				return false;
> +		}
> +	} else {
> +		const struct iphdr *iph;
> +
> +		*nhoff = skb_network_offset(skb);
> +		/* An unset network header shows up as an offset
> +		 * outside of the packet.
> +		 */
> +		if (*nhoff < 0 || (unsigned int)*nhoff >= skb->len)
> +			return false;
> +		/* No L2 header to cross-check with: take the protocol
> +		 * from the IP version at the network header.
> +		 */
> +		if (!pskb_may_pull(skb, *nhoff + 1))
> +			return false;
> +		iph = (const struct iphdr *)(skb->data + *nhoff);
> +		if (iph->version == 4)
> +			*proto = htons(ETH_P_IP);
> +		else if (iph->version == 6)
> +			*proto = htons(ETH_P_IPV6);
> +		else
> +			return false;
> +		if (skb->protocol && skb->protocol != *proto)
> +			return false;
> +	}
> +	return true;
> +}

[Severity: High]

Can a tap owner push this function into the wrong branch, so the NSH
crash from the commit message is still reachable?

The branch is chosen from skb->dev->type. In tun, the real framing and the
later eth_type_trans() call both follow tun->flags. The tap owner can set
dev->type to any value with TUNSETLINK while the device is down:

drivers/net/tun.c:__tun_chr_ioctl() {
    ...
			tun->dev->type = (int) arg;
    ...
}

Take an IFF_TAP device with dev->type set to, for example, ARPHRD_NONE.
tun_get_user() does:

		skb_set_network_header(skb, ETH_HLEN);
	...
	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
	...
	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
		skb->protocol = eth_type_trans(skb, tun->dev);

In that case virtio_net_l3_start() takes the else branch with
nhoff = ETH_HLEN and only reads the IP version nibble at byte 14.

The skb->protocol cross-check is skipped because skb->protocol is still 0
at this point. h_proto in bytes 12-13 is never read.

With a valid IPv4 header at offset 14 and UDP at offset 34,
virtio_net_tnl_offsets_ok() returns true. eth_type_trans() then sets
skb->protocol from the unchecked h_proto, for example ETH_P_NSH, while
SKB_GSO_UDP_TUNNEL is set. tun_xdp_one() has the same order: validation
first, then an unconditional eth_type_trans().

If that skb is redirected with tc mirred to a gretap, does it reach the
same crash shown in the commit message?

validate_xmit_skb()
  skb_mac_gso_segment()
    nsh_gso_segment()
...
gre_tap_xmit()
  __gre_xmit()
    skb_push()
      skb_under_panic()

Compared with the original reproducer, the only extra step seems to be
one TUNSETLINK ioctl before bringing the tap up.

There is a second variant: an IFF_TUN device with a packet-info header
and dev->type set to ARPHRD_ETHER.

With pi.proto = 0x8100 and bytes 12-13 = 0x8100, the cross-check passes.
The validator then walks a VLAN tag at 14 to IPv4 at 18 and UDP at 38.

The stack handles the packet as raw L3, though. skb_vlan_untag() reads
the VLAN header at data[0], so attacker-chosen bytes 2-3 (for example
NSH) become skb->protocol.

The skb->protocol cross-check cannot catch either case. In the first it
is 0, and in the second the sender controls both values.

vhost-net guests cannot change dev->type, so the guest path looks closed.
The tap writer path named in the commit message still seems open.

A smaller point: dev->type is read here without READ_ONCE() or a lock,
while TUNSETLINK writes it under rtnl. The bypass above does not need
that race, though, since a stable mismatched type is enough.

Could the caller tell the validator whether the frame starts with an
Ethernet header instead? tun knows this from tun->flags, and virtio_net
always has one. Another option would be to always cross-check h_proto
whenever eth_type_trans() will be applied afterwards.

[ ... ]

> +	if (proto == htons(ETH_P_IPV6)) {
> +		const struct ipv6hdr *iph;
> +		int flags = IP6_FH_F_AUTH;
> +
> +		if (!pskb_may_pull(skb, nhoff + sizeof(*iph)))
> +			return false;
> +		iph = (const void *)(skb->data + nhoff);
> +		if (iph->version != 6)
> +			return false;
> +		*thoff = nhoff + sizeof(*iph);
> +		*ip_proto = iph->nexthdr;
> +		if (*ip_proto != IPPROTO_TCP && *ip_proto != IPPROTO_UDP) {
> +			*thoff = nhoff;
> +			/* Find the transport header behind any
> +			 * extension headers, AH included.
> +			 */
> +			*ip_proto = ipv6_find_hdr(skb, thoff, -1, NULL,
> +						  &flags);

[Severity: Low]

This isn't a bug, but the comment says the walk goes past AH. With
flags = IP6_FH_F_AUTH and target = -1, ipv6_find_hdr() actually stops at
the AH header:

net/ipv6/exthdrs_core.c:ipv6_find_hdr() {
    ...
		} else if (nexthdr == NEXTHDR_AUTH) {
			if (flags && (*flags & IP6_FH_F_AUTH) && (target < 0))
				break;
    ...
}

It returns NEXTHDR_AUTH, so an outer IPv6+AH+UDP frame is rejected. That
matches the commit message ("ipv6_find_hdr() stops at an AH header").

Could the comment say that the walk stops at AH? As written, a reader
might take it as a reason to drop IP6_FH_F_AUTH later.

> +			if (*ip_proto < 0 || flags & IP6_FH_F_FRAG)
> +				return false;
> +		}
> +		return true;
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104050131.629967-1-edumazet%40kernel.org
