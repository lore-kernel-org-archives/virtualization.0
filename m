Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867537;
	b=Noi19rJnrkRZ9UimI13MojiFjo+tI9h1/fdzo7sDOGgYcRzrCG4XmLHEHEfvLYG2dszl
	 SaqTVdm87RRt8f+2kv7CI6nUguJTlFl+zWJjpIkGLW46kisViwK1/+rCOsJaohEKI+VLo
	 P/rQyWcqnnJv4FZvI6q+D1RkvX0OglQgW+uUymsQweOfaXDryrcUG/z4FbGZ9trzHL9S4
	 38hA2JyMOqOHWSW28bDhGmstjLrTvJZBnmr+x54BwfMzqArGx1kPilnZMirgVkgLUe/EY
	 EWchUw9LxMDD/hRmYTpbgkq1o7EF2DIL/i8CKHHQplRmIo9Czx8+6sN3ievCQNFseaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867537;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=1zDfPviynLIvaee9l0jCILxTyyGvoF0wwovBplZNoF0=;
	b=4iQIwnRQm0MhX1ODG3agvv60i31pjXoyvmnUgkqBwikLa0Rh14TuhABGVej2mlzo0P8z
	 Jgl4WpYjVP6TsJD5AGz2uWRdtIdEcA7trOM4vsn3Q+CrJkuTqmcLy+58nX3rgoYWMxEKc
	 7DyymFhMeE7rkvOSJ+Hbl171vFF/Gx2kPrGCvJJjEK6mboIxiGSl6yjmJ0sEp5bcwO8P1
	 VxOvd1tz4/qfk/+el+EbDq4XpLdjHuwBJhyBkuX97r8oX1A9RnFkMa6Dh9gx44k/0aYUI
	 O8L/PV3OWYBxUtvzw46prI5CMczUm/gVDW+wAeZJxiIMkM9FvoW3/HIm2mlOopG4W9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IuvTqoAG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD49606A31B;
	Thu,  5 Nov 2026 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IuvTqoAG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E8A1F000C1;
	Thu,  5 Nov 2026 08:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793867537;
	bh=1zDfPviynLIvaee9l0jCILxTyyGvoF0wwovBplZNoF0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IuvTqoAGqVdUkyr7sq5rUUk0KkbVWj5Uygz+R8WRatRcxbvjjbp/re2lbkRerdCjc
	 j+TRzQXi6ov91S7yJhTP7XQghvTukzqoLXwvnVoa0b6AP5+iCQXVeGntQN+uONBv5R
	 GI5Yix/w6VkCf6i+rhymQHg4OTC21T1KkcweWPSnmk0Cnix/e2ChpNKWCyJ6rkDnsi
	 UtAPBoBHMY67K86lGGBqzrctYXuvZVknUbhkz+81tMDz8mLMHB/OTqB2oR4TD+7/fL
	 3YcNs6cwb3lt+EM1K/pqQJ9dOyJTsq2Ojmyeexo5jlAXK6ioYW+UhOlSe2xrVYvF4s
	 LaNzYThAD144A==
Subject: Re: [PATCH net 1/3] net: virtio: validate outer protocol of UDP
 tunnel GSO packets
From: netdev-bot+sashiko@kernel.org
To: edumazet@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com, mst@redhat.com,
 eperezma@redhat.com, hassansultan@google.com, virtualization@lists.linux.dev
Date: Thu, 05 Nov 2026 08:32:15 +0000
Message-ID: <179386753589.488856.11455181721004759454@kernel.org>
In-Reply-To: <20261103203113.550604-2-edumazet@kernel.org>
References: <20261103203113.550604-2-edumazet@kernel.org>
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

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The validation in virtio_net_tnl_outer_proto_ok()
  (include/linux/virtio_net.h) can be bypassed on IFF_TAP devices that…
- [Medium] virtio_net_tnl_outer_proto_ok() only checks the outer
  ethertype (or skb->protocol) and that a minimum-size IPv4/IPv6 header…
- [Low] virtio_net_tnl_outer_proto_ok() treats skb->protocol == 0 as
  meaning "Ethernet frame", and its comment says that for IFF_TUN "the…

--

net: virtio: validate outer protocol of UDP tunnel GSO packets

This patch adds virtio_net_tnl_outer_proto_ok(), called from
virtio_net_hdr_tnl_to_skb(). The new helper requires the outer L3
protocol of a UDP tunnel GSO packet to match the tunnel type declared
in the virtio header. For Ethernet frames it checks the ethertype after
optional VLAN tags, plus the outer network header size against
outer_th_offset. For IFF_TUN it relies on skb->protocol, which the
caller has already set.

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd00..d3f97d71d81cc 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h
> @@ -282,6 +282,31 @@ static inline unsigned int virtio_l3min(bool is_ipv6)
>  	return is_ipv6 ? sizeof(struct ipv6hdr) : sizeof(struct iphdr);
>  }
>  
> +/* The outer network header of a UDP tunnel GSO packet must match the
> + * tunnel type declared in the virtio header, otherwise the GSO stack
> + * would parse the packet as something else (e.g. NSH).
> + */
> +static inline bool virtio_net_tnl_outer_proto_ok(const struct sk_buff *skb,
> +						 bool outer_isv6,
> +						 unsigned int outer_th)
> +{
> +	__be16 expected = outer_isv6 ? htons(ETH_P_IPV6) : htons(ETH_P_IP);
> +	__be16 proto = skb->protocol;
> +	int nh_off = ETH_HLEN;
> +
> +	/* L3 device (IFF_TUN): the caller already set the protocol. */
> +	if (proto)
> +		return proto == expected;

[Severity: High]
Can a stale skb->protocol on an IFF_TAP device get past this check?

On the IFF_TAP path, tun_get_user() does not clear skb->protocol before
it calls tun_vnet_hdr_tnl_to_skb(). eth_type_trans() only sets it
afterwards:

drivers/net/tun.c:tun_get_user() {
    ...
	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
    ...
}

With IFF_NAPI_FRAGS, tun_napi_alloc_frags() gets its skb from
napi_get_frags(&tfile->napi), which returns the cached napi->skb. If GRO
merged the previous frame with GRO_MERGED_FREE, that skb was recycled
through:

napi_frags_finish()
  napi_reuse_skb()

napi_reuse_skb() resets dev, pkt_type, encapsulation, ip_summed, gso_type
and gso_size. It does not reset skb->protocol, which napi_frags_skb() had
set to the previous frame's eth->h_proto (for example ETH_P_IP).

On the next write, __virtio_net_hdr_to_skb() leaves skb->protocol alone
on the NEEDS_CSUM path. virtio_net_tnl_outer_proto_ok() then sees
htons(ETH_P_IP), takes the "L3 device" early return, and never reads the
real ethertype (for example ETH_P_NSH).

eth_type_trans() then sets skb->protocol to ETH_P_NSH on an skb that
carries SKB_GSO_UDP_TUNNEL. If that skb is forwarded (bridge to gretap)
and segmented in software, wouldn't nsh_gso_segment() run and hit the
same skb_under_panic() described in the commit message?

The setup needs a tap opened with IFF_TAP | IFF_NAPI_FRAGS
(CAP_NET_ADMIN). GRO also has to hold packets across writes, for
example with napi_defer_hard_irqs / gro_flush_timeout configured. Once
that is in place, a guest using vhost-net controls the frame contents.

Could the helper avoid inferring L2 vs L3 from skb->protocol? For
example, the caller could pass an explicit L2/L3 flag, or Ethernet
callers could always parse eth_hdr().

> +
> +	/* Ethernet frame, possibly VLAN tagged. */
> +	proto = eth_hdr(skb)->h_proto;
> +	if (eth_type_vlan(proto))
> +		proto = __vlan_get_protocol(skb, proto, &nh_off);

[Severity: Low]
Does IFF_TUN always set a non-zero skb->protocol, as the comment above
assumes?

For IFF_TUN without IFF_NO_PI, tun_get_user() copies the protocol
directly from the userspace struct tun_pi:

drivers/net/tun.c:tun_get_user() {
    ...
		skb_reset_network_header(skb);
		skb->protocol = pi.proto;
    ...
}

If pi.proto is 0, the L3 packet lands in this Ethernet branch.
eth_hdr(skb)->h_proto then reads bytes 12-13 of the IPv4/IPv6 header as
an ethertype, and the sender chooses those source address bytes. They
can also match a VLAN TPID and be parsed further by
__vlan_get_protocol().

With an IPv4 saddr that starts with 0x0800, the frame is accepted with
skb->protocol still 0 and SKB_GSO_UDP_TUNNEL set. The practical impact
looks small: no L3 handler takes protocol 0, and skb_mac_gso_segment()
would return -EPROTONOSUPPORT. Still, the write is accepted when it
presumably should fail with -EINVAL.

This is the same skb->protocol based L2/L3 test as above.

> +
> +	return proto == expected &&
> +	       nh_off + virtio_l3min(outer_isv6) <= outer_th;

[Severity: Medium]
Is checking only the ethertype and a minimum L3 size enough to stop GSO
from parsing the packet as something other than a UDP tunnel?

Nothing checks that the outer iph->protocol (or the IPv6 nexthdr chain)
is UDP. Nothing checks that the real outer header length (ihl,
extension headers) ends at outer_th either. GSO ignores the virtio
outer_th and dispatches from the IP header itself:

net/ipv4/af_inet.c:inet_gso_segment() {
    ...
	ops = rcu_dereference(inet_offloads[proto]);
    ...
}

For example, a frame with ethertype ETH_P_IP, iph->protocol =
IPPROTO_GRE and VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 passes this check.
gre_gso_segment() then tests only skb->encapsulation, which
virtio_net_hdr_tnl_to_skb() sets, and not SKB_GSO_GRE:

net/ipv4/gre_offload.c:gre_gso_segment() {
    ...
	if (!skb->encapsulation)
		goto out;
    ...
}

With IPPROTO_TCP the frame would reach tcp4_gso_segment(), because
gso_type also carries the inner SKB_GSO_TCPV4 bit.

With ihl > 5, or with IPv6 extension headers, __skb_udp_tunnel_segment()
derives tnl_hlen from the transport header that GSO recomputed:

	int tnl_hlen = skb_inner_mac_header(skb) - skb_transport_header(skb);

That value differs from the outer_th layout validated here and can be
smaller than a udphdr. The UDP len/check writes could then land on the
inner IP header.

I could not show a crash from this: pskb_may_pull() catches a negative
tnl_hlen, and gre_gso_segment() recomputes its own offsets. Would it
make sense to also require the outer L4 protocol to be UDP, and the
outer L3 header to end exactly at outer_th?

> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103203113.550604-1-edumazet%40kernel.org
