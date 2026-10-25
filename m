Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792906265;
	b=bFW8Y9onEkM1iBE9IeT5qb9GkVAXzGJrgrL0sT0B1m1RLz23nzZ68iuRarln9OlDpaeK
	 dH0bhXDA14N0bQtPoJC/vNNFhLBRccoKDbaVZawr7Jw2nnNtq7oHRZIuxtc1x7y0tVy+m
	 Y7za4inesv/z/gY9ckt3acFqqW7jMLSPv2sEY02CTJTUvAh0UklqL8UpgMyXmbnk/tM/p
	 K09ejfYbhN9lTL1YU8FHOXvdQUzPJ0RP2zvzBiC1+WXukrdICATWO7TgCVUknUGZsjmN2
	 A38wPCIae6sM03xw0IbczrzJkf0Yeng83uHm41TPYBhOtPmRbJR0/AcDUQHPNqLX7lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792906265;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=RyF0+g+MIcLYl23LObaWXZ6QZwCzAZtUmcOQoE25osI=;
	b=0n75KJK6yET4u0HBAkYeCZsd7JhpkoVzQrROUv2IkVNRuFy+WQ8mmd38ACiw6vCjwOLF
	 G6HpyRdxWwj+RQFwPMBb2XWGs9KnN7aqgecYt+RTC/zfp0io4K0GgIlNnNigPpWSr1j+d
	 K3DuAfn0XxCuk1ccRnhr1Z07MW6gGBdyPb396BzR0lG8d1K83WJnokfaMrDVaz/qUpmIi
	 cis71eTkSF0QRlh/hax15JLekd4aXOfGmPcvvkLQ6OShGyAYA2gni9yB1L2zqQ6jifihk
	 Cd3yKrvAO4WC2SBwY/r6fLpeQMHJ/YiQWZ3ikVa3ubB7+oO2bzagz7DJoTkrhaF1dFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMZSEISa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFAC606A32E;
	Sun, 25 Oct 2026 05:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMZSEISa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D14B1F01825;
	Sun, 25 Oct 2026 05:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792906264;
	bh=RyF0+g+MIcLYl23LObaWXZ6QZwCzAZtUmcOQoE25osI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZMZSEISauSLlXEcx0HIsXfpN6o8hr6HwTPIY4yJR1pCkTvNeOF/a/GH0+VZlS/Kkw
	 0a8nzvTAFq3UjFCkV2GM3ntXJJcS3Qxg+xrzYWf8XsuGgNgVHxmxF2rT5IUKvK2uFQ
	 usjf1ib4jh+Lq2X4Ls55JsjbblcGcIk/ywXvLC2/QZa6MxZMg5FTWNQbkGDI7wu6xx
	 YW3XlhnC4J+mCCfNSh5ztSMDrWTObdQPp2JCX5MfOiPjkiFtR+3x6u55kEoiWwwTaT
	 1jV/aiw/qYUblhi2EvaP8DwFfylAg99EagyqW6mvq9ARcfsQ8QZJmLrhID3yBmCJf4
	 WaGE/zpXfTpLw==
Subject:
 Re: [PATCH net v5 4/7] net: resolve uncommon partial checksums at ingress
From: netdev-bot+sashiko@kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 carges@cloudflare.com, bjorn@kernel.org, phil@nwl.cc, jasowangio@gmail.com,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev, maxk@qualcomm.com,
 rusty@rustcorp.com.au
Date: Sun, 25 Oct 2026 05:31:02 +0000
Message-ID: <179290626299.3134.10593582137457515812@kernel.org>
In-Reply-To:
 <342bf5331e12b2e5b940510293233bb8bce46127.1792668082.git.mst@redhat.com>
References:
 <342bf5331e12b2e5b940510293233bb8bce46127.1792668082.git.mst@redhat.com>
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 3 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In virtio_net_l3_start() (include/linux/virtio_net.h), a preset
  skb->protocol on ARPHRD_ETHER devices takes priority over the frame's…
- [High] On the tunnel path, the inner checksum validation is anchored at
  the sender-supplied inner_nh_offset.
- [Medium] This patch changes the return contract of
  virtio_net_hdr_to_skb() and virtio_net_hdr_tnl_to_skb(): >0 now means…
- [Medium] The new virtio_net_tnl_offsets_ok() parses through VLAN
  headers and requires outer_th_offset to equal the actual UDP offset in…
- [Medium] virtio_net_hdr_tnl_from_skb() sets
  VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 only when skb->protocol ==…
- [Low] virtio_net_hdr_tnl_to_skb() now returns -EINVAL whenever
  virtio_net_tnl_offsets_ok() fails.
- [Low] The comment '/* A tunnel header implies GSO, so drop.

--

net: resolve uncommon partial checksums at ingress

This patch validates the virtio net header csum_start and csum_offset at
ingress. CHECKSUM_PARTIAL is kept only when they match a parsed TCP or UDP
header. Otherwise, non-GSO packets get their checksum completed in software
and GSO packets are dropped. UDP tunnel headers get the same treatment on
the inner header.

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index 013c6c7e2dea0..52852a33a2db7 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h

[ ... ]

> @@ -48,6 +52,205 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,

[ ... ]

> +static inline bool
> +virtio_net_l3_start(struct sk_buff *skb, int *nhoff, __be16 *proto)
> +{

[ ... ]

> +	/* A preset protocol is what the stack will use, except on
> +	 * loopback which re-parses the frame: loopback_xmit() calls
> +	 * eth_type_trans() on it.
> +	 */
> +	if (skb->dev->type == ARPHRD_ETHER ||
> +	    skb->dev->type == ARPHRD_LOOPBACK) {
> +		if (!pskb_may_pull(skb, ETH_HLEN))
> +			return false;
> +		*nhoff = ETH_HLEN;
> +		*proto = skb->protocol;
> +		if (!*proto || skb->dev->type == ARPHRD_LOOPBACK)
> +			*proto = eth_hdr(skb)->h_proto;

[Severity: High]
Is loopback really the only ARPHRD_ETHER device that re-parses the frame?
veth and the other dev_forward_skb() users also run eth_type_trans() on it:

veth_xmit()
  veth_forward_skb()
    __dev_forward_skb()
      __dev_forward_skb2()
        skb->protocol = eth_type_trans(skb, dev);

Along that path, ____dev_forward_skb() and skb_scrub_packet() leave
CHECKSUM_PARTIAL in place.

On the sending side, packet_snd() installs the protocol the sender chose
before it calls virtio_net_hdr_to_skb():

net/packet/af_packet.c:packet_snd() {
    ...
	if (proto != htons(ETH_P_ALL))
		skb->protocol = proto;
    ...
}

packet_parse_headers() only re-derives the protocol when it is zero.

So an AF_PACKET sender using PACKET_VNET_HDR on a veth could make this
validator parse a different L3 layout from the one the peer stack uses.
CAP_NET_RAW in a user namespace is enough. Two examples:

- preset ETH_P_IP on an 802.1Q-tagged frame: the IPv4 header is parsed
  at offset 14, on top of the TCI

- preset ETH_P_8021Q on an untagged frame: __vlan_get_protocol() reads
  the real tot_len as the encapsulated protocol, and an IPv4 header is
  parsed at offset 18

The fake header only needs version == 4, ihl >= 5, no fragment bits, and
protocol TCP or UDP. A csum_start of nhoff + ihl * 4 with the matching
csum_offset is then accepted.

In the second example, a fake ihl of 5 over a real ihl of 7, with a fake
protocol of UDP, puts the checksum write at packet offset 44. That is the
real TCP destination port.

CHECKSUM_PARTIAL is kept in that case. Netfilter or tc may already have
acted on the packet when a later skb_checksum_help() runs, for example on
egress to a device without checksum offload. That call would then write
into the real TCP header. Isn't that the same post-decision modification
the commit message says this patch closes?

Would it be safer to check eth_hdr(skb)->h_proto against a preset
skb->protocol, or always parse the frame, on every ARPHRD_ETHER device
instead of special-casing loopback?

[ ... ]

> @@ -194,11 +397,35 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +/*
> + * Return value:
> + * 0 - success
> + * >0 - checksum was completed in software (slow path)
> + * <0 - failure
> + */
>  static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
>  					const struct virtio_net_hdr *hdr,
>  					bool little_endian)
>  {
> -	return __virtio_net_hdr_to_skb(skb, hdr, little_endian, hdr->gso_type);
> +	typeof(skb->transport_header) old_transport = skb->transport_header;
> +	int ret = __virtio_net_hdr_to_skb(skb, hdr, little_endian,
> +					  hdr->gso_type);

[ ... ]

> +	skb->transport_header = old_transport;
> +
> +	return __virtio_net_resolve_csum_partial_mismatch(skb);
>  }

[Severity: Medium]
This changes the return contract of virtio_net_hdr_to_skb() and
virtio_net_hdr_tnl_to_skb(): a positive value now means the checksum was
completed in software.

The patch has a Fixes: tag for f43798c27684 ("tun: Allow GSO using
virtio_net_hdr"), so stable is likely to pick it up. The callers are only
updated by earlier patches in the series, "net: account for
ingress-resolved virtio net hdr state" and "um: vector: trim skbs before
verifying the header". Neither has a Fixes: or stable tag, and the commit
message does not mention them.

At the baseline, every caller treats any nonzero return as failure, for
example:

drivers/net/tun.c:tun_get_user() {
    ...
	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
    ...
}

tun_xdp_one(), tap ("if (err)"), tpacket_snd() and packet_snd()
("if (err) goto out_free") do the same.

If this patch is backported alone, would tun, tap and virtio_net drop
every packet whose checksum was completed in software as a frame error?
Would packet_snd() return 1 from sendmsg()? And without the um vector
change, would skb_checksum_help() also checksum the untrimmed buffer tail?

Could the prerequisites get stable tags too, or could the dependency be
noted in the commit message?

> @@ -282,6 +509,35 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
>  	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
>  }
>  
> +/* Do the tunnel offsets match the outer headers in the frame?
> + * The L3 header the tunnel claims must be the one the frame
> + * carries, with UDP following it at @outer_th.
> + */
> +static inline bool
> +virtio_net_tnl_offsets_ok(struct sk_buff *skb, bool outer_isv6,
> +			  unsigned int outer_th)
> +{
> +	int nhoff;
> +	__be16 proto;
> +	unsigned int thoff;
> +	int ip_proto;
> +
> +	if (!virtio_net_l3_start(skb, &nhoff, &proto))
> +		return false;
> +	if (outer_isv6 != (proto == htons(ETH_P_IPV6)))
> +		return false;

[Severity: Medium]
Can this reject IPv6-outer tunnel packets from the in-tree encoder when
they carry an in-band VLAN tag? virtio_net_hdr_tnl_from_skb() picks the
tunnel family from skb->protocol alone:

	if (skb->protocol == htons(ETH_P_IPV6))
		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
	else
		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4;

If skb->protocol is ETH_P_8021Q or ETH_P_8021AD with an in-band tag, an
IPv6 outer header is advertised as IPV4. Such skbs can come from a VLAN
device with REORDER_HDR off, where vlan_dev_hard_header() sets
skb->protocol to vlan->vlan_proto, or from QinQ. tap's
passthru_features_check keeps the GSO features for them.

virtio_net_l3_start() parses through the VLAN header and returns the real
family. The receiver (a guest's virtio_net, or tun ingress) now returns
-EINVAL for packets it used to accept. The encoder's classification is
older, but the drop comes from this new check.

> +	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
> +		return false;
> +
> +	return ip_proto == IPPROTO_UDP && outer_th == thoff;
> +}

[Severity: Medium]
Does this exact match fail for VLAN-tagged UDP tunnel GSO traffic sent by
tun?

For hwaccel tags, tun_vnet_hdr_tnl_from_skb() passes vlan_hlen =
VLAN_HLEN, and tun_put_user() inserts the tag into the exported frame.
virtio_net_hdr_tnl_from_skb() adds vlan_hlen to csum_start but not to
the tunnel offsets:

	inner_nh = skb->inner_network_header - skb_headroom(skb);
	outer_th = skb->transport_header - skb_headroom(skb);
	vhdr->inner_nh_offset = cpu_to_le16(inner_nh);
	vhdr->outer_th_offset = cpu_to_le16(outer_th);

tun's vlan_features include NETIF_F_GSO_UDP_TUNNEL. A UDP tunnel GSO skb
with an hwaccel VLAN tag can therefore reach tun_put_user() unsegmented,
for example VXLAN between VMs across a VLAN-filtering bridge with tagged
tap egress.

The receiving guest's virtnet_receive_done()->virtio_net_hdr_tnl_to_skb()
used to accept these offsets. Now virtio_net_l3_start() parses the 802.1Q
header (nhoff = 18), so thoff ends up 4 bytes past outer_th and the packet
is dropped as a frame error. The inner check at the 4-byte-short inner_nh
would fail as well.

The encoder's omission is older, but isn't this drop new with this
validator?

[ ... ]

> @@ -335,9 +592,12 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	/* Let the basic parsing deal with plain GSO features. */
>  	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
>  				      hdr->gso_type & ~gso_tunnel_type);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;
>  
> +	if (!virtio_net_tnl_offsets_ok(skb, outer_isv6, outer_th))
> +		return -EINVAL;
> +

[Severity: Low]
This drop happens before any GSO or non-GSO distinction. Tunnel packets
too small to be GSO are also dropped when their outer L3/UDP offsets do
not match the frame.

The commit message only describes checksum handling ("UDP tunnel headers
get the same handling on the inner header", "Complete other non-GSO
checksums immediately"). The v5 changelog note ("a packet too small to be
GSO: ignore the tunnel GSO request, complete wild metadata in place")
suggests such packets are completed rather than dropped.

Further down, the patch also clears SKB_GSO_UDP_TUNNEL and
SKB_GSO_UDP_TUNNEL_CSUM for non-GSO skbs without mentioning it.

Could the commit message describe both of these behaviour changes?

[ ... ]

> @@ -368,7 +628,22 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	skb->inner_mac_header = inner_nh + skb_headroom(skb);
>  	skb->transport_header = outer_th + skb_headroom(skb);
>  	skb->encapsulation = 1;
> -	return 0;
> +
> +	if (!skb_is_gso(skb))
> +		skb_shinfo(skb)->gso_type &= ~(SKB_GSO_UDP_TUNNEL_CSUM |
> +					       SKB_GSO_UDP_TUNNEL);
> +
> +	/*
> +	 * We know VIRTIO_NET_HDR_F_NEEDS_CSUM was set so __virtio_net_hdr_to_skb
> +	 * set CHECKSUM_PARTIAL.
> +	 */
> +	inner_proto = inner_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> +	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> +						 inner_proto))
> +		return 0;

[Severity: High]
The inner_nh anchor used here comes from the sender's inner_nh_offset.
Earlier in virtio_net_hdr_tnl_to_skb() it is only checked for ordering:

	if (outer_th < outer_l3min ||
	    inner_nh < outer_th + sizeof(struct udphdr) ||
	    inner_th < inner_nh + inner_l3min)
		return -EINVAL;

Nothing ties it to the real encapsulated header. Can a forged IP-looking
header at inner_nh pass this check while csum_start and csum_offset point
into a different field of the real inner packet?

Take Eth/IPv4/UDP/VXLAN/Eth/IPv4/TCP, with the real inner IP header at 64
and the inner TCP header at 84:

- inner_nh_offset = 52, with the inner MAC bytes chosen so byte 52 is
  0x47 (version 4, ihl 7, so thoff is 80)
- the fake frag_off (src MAC bytes 2-3) is 0
- the fake protocol (src MAC byte 5) is 17
- gso_type is UDP_L4, csum_start = 80, csum_offset = 6

The checksum then lands at offset 86, which is the real inner TCP
destination port.

If gso_size is larger than the payload, the skb is not GSO. The tunnel
GSO bits are cleared, CHECKSUM_PARTIAL stays, and 0 is returned.

After VXLAN decap through iptunnel_pull_header(), the inner stack and
netfilter see the original dport. A later skb_checksum_help() would then
overwrite it with a value the sender controls.

In the GSO case, the same forged offsets become inner_transport_header
and send segmentation writes to the wrong fields.

Should inner_nh be bound to the real encapsulation, with the checksum
completed or the packet rejected when that cannot be established?

> +
> +	/* A tunnel header implies GSO, so drop. */
> +	return __virtio_net_resolve_csum_partial_mismatch(skb);
>  }

[Severity: Low]
This isn't a bug, but the comment does not match the code.
__virtio_net_resolve_csum_partial_mismatch() returns -EINVAL only when
skb_is_gso(skb). Otherwise it runs skb_checksum_help(), returns 1, and the
packet is delivered. The non-GSO tunnel case is also handled just above,
where the tunnel gso_type bits are cleared.

Could the comment say that non-GSO packets are completed in software?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.v5.git.mst%40redhat.com
