Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218149;
	b=U/333gpdyQHopOjcpHhM6vPCvArnjHd3nmfyiUX5MWtOOAFI88MbdBE3frNHCjd16v9c
	 Lak9/Gasc9eW0oObHe0lEEOXEufYJenWVIxfQ47Hci+liQQSNqAkAWf6sIvWlp9C2aOwQ
	 zPWfkVWW1eAkgBSj1wtUHnPf8mQPhyeqocZgCX8U3BL7r4U3XA1Qkvjzm6xYUOgHORDaJ
	 Bj9C09Ev6yWwaFeHZg60a05xCiyB/dwXNykG2VppbokZk6QVlHewwuzuBFF+8ndLhQw3I
	 AXHuFBZU1aaNkvPYs8KCJw2WbVRmxcFTgT8IlDw9e1tov3/YrfoEDB8rL5mtZrYTCGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218149;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=2kS7qNxqF06hjCKC8fEyeKjUWUV8Pu6SASn8EXMiOk8=;
	b=eEbN1OjM1CeR41uGrjFzXfw21Jj/WrT2WthlwwHqBbYYLxj2x1MoxmLDqRAT5Pvu5D25
	 Ui5frvLZb3jeYfV2Frg4/XiI8glVdkk6gDWLVyqxGQ4YRgyjnPw38Iexkf15oIPK360Hd
	 yo/XtncNlyLu/sU02soiEvjxARQb03KCAdy93C7uqejRzcvojxRw0phRSJ/iu3b2dydxw
	 ggpSGLyDn9GctYsMsNGNiY5PVm/vtJkodU0RtxEfC7oCL0ISCU1GnCMEKbXBEB8A8B/0o
	 c1CsxVw7ph3h1OOopuXW09sk668VdHcu2oPSBqayUR941wrd96l/sk+YDVSePSjgu5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYXtlQQ3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71D4606A31C;
	Mon,  9 Nov 2026 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYXtlQQ3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AA81F008A1;
	Mon,  9 Nov 2026 09:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794218148;
	bh=2kS7qNxqF06hjCKC8fEyeKjUWUV8Pu6SASn8EXMiOk8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mYXtlQQ3AU5gJigOCf34O6QC51fVY5KBDLWEl+xbx+LS3SzNrbz8URsSbFIWhKytn
	 rpJGwzGJhScF3ZTcHS9VcYMHAzfyXAeKRgnVVaYtsIj0iiXb4bOlktx5oeQ77Z+Okq
	 1ASDVm5oqJZQ/YywjT2dvQKAhKOAy0y2tV9b5dOYERy2m6tgEv/Z2IPQyQbQzyWhZ3
	 I230V1r4rJZ3QLwrVQD0cXP36XJ2pooohfwTk2zlXzNgkAjn/4Ztqt2BW7TwZlVaIS
	 QXaXCN0SxknMH1ge/OjQ9Pr4wrY7xa/5TagYg2bIHSYcxK9CIeeiNEPvWDysP7LZgk
	 Wccv4Myae35UQ==
Subject: Re: [PATCH net v4 1/2] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, hassansultan@google.com,
 virtualization@lists.linux.dev
Date: Mon, 09 Nov 2026 09:55:47 +0000
Message-ID: <179421814766.994134.3669228181251158303@kernel.org>
In-Reply-To: <20261106095340.2113683-2-edumazet@kernel.org>
References: <20261106095340.2113683-2-edumazet@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new strict outer-offset check rejects UDP-tunnel GSO
  frames that the kernel's own tun TX path produces whenever the skb…

Pre-existing issues:
- [Low] In virtio_net_hdr_tnl_to_skb(), outer_l3min = ETH_HLEN +
  virtio_l3min(outer_isv6) (include/linux/virtio_net.h:491).

--

net: virtio: validate outer protocol of UDP tunnel GSO packets

This commit makes virtio_net_hdr_tnl_to_skb() check that the frame's outer
L3 protocol matches the declared tunnel type. It also checks that the outer
UDP header sits exactly at outer_th_offset. Callers pass a new has_eth
argument that says whether the frame starts with an Ethernet header. This
closes a path where an arbitrary outer ethertype combined with
SKB_GSO_UDP_TUNNEL could crash the host in skb_under_panic().

Link: https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com/

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd00..b7b6b542f4763 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h

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
> +	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
> +		return false;
> +
> +	return ip_proto == IPPROTO_UDP && outer_th == thoff;

[Severity: Medium]

Can this exact match reject UDP tunnel GSO frames that tun itself produces
when the skb carries a VLAN hwaccel tag?

On the producer side, tun_put_user() writes the 802.1Q tag into the frame
it copies to userspace or vhost-net. It calls tun_vnet_hdr_tnl_from_skb()
with vlan_hlen = VLAN_HLEN. Only csum_start accounts for the tag:

include/linux/virtio_net.h:virtio_net_hdr_from_skb() {
    ...
		hdr->csum_start = __cpu_to_virtio16(little_endian,
			skb_checksum_start_offset(skb) + vlan_hlen);
    ...
}

The tunnel offsets do not:

include/linux/virtio_net.h:virtio_net_hdr_tnl_from_skb() {
    ...
	inner_nh = skb->inner_network_header - skb_headroom(skb);
	outer_th = skb->transport_header - skb_headroom(skb);
	vhdr->inner_nh_offset = cpu_to_le16(inner_nh);
	vhdr->outer_th_offset = cpu_to_le16(outer_th);
    ...
}

So outer_th_offset and inner_nh_offset both end up 4 bytes short of the
real UDP and inner headers in the emitted frame.

On the consumer side, with has_eth set, virtio_net_l3_start() walks the
in-band VLAN tag with __vlan_get_protocol(). That gives nhoff = 18, so
thoff points at the real UDP header (38 for IPv4). The emitted outer_th is
34, this comparison fails, and virtio_net_hdr_tnl_to_skb() returns -EINVAL.

Before this patch the same frame was accepted. Only transport_header was
off by 4, and ip_rcv_core() and ip6_rcv_core() reset it for local delivery.

With this change, would a guest that gets these frames from a host tap
drop them in virtnet_receive_done() as "bad gso" and bump
rx_frame_errors? A tun/tap writer that re-injects frames it read from
another tun would see the same rejection.

This looks reachable with VLAN-tagged UDP tunnel GSO traffic. Two examples
are a VLAN filtering bridge with a tagged egress port, and a vlan device on
top of a tap. tun advertises NETIF_F_HW_VLAN_CTAG_TX/STAG_TX in
hw_features and hw_enc_features, so the tag stays in hwaccel until
tun_put_user().

The later patch in this series, "tun: clear stale skb->protocol of NAPI
frags skbs", does not seem to fix the producer side. Should
virtio_net_hdr_tnl_from_skb() add vlan_hlen to outer_th_offset and
inner_nh_offset, with that fix landing with or before this check?

> +}
> +
>  static inline int
>  virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  			  const struct virtio_net_hdr_v1_hash_tunnel *vhdr,
> +			  bool has_eth,
>  			  bool tnl_hdr_negotiated,
>  			  bool tnl_csum_negotiated,
>  			  bool little_endian)
> @@ -338,6 +504,9 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	if (ret)
>  		return ret;
>  
> +	if (!virtio_net_tnl_offsets_ok(skb, has_eth, outer_isv6, outer_th))
> +		return -EINVAL;
> +

[Severity: Low]

This is a pre-existing issue, not one introduced by this patch, but does
the has_eth = false path ever see ordinary IFF_TUN frames?

Earlier in virtio_net_hdr_tnl_to_skb(), the minimum outer offset still
assumes an Ethernet header, whatever has_eth says:

	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);
	...
	if (outer_th < outer_l3min ||

For IFF_TUN, tun_get_user() passes has_eth = false and the network header
is at offset 0. virtio_net_tnl_offsets_ok() therefore needs outer_th == 20
for plain IPv4 or 40 for plain IPv6. Both values are below the 34/54 floor,
so these frames are rejected before the new check runs.

That leaves the !has_eth branch of virtio_net_l3_start() reachable only for
outer IPv4 with at least 16 bytes of options, or outer IPv6 with at least
16 bytes of extension headers. The L3-relative offsets produced by tun TX
and by the selftest helper build_virtio_net_hdr_v1_hash_tunnel()
(eth_hlen = 0 for !is_tap) are still rejected.

The ETH_HLEN floor dates from a2fb4bc4e2a6. Now that callers pass has_eth,
should outer_l3min depend on it?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106095340.2113683-1-edumazet%40kernel.org
