Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339504;
	b=kJf7uawGBM1c72vXVNlqV1APbmAj9tnW6THd6FnhSZIQxjjpeX0oIXPWoAavPyh58CTG
	 +wGgbZOdz+Z92QOTmr+tDmdzTdKskZO1xxxiCEl5arCM0Xd41lpcUnXIWiTtNA/pY8sO2
	 EOtLOu/ZqG4DakgX+HSjIHj8OWBjJ8jG+0mQI704pMalP9hMpAU/HjbJss0ysDJYvG18B
	 f6iaSGGBc3pLmMD43P4CW8VGXFx1V0+Msxmh6h0JeYjzC6sKD6Ls9mGEYsRFdA26VfnGN
	 S6BprRIK5SHwwCe1hVWCfwSq/FviA7pWUvtD3NwjIJj+kWTO6Wf5fpdGVd5ZZTOE59g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339504;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=HYeaoLZHfc6DguZjMIu546vWTeD0qOXjf3LCr1wfTkU=;
	b=kwppiUaQLy2JdxI3tx9VspN7TmVVlls2hiqxsnxPJNi1rDGH+MIMD8fE7HL5OCFpZxxi
	 h/uB6ORXfSYkOOplKy2C0g8gs3SeIOZEQEjKFKR4JJDNtbuH2Eo1sVhrRMasMD4GQkrUu
	 kLrQOM1x96hb0mLVf8vkNLpG3bT7Nnr5qXTMji9/u4RMO7TXJuFM6tpyFAaQF8MXhlLnS
	 sz3WXiMz2HqgEjkekAxhdujSFPq8calI83wedmRSvP4Ol9dNoQ/gDb5K7uJcd0rrRainF
	 DQkkdmb8g3HcKGn7lTMB+uw8YkeHLJRVUZyfoZFCxiJZnaUWXy5felVcshYFa+0QhcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="AD9Gf/Nn";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFD0606A333;
	Tue, 10 Nov 2026 19:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AD9Gf/Nn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AE81F008A1;
	Tue, 10 Nov 2026 19:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339503;
	bh=HYeaoLZHfc6DguZjMIu546vWTeD0qOXjf3LCr1wfTkU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AD9Gf/NnWPp/+A1XckuqMvw3CovptjH4dHKaJ6KNVifpVThGXBL5TyTtBONYeEAVU
	 ohuHrUPgph27A3aYGFMjqnvQgqE9KruVQ1unbmouGH+xqU3nkaIo+eC2N3VR6xE/6d
	 mrCzCv94desobziRuqQ4aS7gwdn+Uhta2pSz4/s2CAbtBWtCTmJYKhGmFLAVmaZVr1
	 83iCDiEh+FDKqACPinf9Nd1l1IQ5XbhRzEz6jXmObxooLpIwm70sLRYHE5Yuql4LXk
	 3RM6/BSft6tIUQqCOh2GAYuUqvOKWRMQwycTr1Te67o59XMUpo/zPNIXnJu/0JTkqt
	 1CAI7nCgkB0TA==
Subject: Re: [PATCH net v5 2/3] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, willemb@google.com, mst@redhat.com,
 jasowangio@gmail.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 hassansultan@google.com, virtualization@lists.linux.dev,
 sashiko-bot@kernel.org
Date: Tue, 10 Nov 2026 19:38:22 +0000
Message-ID: <179433950226.994134.600618537237720502@kernel.org>
In-Reply-To: <20261109163507.3102091-3-edumazet@kernel.org>
References: <20261109163507.3102091-3-edumazet@kernel.org>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new check in virtio_net_tnl_offsets_ok()
  (include/linux/virtio_net.h:442), `if (outer_isv6 != (proto ==…
- [Medium] virtio_net_l3_start() (include/linux/virtio_net.h:112) rejects
  the frame when a non-zero skb->protocol differs from the Ethernet…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch's
  new has_eth=false path is effectively unreachable for valid frames.

--

net: virtio: validate outer protocol of UDP tunnel GSO packets

This patch makes virtio_net_hdr_tnl_to_skb() check that the frame really
carries the outer IPv4/IPv6 and UDP headers that the virtio UDP tunnel GSO
header claims. It rejects frames with mismatched ethertypes, fragments, or
wrong offsets. Callers now pass a new has_eth argument that says whether
the frame starts with an Ethernet header.

Link: https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com/

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index ab44342cf09f7..0b7a8569812fe 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h

[ ... ]

> @@ -48,6 +51,145 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,

[ ... ]

> +static inline bool
> +virtio_net_l3_start(struct sk_buff *skb, bool has_eth, int *nhoff,
> +		    __be16 *proto)
> +{
> +	if (has_eth) {
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

[Severity: Medium]
On the tun IFF_NAPI_FRAGS path, can a stale skb->protocol cause valid
frames to be rejected here?

In that mode tun_get_user() gets the skb from napi_get_frags(). If GRO
merged the previous frame with GRO_MERGED_FREE, napi_reuse_skb() recycles
the skb without clearing skb->protocol. That field still holds the
previous frame's h_proto, set by napi_frags_skb().

tun_get_user() reaches this check before eth_type_trans() updates
skb->protocol:

tun_get_user()
    tun_vnet_hdr_tnl_to_skb()
        virtio_net_hdr_tnl_to_skb()
            virtio_net_tnl_offsets_ok()
                virtio_net_l3_start()
    ...
    skb->protocol = eth_type_trans(skb, tun->dev);

With only this patch applied, a valid UDP tunnel GSO frame can have a
different ethertype from the previous frame (IPv6 after IPv4, or VLAN
tagged after untagged). Would that frame be dropped with -EINVAL and
counted in rx_frame_errors?

The next patch in the series, "tun: clear stale skb->protocol of NAPI
frags skbs", fixes this by setting skb->protocol = 0 in
tun_napi_alloc_frags() right after napi_get_frags(). Could that fix go
before this patch, so this regression never shows up between the two
commits?

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

[Severity: Medium]
This isn't a bug introduced by this patch, but can this has_eth == false
branch ever accept a valid frame?

For IFF_TUN, tun_get_user() resets the network header to offset 0 and
passes has_eth = false, so nhoff is 0 here. virtio_net_tnl_offsets_ok()
then requires outer_th to equal the real transport offset. That is 20 for
IPv4 without options, or 40 for IPv6 without extension headers.

Before that check, virtio_net_hdr_tnl_to_skb() still applies an
Ethernet-sized minimum, whatever has_eth is:

include/linux/virtio_net.h:virtio_net_hdr_tnl_to_skb() {
    ...
	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);
    ...
	if (outer_th < outer_l3min ||
	    inner_nh < outer_th + sizeof(struct udphdr) ||
	    inner_th < inner_nh + inner_l3min)
		return -EINVAL;
    ...
}

That minimum is 34 or 54. A frame only passes both checks if it carries at
least 16 bytes of IPv4 options or 14 bytes of IPv6 extension headers.

The TX side also produces offsets that the RX side rejects. In
tun_put_user()->virtio_net_hdr_tnl_from_skb(), outer_th is computed
relative to skb->data, and an IFF_TUN frame has no Ethernet header:

	outer_th = skb->transport_header - skb_headroom(skb) + vlan_hlen;

tun_set_offload() also lets IFF_TUN enable UDP tunnel GSO.

Should outer_l3min leave out the ETH_HLEN term when has_eth is false?

[ ... ]

> @@ -282,9 +424,33 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
>  	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
>  }
>  
> +/* Do the tunnel offsets match the outer headers in the frame?
> + * The L3 header the tunnel claims must be the one the frame
> + * carries, with UDP following it at @outer_th.
> + */
> +static inline bool
> +virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool has_eth, bool outer_isv6,
> +			  unsigned int outer_th)
> +{
> +	int nhoff;
> +	__be16 proto;
> +	unsigned int thoff;
> +	int ip_proto;
> +
> +	if (!virtio_net_l3_start(skb, has_eth, &nhoff, &proto))
> +		return false;
> +	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
> +		return false;

[Severity: Medium]
Could this check drop frames built by the kernel's own producer?

virtio_net_hdr_tnl_from_skb() picks the tunnel family from skb->protocol:

	if (skb->protocol == htons(ETH_P_IPV6))
		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
	else
		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4;

When the VLAN tag is inline, skb->protocol is ETH_P_8021Q or
ETH_P_8021AD, so a frame with an IPv6 outer header gets labelled IPV4.

This looks deterministic for a virtio_net guest that sends VXLAN or Geneve
over an IPv6 underlay on a VLAN subinterface. virtio_net never advertises
NETIF_F_HW_VLAN_CTAG_TX, but it keeps NETIF_F_GSO_UDP_TUNNEL in
vlan_features, so the tag is pushed inline while the skb is still GSO:

vlan_dev_hard_start_xmit()          /* tag kept as hwaccel */
...
validate_xmit_vlan()
  __vlan_hwaccel_push_inside()
    vlan_insert_tag_set_proto()     /* skb->protocol = vlan_proto */
...
xmit_skb()
  virtio_net_hdr_tnl_from_skb()     /* labelled GSO_UDP_TUNNEL_IPV4 */

Before this patch, the host only checked outer_th against ETH_HLEN plus
the IPv4 minimum, so it accepted the frame. GSO later parsed
8021Q -> IPv6 -> UDP and segmented it correctly.

With this patch, virtio_net_l3_start() walks past the tag and finds
ETH_P_IPV6 while outer_isv6 is false. tun_get_user() and tun_xdp_one()
then drop the frame with -EINVAL and increment rx_frame_errors.

The same mislabel can happen from host to guest through tun_put_user()
when the C-tag is inline, for example QinQ with a hwaccel S-tag. In that
case virtnet_receive_done() would drop the frame as "bad gso".

In all these cases the offsets are correct and only the family label is
wrong. The commit message does not mention this change in behaviour.

Should virtio_net_hdr_tnl_from_skb() derive the family with something like
vlan_get_protocol() or skb_network_protocol() as part of this fix?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109163507.3102091-1-edumazet%40kernel.org
