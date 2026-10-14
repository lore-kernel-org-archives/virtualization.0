Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9284F68C3;
	Wed, 14 Oct 2026 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791975575; cv=none; b=iUdTq9Q1L/wZaJHRxdKXYuk8s9fJJiGakhnyp5yMVKJUO+srRGHOXJbMIHGmPCmb4Q40vjhoyVqaDUEVRbewgCnJHmykhMNQHxkbKnBYeqSGPUFdUD1UkkDl9QZdCikxfEes30hiYI5PNjYMMozSDTW3N5ltRQDwQ8DyMdOKY68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791975575; c=relaxed/simple;
	bh=i7V/wb3Ri+OtDDwcd1mNdPscEg+OgEwisa1tBO4X4EI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EKgsn46az3i7gMFwxaVkusKO/x8k2ZfK5dYHQFoo5zcvriv5f5NgM1XhUdx0nsGqYL0cCfwG6kj1xm2VvI8XfdL/nMGOzUbzlFEc+tC7HarTm3InSoub/1EJF4xXOJMYPzWGAQn8eHcpDV33pkXNkHxkFYd7+D31y3FWJXzEvFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hv6I7XI1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hv6I7XI1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCF11F00893;
	Wed, 14 Oct 2026 10:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791975571;
	bh=MGKEtIZd2a3/apRUjvSP2t5AqoDIZkqiJ0Dot59bCuA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hv6I7XI175Pf/UfluO4zXK6XdlwB3Bj3sBmJ3LmpZOsxOjaeDQEL2R9yOBFbslOCM
	 bp5/NPidB2ekDl+wzAYQLoeGqu5iubT0hrBgH0PYhHmAvXUXvR4L/EaKN4z0oLFOsh
	 zQhxpb13tRF6tUZoYH/tXEmGGS0gCqnpOA64/pEUpACEjZ4aGIlo6PNppkqjXxXW5W
	 7LvEQqoo5rF74y0RA4MBA94U0lahboetycosNI9iSSvS/aR5yCLoLv0oFYVAsfPL41
	 Y7KciizbfQbyRg1gyO9xHRv16JQ6vWEzCAnl11BTGo8M6KkvYygXcJZor6WaUpHSry
	 t9aQvHbxnelAw==
Subject:
 Re: [PATCH net-next 3/4] net: resolve uncommon partial checksums at ingress
From: netdev-bot+sashiko@kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowangio@gmail.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, maxk@qualcomm.com, rusty@rustcorp.com.au,
 horms@kernel.org
Date: Wed, 14 Oct 2026 10:59:30 +0000
Message-ID: <179197557063.434549.17212425661137531928@kernel.org>
In-Reply-To:
 <e12c6a45aae251d1642af55d8d3121e554993a66.1791887415.git.mst@redhat.com>
References:
 <e12c6a45aae251d1642af55d8d3121e554993a66.1791887415.git.mst@redhat.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 5 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On the UDP-tunnel path, virtio_net_hdr_tnl_to_skb() checks
  CHECKSUM_PARTIAL only against the 'inner' IP/TCP/UDP header at…
- [Medium] With this patch applied, virtio_net_hdr_tnl_to_skb() in
  include/linux/virtio_net.h ends with `ret = skb_checksum_help(skb);…
- [Medium] On UML, the new skb_checksum_help() fallback in
  __virtio_net_hdr_to_skb() checksums the whole preallocated receive…
- [Medium] On UML, the patch's new rejection of GSO packets with
  unrecognised checksum metadata never takes effect.
- [Medium] On any device whose type is not ARPHRD_ETHER,
  virtio_net_csum_partial_ok() takes the L3 protocol only from…
- [Medium] For non-ARPHRD_ETHER devices that still carry Ethernet
  framing, chiefly loopback (ARPHRD_LOOPBACK, hard_header_len =…
- [Low] The commit "net: resolve uncommon partial checksums at ingress"
  is the actual fix for user-reachable checksum-metadata abuse, but it…
- [Low] The commit message does not state the user-visible accept/reject
  changes precisely, and it contains a typo that inverts its meaning.

--

net: resolve uncommon partial checksums at ingress

This commit validates the virtio net header csum_start and csum_offset at
ingress. CHECKSUM_PARTIAL is kept only when they match a parsed TCP or UDP
header behind Ethernet/VLAN and IPv4/IPv6. Other non-GSO partial checksums
are completed at once with skb_checksum_help(), unrecognized GSO is
rejected, and the UDP tunnel path checks the inner header the same way.

> We can't easily "complete the checksum" for GSO we don't recognize - GSO
> assumes knowledge of the protocol. We could segment ignoring the
> checksum then do whatever csum_start and csum_offset say, but that
> seems like an overkill for something that should happen.

[Severity: Low]

This isn't a bug, but should "something that should happen" read
"something that shouldn't happen"?

Could the commit message also spell out the accept/reject changes?

This patch removes two checks from __virtio_net_hdr_to_skb(): the
skb_transport_offset(skb) < nh_min_len check and the per-GSO-type
csum_offset checks. Non-GSO packets that used to fail with -EINVAL (and
were counted in tun's rx_frame_errors) are now accepted after
skb_checksum_help().

In the other direction, GSO packets are now rejected unless csum_start
matches a transport offset the kernel can parse. On non-ARPHRD_ETHER
devices that parse depends on skb->protocol and skb_network_offset().
The old code never used either of them.

> diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> index d6466f96cdd00..b181183118b3a 100644
> --- a/include/linux/virtio_net.h
> +++ b/include/linux/virtio_net.h

[ ... ]

> @@ -48,15 +52,111 @@ static inline int virtio_net_hdr_set_proto(struct sk_buff *skb,

[ ... ]

> +static inline bool
> +virtio_net_csum_partial_ok(struct sk_buff *skb, u8 hdr_gso_type)
> +{
> +	unsigned int nhoff;
> +	__be16 proto;
> +
> +	if (skb->dev->type == ARPHRD_ETHER) {
> +		if (!pskb_may_pull(skb, ETH_HLEN))
> +			return false;
> +		nhoff = ETH_HLEN;
> +		proto = eth_hdr(skb)->h_proto;
> +		if (eth_type_vlan(proto)) {
> +			proto = __vlan_get_protocol(skb, proto, &nhoff);
> +			if (!proto)
> +				return false;
> +		}
> +	} else {
> +		nhoff = skb_network_offset(skb);
> +		proto = skb->protocol;
> +	}

[Severity: Medium]

Can this reject valid NEEDS_CSUM GSO packets sent through AF_PACKET on
devices that aren't ARPHRD_ETHER? Examples are loopback, tun in IFF_TUN
mode, ipip/gre/sit and wireguard.

In packet_snd(), skb->protocol is only set when the socket protocol isn't
ETH_P_ALL, so it stays 0 for protocol-0 sockets. The protocol is only
derived from the headers after the vnet header has been converted:

net/packet/af_packet.c:packet_snd() {
    ...
	if (proto != htons(ETH_P_ALL))
		skb->protocol = proto;
    ...
	if (vnet_hdr_sz) {
		err = virtio_net_hdr_to_skb(skb, &vnet_hdr, vio_le());
		if (err)
			goto out_free;
		len += vnet_hdr_sz;
	}

	packet_parse_headers(skb, sock);

	if (vnet_hdr_sz)
		virtio_net_hdr_set_proto(skb, &vnet_hdr);
    ...
}

tpacket_snd() uses the same order.

When skb->protocol is 0, virtio_net_csum_partial_ok_at_offset() falls
into its final "else return false", even for a well-formed IPv4/TCP
packet. __virtio_net_hdr_to_skb() then returns -EINVAL for any GSO
packet, so sendmsg() rejects TSO packets that it used to accept.
Non-GSO packets always get a software checksum.

The non-NEEDS_CSUM GSO branch of __virtio_net_hdr_to_skb() already
handles a zero protocol:

	if (!skb->protocol) {
		skb->protocol = dev_parse_header_protocol(skb);
		if (!skb->protocol)
			virtio_net_hdr_set_proto(skb, hdr);
	}

Should the new check have a similar fallback?

[Severity: Medium]

A related question: is skb->protocol a reliable source for devices that
use Ethernet framing but aren't ARPHRD_ETHER? The main case is loopback,
which is ARPHRD_LOOPBACK with hard_header_len == ETH_HLEN.

In packet_snd(), skb->protocol comes from the user's sll_protocol.
loopback_xmit() then recomputes it from the frame bytes:

drivers/net/loopback.c:loopback_xmit() {
    ...
	skb->protocol = eth_type_trans(skb, dev);
    ...
}

A CAP_NET_RAW sender, possibly inside a user namespace, could set
sll_protocol to ETH_P_IP while h_proto names a different encapsulation
such as MPLS. This check would then accept CHECKSUM_PARTIAL against a
fake IPv4/TCP header at offset 14. The receive path would parse a
different layout, so csum_start could end up inside the real transport
header.

The ARPHRD_ETHER branch avoids this by parsing h_proto itself. Nobody has
shown this can be exploited, so it is speculative. Would parsing the
frame be safer for Ethernet-framed devices too?

[ ... ]

> @@ -104,11 +203,11 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  
>  		if (!skb_partial_csum_set(skb, start, off))
>  			return -EINVAL;
> -		if (skb_transport_offset(skb) < nh_min_len)
> -			return -EINVAL;
> +		if (need_csum_check)
> +			csum_partial_ok =
> +				virtio_net_csum_partial_ok(skb, hdr_gso_type);

[Severity: Low]

This replaces the weak skb_transport_offset(skb) < nh_min_len check.
Should the commit carry a Fixes: tag and Cc: stable?

Before this patch, csum_offset was only checked inside the GSO switch.
A non-GSO NEEDS_CSUM packet from a tun/tap user, a guest or an AF_PACKET
sender could therefore put the deferred checksum write almost anywhere
past byte 20, including in IP header fields.

The only Fixes: tag in the series is on the later commit "net: account
for ingress-resolved virtio net hdr state". That commit adds a counter
and does not contain this fix.

[ ... ]

> @@ -191,6 +284,17 @@ static inline int __virtio_net_hdr_to_skb(struct sk_buff *skb,
>  		}
>  	}
>  
> +	if ((hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) && !csum_partial_ok) {
> +		int err;
> +
> +		if (skb_is_gso(skb))
> +			return -EINVAL;

[Severity: Medium]

Does this rejection take effect for the UML vector driver?
raw_verify_header() ignores the return value:

arch/um/drivers/vector_transports.c:raw_verify_header() {
    ...
	skb_set_network_header(skb, ETH_HLEN);
	virtio_net_hdr_to_skb(skb, vheader, virtio_legacy_is_little_endian());
	return 0;
}

By the time -EINVAL is returned here, skb_partial_csum_set() has already
set CHECKSUM_PARTIAL at the offset from the header. The GSO block has
also set gso_size and gso_type. This happens more often on UML because
skb->len is still the untrimmed buffer length.

vector_legacy_rx() and vector_mmsg_rx() only drop the packet when
verify_header() returns a negative value:

arch/um/drivers/vector_kern.c:vector_legacy_rx() {
    ...
				if (header_check < 0) {
					dev_kfree_skb_irq(skb);
    ...
}

So the skb still reaches eth_type_trans() and napi_gro_receive() with
CHECKSUM_PARTIAL at an arbitrary offset. The later patch in the series
doesn't change this caller.

Should raw_verify_header() propagate the error?

> +
> +		err = skb_checksum_help(skb);
> +		skb->transport_header = old_transport;
> +		return err;
> +	}

[Severity: Medium]

Is skb->len the real packet length here for every caller? On UML,
prep_skb() sizes the skb to the whole receive buffer:

arch/um/drivers/vector_kern.c:prep_skb() {
    ...
	skb_put(result, vp->max_packet);
	result->data_len = len - vp->max_packet;
	result->len += len - vp->max_packet;
    ...
}

and vector_legacy_rx() only trims the skb after verify_header():

arch/um/drivers/vector_kern.c:vector_legacy_rx() {
    ...
				header_check = vp->verify_header(
					vp->header_rxbuffer, skb, vp);
    ...
			pskb_trim(skb, pkt_len - vp->rx_header_size);
    ...
}

vector_mmsg_rx() has the same order.

Take a non-GSO NEEDS_CSUM frame that virtio_net_csum_partial_ok() doesn't
recognize, for example tunneled traffic with an inner partial checksum.
skb_checksum_help() sums skb->len - offset bytes, which includes stale
bytes at the end of the buffer. It writes the folded result into the
packet and sets CHECKSUM_NONE. The later pskb_trim() doesn't correct the
checksum.

Before this patch these packets kept CHECKSUM_PARTIAL and were trimmed
correctly. Could they now be dropped with a bad L4 checksum, or forwarded
with a value computed from stale memory? The later patch in the series
doesn't change arch/um.

[ ... ]

> @@ -334,7 +440,7 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  
>  	/* Let the basic parsing deal with plain GSO features. */
>  	ret = __virtio_net_hdr_to_skb(skb, hdr, true,
> -				      hdr->gso_type & ~gso_tunnel_type);
> +				      hdr->gso_type & ~gso_tunnel_type, false);
>  	if (ret)
>  		return ret;
>  

[ ... ]

> @@ -368,7 +474,16 @@ virtio_net_hdr_tnl_to_skb(struct sk_buff *skb,
>  	skb->inner_mac_header = inner_nh + skb_headroom(skb);
>  	skb->transport_header = outer_th + skb_headroom(skb);
>  	skb->encapsulation = 1;
> -	return 0;
> +
> +	if (virtio_net_csum_partial_ok_at_offset(skb, gso_inner_type, inner_nh,
> +					       inner_proto))
> +		return 0;

[Severity: High]

Is it enough to anchor the check at inner_nh? inner_nh is taken straight
from vhdr->inner_nh_offset. Because need_csum_check is false in the call
above, the Ethernet/VLAN/IP parse from the start of the frame is skipped.
The outer offsets are only checked against each other:

include/linux/virtio_net.h:virtio_net_hdr_tnl_to_skb() {
    ...
	if (outer_th < outer_l3min ||
	    inner_nh < outer_th + sizeof(struct udphdr) ||
	    inner_th < inner_nh + inner_l3min)
		return -EINVAL;
    ...
}

Nothing checks that the real outer IP header is followed by UDP at
outer_th. Nothing checks that VLAN tags, IPv4 options or IPv6 extension
headers don't move the real transport header either.

Two senders can control these offsets:

  - a tun user with the tunnel vnet header, through tun_get_user() or
    tun_xdp_one() via tun_vnet_hdr_tnl_to_skb()
  - a host feeding a virtio_net guest with rx_tnl negotiated

Either one could put a fake IPv4/IPv6 plus TCP/UDP header at any
inner_nh and keep CHECKSUM_PARTIAL there. That includes inside IPv4
options, inside IPv6 extension headers, or in the outer L4 payload.

For small packets gso_size is never set, so a non-GSO skb with
CHECKSUM_PARTIAL and encapsulation set is accepted. A later
skb_checksum_help() in validate_xmit_skb(), or NIC offload after
forwarding, would then write 2 bytes at a place that need not match the
headers the stack parsed. That could be the real outer L4 port.

Doesn't this leave open the case the commit message describes ("later
checksum completion can modify the packet after protocol processing has
made decisions from it")? It also seems to fall short of "UDP tunnel
headers get the same handling on the inner header".

Would the outer headers need to be parsed from the start of the frame as
well?

> +
> +	if (skb_is_gso(skb))
> +		return -EINVAL;
> +
> +	ret = skb_checksum_help(skb);
> +	return ret ?: 1;

[Severity: Medium]

What do callers do with the 1 returned here after skb_checksum_help()
succeeds? At this revision every caller treats any non-zero value as an
error. For example, in virtnet_receive_done():

drivers/net/virtio_net.c:virtnet_receive_done() {
    ...
	if (virtio_net_hdr_tnl_to_skb(skb, &hdr->tnl_hdr, vi->rx_tnl,
				      vi->rx_tnl_csum,
				      virtio_is_little_endian(vi->vdev))) {
		...
		goto frame_err;
	}
    ...
}

tun_get_user() and tun_xdp_one() do the same through
tun_vnet_hdr_tnl_to_skb():

drivers/net/tun.c:tun_get_user() {
    ...
	if (tun_vnet_hdr_tnl_to_skb(tun->flags, features, skb, &hdr)) {
		atomic_long_inc(&tun->rx_frame_errors);
		err = -EINVAL;
		goto free_skb;
	}
    ...
}

As a result, non-GSO tunnel packets whose inner checksum metadata isn't
recognized are dropped and counted as frame errors instead of being
accepted.

The later commit "net: account for ingress-resolved virtio net hdr state"
in this series changes these callers to test for < 0 and documents the
return value of 1. Could that change be folded into this patch so the
series stays bisectable?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791887415.git.mst%40redhat.com
