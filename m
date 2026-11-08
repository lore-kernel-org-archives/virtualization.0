Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794178919;
	b=Aq68Czvl9pS9kT4oIPxu8TvXWxvcSZieFYULWsawjNsff94M9++CJurA5B5enuHpWeXj
	 DlU3xBgz0gd8juNtWT49hoMg+pLLH4MKQAUxZNtBQ/weBPWjjLt1gwrpobIJGksAg3w4c
	 NJ3HNDSnmPQAZn6dnYQCbSQU/reOsNeFkBWWUOGJ3lquUQjeWCE5GD2KD0p9FTg7JvbYR
	 jaDUjx3AN3DED/rjuHYqKulW3FZiTHxPQBIqlN/nrTboHf/jmn/ftrZ0Fus3R1Mls66dy
	 GnDCYSsU7ll78khWMHS/KPz5/T+RN2Uu1LXuRJFoLYrOgHO8Wyf7EqCEjt5IAn0PW8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178919;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6ZkK4samTJMrnNmJvtK2T7YiW0T6RSP5zKzutrfl35w=;
	b=0tUCvRT+1vqju4wAhY8CMh7tlPG5fJlNVk+25XieP3L4WHQ3UJFbi5JmcQla1MO1k2gM
	 f2W45ut1VCuiUkrkKzdOE0rV0420bUr92D2cYokCxkws2jb5O9t+bzD1EFSVnDeJUp4hm
	 5F4NbsuAtiXwkpWUnBaMExCOlziCvYzKWpVFtblxrXdcSZuH8DD/w5TqAw14bGB3GJtn+
	 +HEmZ9RLGVGp1ihmrMSdQbNITJDD+ES8n1fbqrzAyeN7Yvz1XC6X58vdKfiiLeZsmMjNb
	 jsoMVpEc5IEjzchMz0vx+LVtWbCQmu1/V/+B2qc63nNZ9bZuNuScRjmSE1xvn0Ziq2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JeXnC572;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E41606A31C;
	Sun,  8 Nov 2026 23:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JeXnC572
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFBF1F0089F;
	Sun,  8 Nov 2026 23:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794178918;
	bh=6ZkK4samTJMrnNmJvtK2T7YiW0T6RSP5zKzutrfl35w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JeXnC572Fy+mmfzBSSLCctLlTF7JQ7RvPBcmTUkmpjex/lpYuyYUIb0s2ELWD8cNf
	 fGo+7nJ3ULmmoLV5CvYsek0/ngd272Scz+gZ27pWYGXMlKSycbzshozNfOiE49j/0M
	 4JpXuvU9MtGHkDGWDDTLDt8MdQ0Drd9DJ3WjY4+pViFdhPk2CLC2qKu8QGm65ElfT3
	 YxB4/P1o0j4DqCetEE6uvf4UWfpEqgRDXG/cNwGaWDRvHHdSr1Dm2/OevR8e5kqfGe
	 jyMpzgT5Z37K3finYMujgE8FiMAdgKuDvvPZNO2I5lvkEji5NHgUpRb3+rqJ52zPVA
	 gLMJheDo2bEKw==
Subject: Re: [PATCH net v3 1/8] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, mst@redhat.com,
 jasowangio@gmail.com, eperezma@redhat.com, hassansultan@google.com,
 virtualization@lists.linux.dev
Date: Sun, 08 Nov 2026 23:01:57 +0000
Message-ID: <179417891729.994134.12640335429551998744@kernel.org>
In-Reply-To: <20261105115715.1466924-2-edumazet@kernel.org>
References: <20261105115715.1466924-2-edumazet@kernel.org>
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

Critical: 0 · High: 3 · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch makes Linux drop VLAN-tagged UDP-tunnel GSO frames
  that Linux's own tap device sends.
- [High] virtio_net_hdr_tnl_from_skb() chooses the tunnel type with `if
  (skb->protocol == htons(ETH_P_IPV6)) ... UDP_TUNNEL_IPV6; else ...…
- [High] In this commit, virtio_net_l3_start()
  (include/linux/virtio_net.h:102-103) decides whether the frame has an…

Pre-existing issues:
- [Low] The concern is that virtio_net_hdr_tnl_to_skb() requires
  `outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6)`…

--

net: virtio: validate outer protocol of UDP tunnel GSO packets

This patch makes virtio_net_hdr_tnl_to_skb() check that the outer L3
header in the frame matches the declared UDP tunnel GSO type. It also
checks that the outer UDP header sits exactly at outer_th_offset. The L3
header is found from the device type, walking any VLAN tags on Ethernet
devices, which closes the skb_under_panic() crash caused by tunnel GSO
frames with a bogus outer ethertype such as ETH_P_NSH.

Link: https://lore.kernel.org/netdev/93d0e37c99711bebdf60c120af03010455c2f2e2.1793276116.git.mst@redhat.com/

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd00..357116c2a1489 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h

[ ... ]

> @@ -48,6 +51,147 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,

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

[Severity: High]
Can the Ethernet vs L3 choice here disagree with how tun actually frames
the packet?

tun picks the framing from tun->flags (IFF_TAP vs IFF_TUN). The fd owner
can change dev->type separately through TUNSETLINK:

drivers/net/tun.c:__tun_chr_ioctl() {
    ...
			tun->dev->type = (int) arg;
    ...
}

Take an IFF_TAP device retyped to ARPHRD_NONE. It goes into the else
branch below, which only reads the IP version byte at
skb_network_offset() (ETH_HLEN). The skb->protocol cross-check in that
branch does nothing, because skb->protocol is still 0 at this point.

Once validation passes, tun_get_user() sets the protocol from an h_proto
that was never checked:

drivers/net/tun.c:tun_get_user() {
    ...
	if ((tun->flags & TUN_TYPE_MASK) == IFF_TAP)
		skb->protocol = eth_type_trans(skb, tun->dev);
    ...
}

tun_xdp_one() does the same unconditionally.

With an h_proto of ETH_P_NSH, wouldn't this still reach nsh_gso_segment()
and the skb_under_panic() described in the commit message?

The reverse case, IFF_TUN retyped to ARPHRD_ETHER, appears to validate an
Ethernet header that the stack then parses as L3.

A later patch in the series, "net: virtio: do not use dev->type to find
the outer L3 header", seems to fix this. It passes an explicit has_eth
argument from tun_get_user(), tun_xdp_one() and virtnet_receive_done().
Since this commit has a Fixes: tag, could that change be folded in here?

> +		__be16 h_proto;
> +
> +		if (!pskb_may_pull(skb, ETH_HLEN))
> +			return false;
> +		h_proto = eth_hdr(skb)->h_proto;

[ ... ]

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

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. The
ETH_HLEN floor that virtio_net_hdr_tnl_to_skb() already applies seems to
assume an L2 header:

	outer_l3min = ETH_HLEN + virtio_l3min(outer_isv6);

For IFF_TUN, nhoff here is 0. A correctly formed L3-only tunnel GSO frame
(outer_th of 20 for IPv4) was rejected before this patch and is still
rejected.

This branch can still be reached: L3-only frames with at least 16 bytes
of IPv4 options, or enough IPv6 extension headers, clear the floor. The
series' selftests (outer_proto_ok and outer_proto_bad) exercise it.

So what remains is the old limitation on L3-only tunnel GSO. Is that
limitation intended?

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

[ ... ]

> @@ -282,6 +426,29 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
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

[Severity: High]
Does this reject IPv6-underlay tunnel GSO frames that virtio_net itself
sends when the VLAN tag is in-band?

virtio_net_l3_start() now walks past the VLAN tag and finds ETH_P_IPV6.
The sender, though, picks the tunnel type from skb->protocol:

include/linux/virtio_net.h:virtio_net_hdr_tnl_from_skb() {
    ...
	if (skb->protocol == htons(ETH_P_IPV6))
		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6;
	else
		hdr->gso_type |= VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4;
    ...
}

virtio_net does not advertise NETIF_F_HW_VLAN_CTAG_TX. So
validate_xmit_vlan() calls __vlan_hwaccel_push_inside(), which puts the
tag into the frame and sets skb->protocol to ETH_P_8021Q.

GSO_UDP_TUNNEL is kept, because virtio_net sets dev->vlan_features to
dev->features and virtnet_features_check() does not strip GSO.

Consider a guest with a VLAN subinterface on virtio_net and an IPv6 VXLAN
or Geneve device on top. xmit_skb() then declares
VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4. On the host,
tun_get_user()/tun_xdp_one() -> virtio_net_hdr_tnl_to_skb() finds IPv6
behind the 802.1Q tag and returns -EINVAL.

Before this patch, outer_isv6 only chose the minimum offsets, so these
frames were accepted.

The selftest outer_proto_bad_vlan_ipv6 later in the series expects this
layout to be rejected. However, virtio_net_hdr_tnl_from_skb() still picks
the tunnel type from skb->protocol at the end of the series.

Should the sender look past the VLAN tag as well? Should the commit
message also mention this behaviour change?

> +	if (!virtio_net_l4_start(skb, nhoff, proto, &thoff, &ip_proto))
> +		return false;
> +
> +	return ip_proto == IPPROTO_UDP && outer_th == thoff;
> +}

[Severity: High]
Can this exact match drop VLAN-tagged tunnel GSO frames that tun itself
writes to userspace?

thoff here is measured after the VLAN walk in virtio_net_l3_start(). On
the send side, virtio_net_hdr_tnl_from_skb() passes vlan_hlen only to
virtio_net_hdr_from_skb(), where it adjusts csum_start. The tunnel
offsets are computed without it:

	inner_nh = skb->inner_network_header - skb_headroom(skb);
	outer_th = skb->transport_header - skb_headroom(skb);

When the skb has a hardware-accelerated VLAN tag, tun_put_user() builds
the vnet header first. It then inserts the 4 byte tag after the MAC
addresses:

drivers/net/tun.c:tun_put_user() {
    ...
	if (vlan_hlen) {
		...
		vlan_offset = offsetof(struct vlan_ethhdr, h_vlan_proto);
    ...
}

With an IPv4 outer header, the vnet header then says outer_th_offset is
34, while UDP is at 38 in the bytes the guest sees.

A guest with this patch runs virtnet_receive_done() ->
virtio_net_hdr_tnl_to_skb(). It follows the tag to nhoff = 18, gets
thoff = 38, returns -EINVAL and counts rx_frame_errors. Before this patch
the same frame passed the existing range checks.

tap advertises NETIF_F_HW_VLAN_CTAG_TX and keeps GSO_UDP_TUNNEL in
vlan_features and hw_enc_features. A VLAN-filtering bridge or OVS with a
tagged port toward the VM's tap looks like enough to hit this.

The series adds outer_proto_bad_vlan_offset, which expects this layout to
be rejected. At the end of the series, virtio_net_hdr_tnl_from_skb()
still leaves vlan_hlen out of both outer_th_offset and inner_nh_offset.

Should the sender add vlan_hlen to both offsets as part of this change?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105115715.1466924-1-edumazet%40kernel.org
